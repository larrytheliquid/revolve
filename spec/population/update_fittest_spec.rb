require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#update_fittest!" do
  before do
    fitness_cases = [lambda {|program| program.run.to_i - 10 }]    
    error_function = lambda{|cases| cases.first.abs }
    @population = new_population(:size => 0, :fitness_cases => fitness_cases, :error_function => error_function)
    @population.push Program.new(5)
    @original_population = @population.dup
  end
  
  describe "without a fittest" do    
    before { @population.fittest = nil }
    
    it "should set the fittest" do
      lambda{ @population.update_fittest! }.should change(@population, :fittest)
    end
  end
  
  describe "with a fittest" do        
    describe "against a less fit program" do
      before { @population.fittest = Program.new(10) }
      
      it "should not update the fittest" do
        lambda{ @population.update_fittest! }.should_not change(@population, :fittest)
      end
    end
    
    describe "against a fitter program" do
      before { @population.fittest = Program.new(0) }
      
      it "should update the fittest" do
        lambda{ @population.update_fittest! }.should change(@population, :fittest)
      end
    end        
  end
end  
  
end