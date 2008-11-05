require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Program, ".new" do
  before { @program = Program.new }
  
  it "should be a kind of Array" do
    @program.should be_kind_of(Array)
  end
end

end