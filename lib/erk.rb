module Revolve
  # Ephemeral Random Constant
  class ERK < Array
    def initialize(*args)
      block_given? ? super(*args) : super(args)
    end
    
    def value
      self[ rand(self.size) ]
    end
  end
end