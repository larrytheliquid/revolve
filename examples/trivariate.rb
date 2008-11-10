require File.join(File.dirname(__FILE__), "..", "revolve")

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
      program.run( Revolve::Argument.new(:x, argument), Revolve::Argument.new(:y, argument + 1), Revolve::Argument.new(:z, argument + 2) ).to_i - ((argument + 1)**2 + (argument + 2)**2 + (argument + 3)**2)
    end
  end
end

# x**2
population = Revolve::Population.initialized( 200, {  
  :size_limit => 20,
  :instructions => [ Revolve::ERK.new(-5, -4, -3, -2, -1, 1, 2, 3, 4, 5),
                     Revolve::Method.new(:+), Revolve::Method.new(:-), 
                     Revolve::Method.new(:*), Revolve::Method.new(:protected_division),
                     Revolve::Variable.new(:x), Revolve::Variable.new(:y), Revolve::Variable.new(:z) ],
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
input = [Revolve::Argument.new(:x, 8), Revolve::Argument.new(:y, 9), Revolve::Argument.new(:z, 10)]
puts "Input: #{input}"
puts "Output: #{population.fittest.run(input)}"