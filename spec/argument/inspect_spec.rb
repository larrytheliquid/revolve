require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Argument, "#inspect" do
  before { @argument = Argument.new(:x, 1337) }
  
  it "should be the name and value wrapped in 'argument'" do
    @argument.inspect.should == "(:x => 1337 argument)"
  end
end

end