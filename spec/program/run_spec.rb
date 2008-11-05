require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Program, "#run" do              
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