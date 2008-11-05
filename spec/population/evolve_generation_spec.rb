require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#evolve_generation!" do
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
    @old_population = @population.clone
    @population.evolve_generation!
  end
  
  it "should increment the generation" do
    @population.generation.should == 1
  end
  
  it "should be the same size as it was originally" do
    @population.size.should == @old_population.size
  end
  
  it "should not be a different population" do
    @population.should_not == @old_population
  end
end
  
end