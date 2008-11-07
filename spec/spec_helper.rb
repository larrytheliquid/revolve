Spec::Runner.configure do |config| 
  config.mock_with :mocha
end

require File.join(File.dirname(__FILE__), "..", "revolve") unless defined? Revolve

def new_population(options={})  
  Revolve::Population.initialized(options.delete(:size) || 3, 
    {:instructions => ["kitteh", 2, 8, Revolve::Method.new(:+)], 
    :generations_limit => 30,
    :size_limit => 10}.merge(options))
end