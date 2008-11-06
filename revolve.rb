module Revolve end

require File.join(File.dirname(__FILE__), "lib", "variable")
require File.join(File.dirname(__FILE__), "lib", "argument")  
require File.join(File.dirname(__FILE__), "lib", "method")
require File.join(File.dirname(__FILE__), "lib", "program")
require File.join(File.dirname(__FILE__), "lib", "population")

# TODO: Examples: (x^2), ((x+1)^3), (sin(x) [-pi/4, pi/4] [-pi/2, pi/2])
# TODO: Make fitness case a class instead of passing lambdas?
# TODO: Elitism
# TODO: Tournament selection only selects better fitness 75% of the time
# TODO: Use Mocha in fitness cases