require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, ".initialized" do
  before do
    @population = new_population(:size => 3, :max_generations => 20, 
                                 :program_size => 10, :crossover_percent => 0.6, 
                                 :mutation_percent => 0.2, :elitism_percent => 0.1)
  end
  
  it "should be generation 0" do
    @population.generation.should == 0
  end
  
  it "should be of specified size" do
    @population.size.should == 3
  end
  
  it "should have a max_generations" do
    @population.max_generations.should == 20
  end
  
  it "should have a program_size" do
    @population.program_size.should == 10
  end
  
  it "should have a default greater_fitness_chance" do
    @population.greater_fitness_chance.should == 0.75
  end
  
  it "should have a greater_fitness_chance" do
    @population.greater_fitness_chance = 0.9
    @population.greater_fitness_chance.should == 0.9
  end
  
  it "should have a elitism_percent" do
    @population.elitism_percent.should == 0.1
  end
  
  it "should have a crossover_percent" do
    @population.crossover_percent.should == 0.6
  end
  
  it "should have a mutation_percent" do
    @population.mutation_percent.should == 0.2
  end    
  
  it "should raise an exception when using an unsupported option" do
    lambda { new_population(:unsupported => "option") }.should raise_error
  end
end
  
end