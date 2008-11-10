require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Program, ".new" do  
  it "should be a kind of Array" do
    Program.new.should be_kind_of(Array)
  end
  
  it "should contain any values given" do
    Program.new(3).first.should == 3
  end
  
  it "should pick a value from an ERK if an ERK is given" do
    Program.new( ERK.new(3) ).first.should == 3
  end
end

end