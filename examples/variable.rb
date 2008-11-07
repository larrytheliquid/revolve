require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

# x
population = Revolve::Population.initialized( 200, {  
  :size_limit => 10,
  :instructions => [ 1, 2, 3, 4, 5, 6, 7, 8, 9,
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x) ],
  :generations_limit => 500,                    
  :fitness_cases => [ lambda{|program| program.run( Revolve::Argument.new(:x, 13) ).to_i == 13 },
                      lambda{|program| program.run( Revolve::Argument.new(:x, 21) ).to_i == 21 },
                      lambda{|program| program.run( Revolve::Argument.new(:x, 34) ).to_i == 34 },
                      lambda{|program| program.run( Revolve::Argument.new(:x, 55) ).to_i == 55 } ],
  :error_function => lambda{|cases| cases.inject{|x, y| x && y } ? 0 : 12345 },
  :elitism_percent => 0.05,
  :crossover_percent => 0.6,
  :mutation_percent => 0.3
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Error: #{population.error(population.fittest)}"
puts "Program:\n#{population.fittest.inspect}"
input = Revolve::Argument.new(:x, 34)
puts "Input: #{input}"
puts "Output: #{population.fittest.run(input)}"