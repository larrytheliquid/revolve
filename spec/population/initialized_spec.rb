require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, ".initialized" do
  before do
    @population = new_population(:size => 3, :generations_limit => 20, :size_limit => 10)
  end
  
  it "should be generation 0" do
    @population.generation.should == 0
  end
  
  it "should be of specified size" do
    @population.size.should == 3
  end
  
  it "should have a generations_limit" do
    @population.generations_limit.should == 20
  end
  
  it "should have a size_limit" do
    @population.size_limit.should == 10
  end
  
  it "should have a default greater_fitness_chance" do
    @population.greater_fitness_chance.should == 0.75
  end
  
  it "should have a greater_fitness_chance" do
    @population.greater_fitness_chance = 0.9
    @population.greater_fitness_chance.should == 0.9
  end
  
  it "should have a default elitism_percent of 0" do
    @population.elitism_percent.should == 0
  end
  
  it "should have a elitism_percent" do
    @population.elitism_percent = 0.05
    @population.elitism_percent.should == 0.05
  end
  
  it "should have a default reproduction_percent of 0" do
    @population.reproduction_percent.should == 0
  end
  
  it "should have a reproduction_percent" do
    @population.reproduction_percent = 0.05    
    @population.reproduction_percent.should == 0.05
  end
  
  it "should have a default crossover_percent of 0" do
    @population.crossover_percent.should == 0
  end
  
  it "should have a crossover_percent" do
    @population.crossover_percent = 0.6    
    @population.crossover_percent.should == 0.6
  end
  
  it "should have a default mutation_percent of 0" do
    @population.mutation_percent.should == 0
  end
  
  it "should have a mutation_percent" do
      @population.mutation_percent = 0.2  
    @population.mutation_percent.should == 0.2
  end    
  
  it "should raise an exception when using an unsupported option" do
    lambda { new_population(:unsupported => "option") }.should raise_error
  end
end
  
end