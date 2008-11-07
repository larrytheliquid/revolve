require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#update_fittest!" do
  before do
    @error_function = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
    @population = new_population(
      :size => 0,
      :fitness_cases => [ lambda{|program| program.run.to_i - 12 } ],
      :error_function => @error_function,
      :crossover_percent => 0.5,
      :mutation_percent => 0.25)
    @population.push(Program.new(2, 8, Revolve::Method.new(:+)))
    @original_population = @population.clone    
  end
  
  describe "without a fittest" do    
    it "should set the fittest program" do
      lambda{ @population.update_fittest! }.should change(@population, :fittest)
    end
  end
  
  describe "with a fittest" do        
    describe "with a less fit program" do
      before { @population.fittest = Program.new }
      
      it "should not update the fittest" do
        @population.expects(:error).times(2).returns(600, 60)
        lambda{ @population.update_fittest! }.should_not change(@population, :fittest)
      end
    end
    
    describe "with a fitter program" do
      before { @population.fittest = Program.new }
      
      it "should update the fittest" do
        @population.expects(:error).times(2).returns(6, 60)
        lambda{ @population.update_fittest! }.should change(@population, :fittest)
      end
    end        
  end
end  
  
end