require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe ERK, ".new" do
  before { @erk = ERK.new }
  
  it "should be a kind of Array" do
    @erk.should be_kind_of(Array)
  end
end

end