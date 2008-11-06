require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Argument, "#name" do
  before { @argument = Argument.new(:x, 1337) }
  
  it "should be the initialized symbol" do
    @argument.name.should == :x
  end
end

end