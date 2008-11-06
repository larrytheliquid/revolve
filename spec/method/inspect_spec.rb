require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Method, "#inspect" do
  before { @method = Method.new(:+) }
  
  it "should be the name wrapped in 'method'" do
    @method.inspect.should == "(:+ method)"
  end
end

end