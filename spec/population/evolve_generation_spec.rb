require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#evolve_generation!" do
  before do
    @fitness_combinator = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
    @population = new_population(
      :size => 0,
      :instructions => [2, 3, 5, 8, 1337, 
                        Revolve::Method.new(:+), Revolve::Method.new(:next), Revolve::Method.new(:*)],
      :fitness_cases => [ lambda{|program| program.run.to_i - 12 } ],
      :fitness_combinator => @fitness_combinator,
      :crossover_percent => 0.5,
      :mutation_percent => 0.25)
    @program_1 = Program.new(2, 8, Revolve::Method.new(:+))
    @program_2 = Program.new(1336, Revolve::Method.new(:next))
    @program_3 = Program.new(2, 3, Revolve::Method.new(:+))
    @program_4 = Program.new(3, 5, Revolve::Method.new(:*))
    @population.push(@program_1).push(@program_2).push(@program_3).push(@program_4)
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
    @population.expects(:select_program).times(6).returns(@program_1)
    @population.evolve_generation!
  end
  
  it "should crossover according to the crossover_percent" do
    Program.any_instance.expects(:crossover).times(2).returns(@program_1.dup)
    @population.evolve_generation!
  end
  
  it "should mutate according to the mutation_percent" do
    Program.any_instance.expects(:mutate).times(1).returns(@program_1.dup)
    @population.evolve_generation!
  end
  
  it "should reproduce according to the the remaining percentage" do
    Program.any_instance.expects(:reproduce).times(1).returns(@program_1.dup)
    @population.evolve_generation!
  end
  
  it "should not be a different population" do
    @population.evolve_generation!
    @population.should_not == @original_population
  end
end
  
end