module Revolve
  class Method
    attr_accessor :name, :stack
    def initialize(name)
      @name = name
    end

    def callable?
      return false unless stack
      stack.first.respond_to?(name) && (stack.size - 1 >= stack.first.method(name).arity)
    end
  end
end