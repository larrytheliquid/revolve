module Revolve
  class Argument
    attr_accessor :name, :value
    def initialize(name, value)
      @name, @value = name, value
    end
  end
end