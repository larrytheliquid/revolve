require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Program, ".randomized" do        
  describe "without an ERK" do
    before do
      @instructions = ["kitteh", Method.new(:+), " "]
      @program = Program.randomized(4, @instructions)
    end
    
    it "should be of length specified" do
      @program.length.should == 4
    end
    
    it "should contain random intructions from the parameter set" do
      @program.each{|instruction| @instructions.should include(instruction) }
    end
  end
  
  describe "with an ERK" do
    before do
      @constant_instructions = ["kitteh", Method.new(:+), 3]
      instructions = @constant_instructions.dup
      instructions.push(ERK.new(instructions.pop))
      @program = Program.randomized(4, instructions)
    end
    
    it "should be of length specified" do
      @program.length.should == 4
    end
    
    it "should contain random intructions from the parameter set or ERK set" do
      @program.each{|instruction| @constant_instructions.should include(instruction) }
    end
  end    
end
  
end