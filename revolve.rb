module Revolve end

require File.join(File.dirname(__FILE__), "lib", "variable")
require File.join(File.dirname(__FILE__), "lib", "argument")  
require File.join(File.dirname(__FILE__), "lib", "method")
require File.join(File.dirname(__FILE__), "lib", "program")
require File.join(File.dirname(__FILE__), "lib", "population")

# TODO: Elitism
# TODO: Tournament selection only selects better fitness 75% of the time