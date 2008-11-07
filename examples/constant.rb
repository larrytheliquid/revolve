require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

# 120
population = Revolve::Population.initialized( 200, {  
  :size_limit => 10,
  :instructions => [ 1, 2, 3, 4, 5, 6, 7, 8, 9,
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division) ],
  :generations_limit => 500,                    
  :fitness_cases => [ lambda{|program| program.run.to_i - 120 } ],
  :error_function => lambda{|cases| cases.first.abs },
  :elitism_percent => 0.05,
  :crossover_percent => 0.6,
  :mutation_percent => 0.3
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Error: #{population.error(population.fittest)}"
puts "Program:\n#{population.fittest.inspect}"
puts "Output: #{population.fittest.run}"