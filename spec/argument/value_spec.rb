require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Argument, "#value" do
  before { @argument = Argument.new(:x, 1337) }
  
  it "should be the initialized object" do
    @argument.value.should == 1337
  end
end

end