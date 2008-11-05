module Revolve
  class Population < Array
    attr_reader :generation
    def initialize(*args)
      @generation = 0
      block_given? ? super(*args) : super(args)
    end
    
    attr_accessor :max_generations, :program_size, :instructions
    attr_accessor :fitness_cases, :fitness_combinator
    attr_accessor :reproduction_chance, :crossover_chance, :mutation_chance
    def self.initialized(size, parameters)
      population = self.new(size) { Program.randomized(parameters[:program_size], parameters[:instructions]) }
      population.max_generations = parameters[:max_generations]
      population.program_size = parameters[:program_size]
      population.instructions = parameters[:instructions]
      population.fitness_cases = parameters[:fitness_cases]
      population.fitness_combinator = parameters[:fitness_combinator] 
      population.reproduction_chance = parameters[:reproduction_chance]
      population.crossover_chance = parameters[:crossover_chance]
      population.mutation_chance = parameters[:mutation_chance]                  
      population
    end
    
    def evolve_generation!
      @generation += 1
      self.map!{|program| program }
    end
    
    def select_program
      first_program, second_program = random_program, random_program
      fitness(first_program) <= fitness(second_program) ? first_program : second_program
    end
    
    def random_program
      self[self.size - 1]
    end
    
    def fitness(program)
      fitness_combinator.call( fitness_cases.map{|fitness_case| fitness_case.call(program) } )
    end
  end
end