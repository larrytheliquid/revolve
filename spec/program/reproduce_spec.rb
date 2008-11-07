require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Program, "#reproduce" do
  before do
    @parent = Program.new(1, 2, 3, 4, 5)
    @reproduction = @parent.reproduce
  end
  
  it "should produce a new Program" do
    @reproduction.should be_kind_of(Program)
  end
  
  it "should produce a new and separate program" do
    @reproduction.should_not be_equal(@parent)
  end
  
  it "should produce a program equal in value" do
    @reproduction.should == @parent
  end
end
  
end