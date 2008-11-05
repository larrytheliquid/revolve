module Revolve
  class Population < Array
    attr_reader :generation
    def initialize(*args)
      @generation = 0
      block_given? ? super(*args) : super(args)
    end
    
    attr_accessor :program_size, :instructions, :reproduction_chance, :crossover_chance, :mutation_chance
    def self.initialized(size, parameters)
      population = self.new(size) { Program.randomized(parameters[:program_size], parameters[:instructions])}
      population.program_size = parameters[:program_size]
      population.instructions = parameters[:instructions]
      population.reproduction_chance = parameters[:reproduction_chance]
      population.crossover_chance = parameters[:crossover_chance]
      population.mutation_chance = parameters[:mutation_chance]                  
      population
    end
  end
end