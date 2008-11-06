require File.join(File.dirname(__FILE__), "..", "revolve")

class Integer
  def protected_division(divisor)
    self / divisor rescue 1
  end
end

population = Revolve::Population.initialized( 200, {  
  :program_size => 10,
  :instructions => [ 1, 2, 3, 4, 5, 6, 7, 8, 9,
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x), Revolve::Variable.new(:y) ],
  :max_generations => 500,                    
  :fitness_cases => [ lambda{|program| program.run( Revolve::Argument.new(:x, 13),
                                                    Revolve::Argument.new(:y, 10)).to_i - 3 },
                      lambda{|program| program.run( Revolve::Argument.new(:x, 25),
                                                    Revolve::Argument.new(:y, 64)).to_i - -39 },
                      lambda{|program| program.run( Revolve::Argument.new(:x, 900),
                                                    Revolve::Argument.new(:y, 367)).to_i - 533 },
                      lambda{|program| program.run( Revolve::Argument.new(:x, 56),
                                                    Revolve::Argument.new(:y, -800)).to_i - -734 }],
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