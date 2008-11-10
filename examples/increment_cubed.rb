require File.join(File.dirname(__FILE__), "..", "revolve")

puts "Warning: This converges but takes long due to cubic operations."

class Integer
  def protected_division(divisor)
    return 1 if divisor == 0
    self / divisor
  end
end

def cases(num, value)
  (1..num).map do |i|
    lambda do |program|      
      argument = value + i
      program.run( Revolve::Argument.new(:x, argument) ).to_i - (argument + 1)**3
    end
  end
end

# (x+1)**3
population = Revolve::Population.initialized( 200, {  
  :size_limit => 20,
  :instructions => [ Revolve::ERK.new(-5, -4, -3, -2, -1, 1, 2, 3, 4, 5),
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x) ],
  :generations_limit => 1_000,                    
  :fitness_cases => cases(10, 1),
  :error_function => lambda{|cases| cases.inject{|x, y| x.abs + y.abs } },
  :elitism_percent => 0.35,
  :crossover_percent => 0.45,
  :mutation_percent => 0.1
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Error: #{population.error(population.fittest)}"
puts "Program:\n#{population.fittest.inspect}"
input = Revolve::Argument.new(:x, 13)
puts "Input: #{input}"
puts "Output: #{population.fittest.run(input)}"