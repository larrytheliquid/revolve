require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#evolve!" do
  before do
    @fitness_combinator = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
    @population = new_population(
      :size => 0,
      :max_generations => 5,
      :instructions => [2, 3, 5, 8, 1337, 
                        Revolve::Method.new(:+), Revolve::Method.new(:next), Revolve::Method.new(:*)],
      :fitness_cases => [ lambda{|program| program.run.to_i - 12 } ],
      :fitness_combinator => @fitness_combinator,
      :crossover_chance => 0.5,
      :mutation_chance => 0.25)
    @program_1 = Program.new(2, 8, Revolve::Method.new(:+))
    @program_2 = Program.new(1336, Revolve::Method.new(:next))
    @program_3 = Program.new(2, 3, Revolve::Method.new(:+))
    @program_4 = Program.new(3, 5, Revolve::Method.new(:*))
    @population.push(@program_1).push(@program_2).push(@program_3).push(@program_4)
    @original_population = @population.clone    
  end
  
  it "should return a program" do
    @population.evolve!.should be_kind_of(Program)
  end
  
  it "should not evolve past max_generations" do
    @population.evolve!
    @population.generation.should_not > 10
  end
  
  it "should be the same size as it was originally" do
    @population.evolve!
    @population.size.should == @original_population.size
  end
  
  it "should not be a different population" do
    @population.evolve!
    @population.should_not == @original_population
  end
end
  
end