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
    
    def run
      self.each do |intruction|
        if intruction.is_a?(Revolve::Method) && intruction.stack = stack          
          intruction.call! if intruction.callable?
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
      [self, mate].inject {|x, y| x.random_slice + y.random_slice }
    end
    
    def mutate(mutation)
      random_slice + mutation
    end
    
    def +(program)
      self.class.new *(self.concat(program))
    end
    
    def random_slice
      rand(2) == 1 ? self.slice_left : self.slice_right
    end
    
    def slice_left
      self.slice( 0, rand(self.size) )
    end
    
    def slice_right
      self.slice( -rand(self.size), self.size )
    end
  end
end