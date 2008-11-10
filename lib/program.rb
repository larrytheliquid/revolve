# TODO: pass in stack copy for thread safety
module Revolve
  class Program < Array
    attr_accessor :stack
    def initialize(*args)
      @stack = []
      result = block_given? ? super(*args) : super(args)
      result.each_with_index{|instruction, index| result[index] = instruction.value if instruction.is_a?(ERK) }
      result
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
    
    def crossover(mate)
      self.random_subset + mate.random_subset
    end
    
    def mutate(instructions, size_limit)
      result = self.dup
      result.each_with_index do |inst, index| 
        if rand < (1.5 / (size_limit*0.5))
          instruction = instructions[rand(instructions.size)]
          result[index] = instruction.is_a?(ERK) ? instruction.value : instruction
        end
      end
      result
    end
    
    def +(program)
      self.class.new *(self.concat(program))
    end
    
    def random_slice
      rand(2) == 1 ? self.slice_left : self.slice_right
    end
    
    def random_subset
      self.slice( rand(self.size), rand(self.size) + 1 )
    end
  end
end