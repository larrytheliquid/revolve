require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

def cases(num, value)
  (1..num).map do |i|
    lambda do |program|
      argument = value + i*2
      program.run( Revolve::Argument.new(:x, argument) ).to_i - (argument**2 + argument + 1)
    end
  end
end

# x**2 + x + 1
population = Revolve::Population.initialized( 200, {  
  :size_limit => 20,
  :instructions => [ 1, 2, 3, 4, 5, 6, 7, 8, 9,
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x) ],
  :generations_limit => 500,                    
  :fitness_cases => cases(6, 1),
  :error_function => lambda{|cases| cases.inject{|x, y| x.abs + y.abs } },
  :elitism_percent => 0.3,
  :crossover_percent => 0.6,
  :mutation_percent => 0.0
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Error: #{population.error(population.fittest)}"
puts "Program:\n#{population.fittest.inspect}"
input = Revolve::Argument.new(:x, 14)
puts "Input: #{input}"
puts "Output: #{population.fittest.run(input)}"