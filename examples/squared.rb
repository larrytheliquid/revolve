require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

def cases(num, value)
  (1..num).map do |i|
    lambda do |program|
      argument = value + i
      program.run( Revolve::Argument.new(:x, argument) ).to_i - argument**2
    end
  end
end

# x**2
population = Revolve::Population.initialized( 200, {  
  :program_size => 10,
  :instructions => [ 1, 2, 3, 4, 5, 6, 7, 8, 9,
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x) ],
  :max_generations => 500,                    
  :fitness_cases => cases(6, 1),
  :fitness_combinator => lambda{|cases| cases.inject{|x, y| x.abs + y.abs } },
  :elitism_percent => 0.05,
  :crossover_percent => 0.6,
  :mutation_percent => 0.3
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Fitness: #{population.fitness(population.fittest_program)}"
puts "Program:\n#{population.fittest_program.inspect}"
input = Revolve::Argument.new(:x, 8)
puts "Input: #{input}"
puts "Output: #{population.fittest_program.run(input)}"