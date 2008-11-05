module Revolve
  Spec::Runner.configure {|config| config.mock_with :mocha }
  
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
  
  describe Program do
    before { @program = Program.new }
    
    it "should be a kind of Array" do
      @program.should be_kind_of(Array)
    end
  end

  describe Program, "#run" do              
    describe "with objects" do
      before { @program = Program.new(4) }
      
      it "should add them to the stack" do
        @program.run
        @program.stack.first.should == 4
      end
    end
    
    describe "with methods and insufficient arguments" do
      before { @program = Program.new( 3, Method.new(:+, Integer) ) }
      
      it "should ignore method and return nil" do
        @program.run.should be_nil
      end
      
      it "should not affect the stack" do
        @program.run
        @program.stack.should == [3]
      end
    end
    
    describe "with methods that do not require arguments" do
      before { @program = Program.new( 4, 1336, Method.new(:next) ) }        
      
      it "should execute method on stack object with stack arguments" do
        @program.run.should == 1337
      end
      
      it "should remove items from the stack equal to 1 + method arity, and add result back" do
        @program.run
        @program.stack.should == [4, 1337]
      end
    end
    
    describe "with methods and sufficient arguments" do
      before { @program = Program.new( 4, 3, Method.new(:+, Integer) ) }        
      
      it "should execute method on stack object with stack arguments" do
        @program.run.should == 7
      end
      
      it "should remove items from the stack equal to 1 + method arity, and add result back" do
        @program.run
        @program.stack.should == [7]
      end
    end
  end
  
  class Method
    attr_reader :name, :arguments
    def initialize(name, *arguments)
      @name, @arguments = name, arguments
    end
    
    def arity
      arguments.size
    end
  end
  
  describe Method do
    before { @method = Method.new(:+, Integer) }
    
    it "should have a Symbol name" do
      @method.name.should == :+
    end
    
    it "should have Class arguments" do
      @method.arguments.should == [Integer]
    end
    
    it "should have an arity based on the number of arguments" do
      @method.arity.should == 1
    end
  end
end