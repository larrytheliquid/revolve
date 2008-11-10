require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#evolve!" do
  before do
    error_function = lambda{|cases| cases.inject{|x, y| x.abs + y.abs } }
    @population = new_population(
      :size => 7,
      :size_limit => 10,
      :generations_limit => 2,
      :instructions => [1, 2, 3,
                        Revolve::Method.new(:+), Revolve::Method.new(:next), Revolve::Method.new(:*)],
      :fitness_cases => [ lambda{|program| program.run.to_i - 12 } ],
      :error_function => error_function,
      :elitism_percent => 0.4,
      :crossover_percent => 0.5,
      :mutation_percent => 0.1)
    @original_population = @population.dup    
  end
  
  it "should return a program" do
    @population.evolve!.should be_kind_of(Program)
  end
  
  it "should not evolve past generations_limit" do
    @population.evolve!
    @population.generation.should_not > 3
  end
  
  it "should be the same size as it was originally" do
    @population.evolve!
    @population.size.should == @original_population.size
  end
  
  it "should be a different population" do
    @population.evolve!
    @population.should_not == @original_population
  end
end
  
end