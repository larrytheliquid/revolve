require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Variable, "#name" do
  before { @variable = Variable.new(:x) }
  
  it "should be the initialized symbol" do
    @variable.name.should == :x
  end
end

end