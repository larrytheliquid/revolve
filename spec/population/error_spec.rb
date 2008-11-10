require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
  describe Population, "#error" do
    before do
      fitness_cases = [lambda {|program| program.run.to_i - 10 }]    
      error_function = lambda{|cases| cases.first.abs }
      @population = new_population(:size => 0, :fitness_cases => fitness_cases, :error_function => error_function)
      @program = Program.new(8)
      @population.push @program
    end
    
    it "should be the fitness_cases passed the program, applied to the error_function" do
      @population.error(@program).should == 2
    end
    
    it "should memoize the error specific to the program" do
      error = @population.error(@program)
      @error_function.expects(:call).never
      @population.error(@program).should == error
    end

    it "should not returned memoized results for separate programs" do
      @population.error(@program)
      another_program = Program.new(5)      
      @population.push(another_program).error(another_program).should == 5
    end
  end
  
end