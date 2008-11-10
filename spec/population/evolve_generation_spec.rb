require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#evolve_generation!" do
  before do
    error_function = lambda{|cases| cases.first.abs }
    @population = new_population(
      :size => 7,
      :size_limit => 10,
      :instructions => [1, 2, 3,
                        Revolve::Method.new(:+), Revolve::Method.new(:next), Revolve::Method.new(:*)],
      :fitness_cases => [ lambda{|program| program.run.to_i - 12 } ],
      :error_function => error_function,
      :elitism_percent => 0.3,     
      :crossover_percent => 0.45,
      :mutation_percent => 0.2)
    @original_population = @population.clone    
  end
  
  it "should increment the generation" do
    @population.evolve_generation!
    @population.generation.should == 1
  end
  
  it "should be the same size as it was originally" do
    @population.evolve_generation!
    @population.size.should == @original_population.size
  end
  
  it "should use selection when selecting programs for next generation" do
    @population.expects(:select_program).at_least_once.returns(@original_population.first.dup)
    @population.evolve_generation!
  end
  
  it "should select elites according to the elitism_percent" do
    @population.expects(:elitism).returns([@original_population.first.dup, @original_population.last.dup])
    @population.evolve_generation!    
  end
  
  it "should crossover according to the crossover_percent" do
    Program.any_instance.expects(:crossover).times(3).returns(@original_population.first.dup)
    @population.evolve_generation!
  end
  
  it "should mutate according to the mutation_percent" do
    Program.any_instance.expects(:mutate).times(1).returns(@original_population.first.dup)
    @population.evolve_generation!
  end
  
  it "should produce according to the the remaining percentage" do
    Population.any_instance.expects(:produce).times(1).returns(@original_population.first.dup)
    @population.evolve_generation!
  end
  
  it "should be a different population" do
    @population.evolve_generation!
    @population.should_not == @original_population
  end
end
  
end