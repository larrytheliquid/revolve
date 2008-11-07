require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Revolve
  
describe Population, "#elitism" do
  before do
    @fitness_combinator = lambda{|cases| cases.map{|x| x.abs}.inject{|x, y| x + y } }
    @population = new_population(
      :size => 0,
      :fitness_cases => [ lambda{|program| program.run - 12 } ],
      :fitness_combinator => @fitness_combinator)
    @very_fit_program = Program.new(11)
    @fit_program = Program.new(10)
    @somewhat_fit_program = Program.new(7)
    @unfit_program = Program.new(2)
    @population.push(@unfit_program).push(@very_fit_program).push(@fit_program).push(@somewhat_fit_program)
  end
  
  describe "with elitism percent" do
    before { @population.elitism_percent = 0.5 }
    
    it "should select most fit programs based on elitism percent" do
      @population.elitism.should == [@very_fit_program, @fit_program]
    end
  end
  
  describe "without elitism percent" do
    before { @population.elitism_percent = nil }
    
    it "should be an empty array" do
      @population.elitism.should be_empty
    end
  end    
end  
  
end