require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Program, "#run" do 
  describe "with objects" do
    before { @program = Program.new(4) }

    it "should return the object on top of the stack" do
      @program.run.should == 4
    end
    
    it "should empty the stack" do
      @program.run
      @program.stack.should be_empty
    end
  end
  
  describe "with variables" do
    before { @program = Program.new(Variable.new(:x)) }

    it "should return the variable value on top of the stack" do
      @program.run(Argument.new(:x, 1337)).should == 1337
    end
    
    it "should empty the stack" do
      @program.run(Argument.new(:x, 1337))
      @program.stack.should be_empty
    end
  end

  describe "with methods that are not callable" do
    before { @program = Program.new( 3, Method.new(:+) ) }

    it "should ignore method and return the top stack item" do
      @program.run.should == 3
    end

    it "should empty the stack" do
      @program.run
      @program.stack.should be_empty
    end
  end

  describe "with methods that are callable" do
    before { @program = Program.new( "kitteh", 2, 8, Method.new(:+) ) }        

    it "should execute method on stack object with stack arguments" do
      @program.run.should == 10
    end
    
    it "should empty the stack" do
      @program.run
      @program.stack.should be_empty
    end
  end              
end

end