module Revolve
  class Program < Array
    attr_accessor :stack
    def initialize(*args)
      @stack = []
      block_given? ? super(*args) : super(args)
    end
    
    def self.randomized(length, instructions)
      self.new(length) { instructions[ rand(instructions.size) ] }
    end        
    
    def run(*arguments)
      arguments.flatten!
      self.each do |intruction|
        if intruction.is_a?(Revolve::Method) && intruction.stack = stack          
          intruction.call! if intruction.callable?
        elsif intruction.is_a?(Revolve::Variable)
          stack.push arguments.detect{|argument| argument.name == intruction.name }.value
        else
          stack.push intruction
        end
      end
      result = stack.last
      stack.clear
      result
    end
    
    def reproduce
      self.dup
    end
    
    def crossover(mate)
      self.random_subset + mate.random_subset
    end
    
    def mutate(mutation)
      result = self.dup
      result[rand(self.size)] = mutation
      result.flatten
    end
    
    def +(program)
      self.class.new *(self.concat(program))
    end
    
    def random_slice
      rand(2) == 1 ? self.slice_left : self.slice_right
    end
    
    def random_subset
      self.slice( rand(self.size) / 2, rand(self.size) / 2 + 1 )
    end
    
    def slice_left
      self.slice( 0, rand(self.size).next )
    end
    
    def slice_right
      self.slice( -rand(self.size).next, self.size )
    end
  end
end