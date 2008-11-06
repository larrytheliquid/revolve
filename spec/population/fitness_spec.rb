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
    
    it "should memoize the fitness specific to the program" do
      fitness = @population.fitness(@program)
      @fitness_combinator.expects(:call).never
      @population.fitness(@program).should == fitness
    end

    it "should not returned memoized results for separate programs" do
      @population.fitness(@program)
      another_program = Program.new(2, 3, Revolve::Method.new(:+))      
      @population.push(another_program).fitness(another_program).should == 7
    end
  end
  
end