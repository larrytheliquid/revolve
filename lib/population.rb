module Revolve
  class Population < Array
    attr_accessor :generation, :fittest_program
    def initialize(*args)
      @generation = 0
      block_given? ? super(*args) : super(args)
    end
    
    attr_accessor :max_generations, :program_size, :instructions
    attr_accessor :fitness_cases, :fitness_combinator
    attr_accessor :crossover_chance, :mutation_chance
    def self.initialized(size, parameters)
      population = self.new(size) { Program.randomized(rand(parameters[:program_size].next), parameters[:instructions]) }
      population.max_generations = parameters[:max_generations]
      population.program_size = parameters[:program_size]
      population.instructions = parameters[:instructions]
      population.fitness_cases = parameters[:fitness_cases]
      population.fitness_combinator = parameters[:fitness_combinator] 
      population.crossover_chance = parameters[:crossover_chance]
      population.mutation_chance = parameters[:mutation_chance]                  
      population
    end
    
    def evolve!
      update_fittest_program!
      max_generations.times do        
        evolve_generation!    
        update_fittest_program!
      end      
      fittest_program
    end
    
    def evolve_generation!
      @generation += 1
      number_of_crossovers = (self.size * crossover_chance).to_i      
      number_of_mutations = (self.size * mutation_chance).to_i
      self.map! do |ignore| 
        if number_of_crossovers > 0 && number_of_crossovers -= 1          
          select_program.crossover(select_program)
        elsif number_of_mutations > 0 && number_of_mutations -= 1          
          select_program.mutate(Program.randomized(rand(program_size.next), instructions))
        else
          select_program.reproduce
        end
      end
    end
    
    def update_fittest_program!
      generations_fittest_program = self.min{|x, y| fitness(x) <=> fitness(y) }
      @fittest_program = if fittest_program        
        fitness(generations_fittest_program) < fitness(fittest_program) ? generations_fittest_program : fittest_program
      else
        generations_fittest_program
      end
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