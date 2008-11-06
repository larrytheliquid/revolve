module Revolve
  class Argument
    attr_accessor :name, :value
    def initialize(name, value)
      @name, @value = name, value
    end
    
    def inspect
      "(:#{name} => #{value} argument)"
    end
    alias_method :to_s, :inspect
  end
end