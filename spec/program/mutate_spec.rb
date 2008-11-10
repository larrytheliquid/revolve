require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Program, "#mutate" do
  describe "with an ERK" do
    before do
      @parent = Program.new(1, 2, 3, 4, 5)
      @instructions = [1337]
      @child = @parent.mutate(@instructions, 20)
    end

    it "should produce a new Program" do
      @child.should be_kind_of(Program)
    end

    it "should be of length equal to the original program" do
      @child.length.should == 5
    end

    it "should only contain instructions from either program or mutation" do
      @child.each{|instruction| (@parent + [1337]).should include(instruction) }
    end
  end
  
  describe "with an ERK" do
    before do
      @parent = Program.new(1, 2, 3, 4, 5)
      @instructions = [ERK.new(1337)]
      @child = @parent.mutate(@instructions, 20)
    end

    it "should produce a new Program" do
      @child.should be_kind_of(Program)
    end

    it "should be of length equal to the original program" do
      @child.length.should == 5
    end

    it "should only contain instructions from either program or mutation" do
      @child.each{|instruction| (@parent + [1337]).should include(instruction) }
    end
  end    
end
  
end