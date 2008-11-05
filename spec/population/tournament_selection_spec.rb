require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
  describe Population, "#select_program" do
    before do
      @fitness_combinator = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
      @population = new_population(
        :size => 1,
        :fitness_cases => [ lambda{|program| program.run - 12 } ],
        :fitness_combinator => @fitness_combinator)
      @more_fit_program = Program.new(2, 8, Revolve::Method.new(:+))
      @some_program = Program.new(1336, Revolve::Method.new(:next))
      @less_fit_program = Program.new(2, 3, Revolve::Method.new(:+))
      @population.clear.push(@more_fit_program).push(@some_program).push(@less_fit_program)
    end
    
    it "should return a Program" do
      @population.select_program.should be_kind_of(Program)
    end
    
    it "should select 2 random programs, and return the fitter" do
      @population.expects(:random_program).times(2).returns(@more_fit_program, @less_fit_program)
      @population.select_program.should == @more_fit_program
    end        
  end
  
end