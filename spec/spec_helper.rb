Spec::Runner.configure do |config| 
  config.mock_with :mocha
end

require File.join(File.dirname(__FILE__), "..", "revolve")