require File.join(File.dirname(__FILE__), "..", "spec_helper")

# describe Program, "#run" do              
#   describe "with objects" do
#     before { @program = Program.new(4) }
#     
#     it "should add them to the stack" do
#       @program.run
#       @program.stack.first.should == 4
#     end
#   end
#   
#   describe "with methods and insufficient arguments" do
#     before { @program = Program.new( 3, Method.new(:+, Integer) ) }
#     
#     it "should ignore method and return nil" do
#       @program.run.should be_nil
#     end
#     
#     it "should not affect the stack" do
#       @program.run
#       @program.stack.should == [3]
#     end
#   end
#   
#   describe "with methods that do not require arguments" do
#     before { @program = Program.new( 4, 1336, Method.new(:next) ) }        
#     
#     it "should execute method on stack object with stack arguments" do
#       @program.run.should == 1337
#     end
#     
#     it "should remove items from the stack equal to 1 + method arity, and add result back" do
#       @program.run
#       @program.stack.should == [4, 1337]
#     end
#   end
#   
#   describe "with methods and sufficient arguments" do
#     before { @program = Program.new( 4, 3, Method.new(:+, Integer) ) }        
#     
#     it "should execute method on stack object with stack arguments" do
#       @program.run.should == 7
#     end
#     
#     it "should remove items from the stack equal to 1 + method arity, and add result back" do
#       @program.run
#       @program.stack.should == [7]
#     end
#   end
# end