require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Method, "#name" do
  before { @method = Method.new(:+) }
  
  it "should be the initialized symbol" do
    @method.name.should == :+
  end
end

end