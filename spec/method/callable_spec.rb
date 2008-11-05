require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve

describe Method, "#callable?, without a stack" do
  before { @method = Method.new(:+) }
  
  it "should be false" do
    @method.should_not be_callable
  end
end

describe Method, "#callable?, with a stack" do
  before do
    @method = Method.new(:+)
  end
  
  describe "without a responding object in it" do
    before do
      @method.stack = [/regex/]              
    end
    
    it "should be false" do
      @method.should_not be_callable
    end
  end
  
  describe "with a responding object in it" do            
    describe "without valid arity" do
      before do
        @method.stack = [2]              
      end
      
      it "should be false" do
        @method.should_not be_callable
      end
    end
    
    describe "with valid arity" do
      describe "of 0" do
        before do
          @method.name = :next
          @method.stack = [1336]
        end
        
        it "should be true" do
          @method.should be_callable
        end
      end
      
      describe "of a fixed number" do
        before { @method.stack = [2, 8] }
        
        it "should be true" do
          @method.should be_callable
        end
      end                                
    end
  end
end

end