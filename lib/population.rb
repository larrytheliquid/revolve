module Revolve
  class Population < Array
    attr_reader :generation, :fitness_memory
    def initialize(*args)
      @generation = 0
      @fitness_memory = {}
      block_given? ? super(*args) : super(args)
    end
    
    attr_accessor :program_size, :instructions
    attr_accessor :fitness_cases, :fitness_combinator
    attr_accessor :reproduction_chance, :crossover_chance, :mutation_chance
    def self.initialized(size, parameters)
      population = self.new(size) { Program.randomized(parameters[:program_size], parameters[:instructions])}
      population.program_size = parameters[:program_size]
      population.instructions = parameters[:instructions]
      population.fitness_cases = parameters[:fitness_cases]
      population.fitness_combinator = parameters[:fitness_combinator] 
      population.reproduction_chance = parameters[:reproduction_chance]
      population.crossover_chance = parameters[:crossover_chance]
      population.mutation_chance = parameters[:mutation_chance]                  
      population
    end
    
    def fitness(program)
      return @fitness_memory[program] if @fitness_memory.has_key?(program)
      @fitness_memory[program] = fitness_combinator.call(
        fitness_cases.map{|fitness_case| fitness_case.call(program) })
    end
  end
end