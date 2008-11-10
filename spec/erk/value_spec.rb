require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe ERK, "#value" do
  before do
    @instructions = [1, 2, 3]
    @erk = ERK.new(*@instructions)
  end
  
  it "should return one of its initialized instructions" do
    @instructions.should include(@erk.value)
  end
end

end