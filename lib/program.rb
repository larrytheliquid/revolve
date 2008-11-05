module Revolve
  class Program < Array
    attr_accessor :stack
    def initialize(*args)
      @stack = []
      super args.to_ary
    end
    
    def run
      self.each do |intruction|
        if intruction.is_a?(Revolve::Method) && intruction.stack = stack          
          intruction.call! if intruction.callable?
        else
          stack.push intruction
        end
      end
      stack.last
    end
  end
end