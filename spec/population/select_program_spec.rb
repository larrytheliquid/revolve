require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
  describe Population, "#select_program" do
    before do
      fitness_cases = [lambda {|program| program.run.to_i - 10 }]    
      error_function = lambda{|cases| cases.first.abs }
      @population = new_population(:size => 0, :fitness_cases => fitness_cases, :error_function => error_function)
      @more_fit_program = Program.new(12)
      @less_fit_program = Program.new(5)
      @population.push(@more_fit_program).push(@less_fit_program)
    end
    
    it "should return a Program" do
      @population.select_program.should be_kind_of(Program)
    end
    
    describe "with a matched greater fitness chance" do
      before do 
        Population.any_instance.stubs(:random_program).returns(@more_fit_program, @less_fit_program)
        @population.greater_fitness_chance = 1337
      end
      
      it "should select 2 random programs, and return the fitter" do
        @population.select_program.should == @more_fit_program
      end
    end
    
    describe "with an unmatched greater fitness chance" do
      before do 
        Population.any_instance.stubs(:random_program).returns(@more_fit_program, @less_fit_program)        
        @population.greater_fitness_chance = -1337 
      end
      
      it "should select 2 random programs, and return the less fit" do
        @population.select_program.should == @less_fit_program
      end
    end                
  end
  
end