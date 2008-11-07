module Revolve end

require File.join(File.dirname(__FILE__), "lib", "variable")
require File.join(File.dirname(__FILE__), "lib", "argument")  
require File.join(File.dirname(__FILE__), "lib", "method")
require File.join(File.dirname(__FILE__), "lib", "program")
require File.join(File.dirname(__FILE__), "lib", "population")

# TODO: Raise errors if using option that does not exist
# TODO: Test against a separate test case set to ensure generalization
# TODO: describe/it syntax that can save programs to use if already evolved
# TODO: Make fitness case a class instead of passing lambdas?
# TODO: Elitism
# TODO: Use Mocha in fitness cases