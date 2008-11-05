require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Program, ".randomized" do
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
  
end