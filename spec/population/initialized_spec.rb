require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, ".initialized" do
  before do
    @population = Population.initialized(3, 
    :instructions => ["kitteh", 2, 8, Method.new(:+)], 
    :program_size => 10,
    :reproduction_chance => 0.15,
    :crossover_chance => 0.8,
    :mutation_chance => 0.05)
  end
  
  it "should be generation 0" do
    @population.generation.should == 0
  end
  
  it "should be of specified size" do
    @population.size.should == 3
  end
  
  it "should have a program_size" do
    @population.program_size.should == 10
  end
  
  it "should have a reproduction_chance" do
    @population.reproduction_chance.should == 0.15
  end
  
  it "should have a crossover_chance" do
    @population.crossover_chance.should == 0.8
  end
  
  it "should have a mutation_chance" do
    @population.mutation_chance.should == 0.05
  end
end
  
end