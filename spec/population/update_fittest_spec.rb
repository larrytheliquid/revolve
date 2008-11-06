require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#update_fittest_program!" do
  before do
    @fitness_combinator = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
    @population = new_population(
      :size => 0,
      :fitness_cases => [ lambda{|program| program.run.to_i - 12 } ],
      :fitness_combinator => @fitness_combinator,
      :crossover_percent => 0.5,
      :mutation_percent => 0.25)
    @population.push(Program.new(2, 8, Revolve::Method.new(:+)))
    @original_population = @population.clone    
  end
  
  describe "without a fittest_program" do    
    it "should set the fittest_program program" do
      lambda{ @population.update_fittest_program! }.should change(@population, :fittest_program)
    end
  end
  
  describe "with a fittest_program" do        
    describe "with a less fit program" do
      before { @population.fittest_program = Program.new }
      
      it "should not update the fittest_program" do
        @population.expects(:fitness).times(2).returns(600, 60)
        lambda{ @population.update_fittest_program! }.should_not change(@population, :fittest_program)
      end
    end
    
    describe "with a fitter program" do
      before { @population.fittest_program = Program.new }
      
      it "should update the fittest_program" do
        @population.expects(:fitness).times(2).returns(6, 60)
        lambda{ @population.update_fittest_program! }.should change(@population, :fittest_program)
      end
    end        
  end
end  
  
end