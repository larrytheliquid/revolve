require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
  describe Population, "#error" do
    before do
      @error_function = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
      @population = new_population(
        :size => 1,
        :fitness_cases => [ lambda{|program| program.run - 12 } ],
        :error_function => @error_function)
      @program = Program.new(2, 8, Revolve::Method.new(:+))
      @population[0] = @program
    end
    
    it "should be the fitness_cases mapped to the program, applied to the error_function" do
      @population.error(@program).should == 2
    end
    
    it "should memoize the error specific to the program" do
      error = @population.error(@program)
      @error_function.expects(:call).never
      @population.error(@program).should == error
    end

    it "should not returned memoized results for separate programs" do
      @population.error(@program)
      another_program = Program.new(2, 3, Revolve::Method.new(:+))      
      @population.push(another_program).error(another_program).should == 7
    end
  end
  
end