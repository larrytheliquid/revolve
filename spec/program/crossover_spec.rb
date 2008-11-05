require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Program, "#crossover" do
  before do
    @parent = Program.new(1, 2, 3, 4, 5)
    @mate = Program.new("one", "two", "three", "four", "five")
    @child = @parent.crossover(@mate)
  end
  
  it "should produce a new Program" do
    @child.should be_kind_of(Program)
  end
  
  it "should be of length no greater than the sum of the parents" do
    @child.length.should_not > 10
  end
  
  it "should only contain instructions from either parent" do
    @child.each{|instruction| (@parent + @mate).should include(instruction) }
  end
end
  
end