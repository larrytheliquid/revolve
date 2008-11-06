require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

def cases(num, step, first, second)
  (1..num).map do |i|
    lambda do |program|
      first = first + step*i
      program.run( Revolve::Argument.new(:x, first), 
                   Revolve::Argument.new(:y, second)).to_i - (first - second)
    end
  end
end

# x - y
population = Revolve::Population.initialized( 200, {  
  :program_size => 10,
  :instructions => [ 1, 2, 3, 4, 5, 6, 7, 8, 9,
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x), Revolve::Variable.new(:y) ],
  :max_generations => 500,                    
  :fitness_cases => cases(20, 6, 10, 34),
  :fitness_combinator => lambda{|cases| cases.inject{|x, y| x.abs + y.abs } },
  :crossover_percent => 0.6,
  :mutation_percent => 0.3
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Fitness: #{population.fitness(population.fittest_program)}"
puts "Program:\n#{population.fittest_program.inspect}"
input = [Revolve::Argument.new(:x, 900), Revolve::Argument.new(:y, 367)]
puts "Input: #{input}"
puts "Output: #{population.fittest_program.run(input)}"