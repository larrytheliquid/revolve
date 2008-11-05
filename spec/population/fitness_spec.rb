require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
  describe Population, "#fitness" do
    before do
      @fitness_combinator = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
      @population = new_population(
        :size => 1,
        :fitness_cases => [ lambda{|program| program.run - 12 } ],
        :fitness_combinator => @fitness_combinator)
      @program = Program.new(2, 8, Revolve::Method.new(:+))
      @population[0] = @program
    end
    
    it "should be the fitness_cases mapped to the program, applied to the fitness_combinator" do
      @population.fitness(@program).should == 2
    end
  end
  
end