require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

  describe Method, "#call!" do
    before do
      @method = Method.new(:+)
    end

    describe "with arity of 0" do
      before do
        @method.name = :next
        @method.stack = ["kitteh", 1336]
      end

      it "should return the result" do
        @method.call!.should == 1337
      end
      
      it "should remove the target from the stack and push the result" do
        @method.call!
        @method.stack.should == ["kitteh", 1337]
      end
    end

    describe "with arity of a fixed number" do
      before { @method.stack = ["kitteh", 2, 8] }

      it "should return the result" do
        @method.call!.should == 10
      end
      
      it "should remove the target and arguments from the stack, and push the result" do
        @method.call!
        @method.stack.should == ["kitteh", 10]
      end
    end
  end  
  
end