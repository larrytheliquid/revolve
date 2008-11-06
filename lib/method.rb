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
    
    def call!
      target = stack.pop
      arguments = [name]
      target.method(name).arity.times { arguments.push(stack.pop) }
      stack.push( target.send(*arguments) ).last
    end
    
    def inspect
      "(:#{name} method)"
    end
    alias_method :to_s, :inspect
  end
end