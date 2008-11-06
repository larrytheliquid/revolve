require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Variable, "#inspect" do
  before { @variable = Variable.new(:x) }
  
  it "should be the name wrapped in 'variable'" do
    @variable.inspect.should == "(:x variable)"
  end
end

end