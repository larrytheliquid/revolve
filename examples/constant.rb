require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    return 1 if divisor == 0
    self / divisor
  end
end

# 120
population = Revolve::Population.initialized( 200, {  
  :size_limit => 20,
  :instructions => [ Revolve::ERK.new(-5, -4, -3, -2, -1, 1, 2, 3, 4, 5),
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division) ],
  :generations_limit => 500,                    
  :fitness_cases => [ lambda{|program| program.run.to_i - 120 } ],
  :error_function => lambda{|cases| cases.first.abs },
  :elitism_percent => 0.35,
  :crossover_percent => 0.45,
  :mutation_percent => 0.1
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Error: #{population.error(population.fittest)}"
puts "Program:\n#{population.fittest.inspect}"
puts "Output: #{population.fittest.run}"