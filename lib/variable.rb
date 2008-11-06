module Revolve
  class Variable
    attr_accessor :name
    def initialize(name)
      @name = name
    end
    
    def inspect
      "(:#{name} variable)"
    end
    alias_method :to_s, :inspect
  end
end