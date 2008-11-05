require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Program, "#run" do 
  describe "with a non-empty stack" do
    before do
      @program = Program.new( 2, 8, Method.new(:+) )
      @program.stack = ["kitteh", 1337]
    end
    
    it "should just return the top item of the stack" do
      @program.run.should == 1337
    end
  end
  
  describe "with an empty stack" do
    describe "with objects" do
      before { @program = Program.new(4) }

      it "should add them to the stack" do
        @program.run
        @program.stack.first.should == 4
      end
    end

    describe "with methods that are not callable" do
      before { @program = Program.new( 3, Method.new(:+) ) }

      it "should ignore method and return the top stack item" do
        @program.run.should == 3
      end

      it "should not affect the stack" do
        @program.run
        @program.stack.should == [3]
      end
    end

    describe "with methods that are callable" do
      before { @program = Program.new( "kitteh", 2, 8, Method.new(:+) ) }        

      it "should execute method on stack object with stack arguments" do
        @program.run.should == 10
      end

      it "should remove items from the stack equal to 1 + method arity, and add result back" do
        @program.run
        @program.stack.should == ["kitteh", 10]
      end
    end
  end            
end

end