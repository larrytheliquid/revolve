module Revolve
  class Program < Array
    attr_reader :stack
    def initialize(*args)
      @stack = []
      super args.to_ary
    end
    
    def run
      result = nil
      self.each do |item|
        if item.is_a?(Method)
          if stack.size >= (item.arity + 1)
            target = stack.pop
            arguments = if item.arity >= 0
              [item.name] + (1..item.arity).map{ stack.pop }
            else
              [item.name]
            end
            result = target.send(*arguments)
            stack.push(result)
          end
        else
          stack.push(item)
        end        
      end
      result
    end
  end
end