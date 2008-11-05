Spec::Runner.configure do |config| 
  config.mock_with :mocha
end

require File.join(File.dirname(__FILE__), "..", "revolve")

def new_population(options={})  
  Revolve::Population.initialized(options.delete(:size) || 3, 
    {:instructions => ["kitteh", 2, 8, Revolve::Method.new(:+)], 
    :max_generations => 30,
    :program_size => 10,
    :crossover_chance => 0.8,
    :mutation_chance => 0.05}.merge(options))
end