require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

population = Revolve::Population.initialized( 200, {  
  :program_size => 10,
  :instructions => [1, 2, 3, 4, 5, 6, 7, 8, 9,
                    Revolve::Method.new(:+), Revolve::Method.new(:-), 
                    Revolve::Method.new(:*), Revolve::Method.new(:protected_division)],
  :max_generations => 500,                    
  :fitness_cases => [ lambda{|program| program.run.to_i - 120 } ],
  :fitness_combinator => lambda{|cases| cases.first.abs },
  :crossover_chance => 0.6,
  :mutation_chance => 0.3
})

population.evolve!

puts "Generations: #{population.generation}"
puts "Fitness: #{population.fitness(population.fittest_program)}"
puts "Program:\n#{population.fittest_program.inspect}"
puts "Output: #{population.fittest_program.run}"