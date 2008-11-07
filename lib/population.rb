module Revolve
  class Population < Array
    attr_accessor :generation, :error_memory, :fittest
    def initialize(*args)
      @generation = 0
      @error_memory = {}
      block_given? ? super(*args) : super(args)
    end
    
    SUPPORTED_PARAMETERS = [:size_limit, :instructions, :generations_limit, :instructions, 
                            :fitness_cases, :error_function, :greater_fitness_chance, 
                            :elitism_percent, :crossover_percent, :mutation_percent]
    
    attr_accessor :generations_limit, :size_limit, :instructions
    attr_accessor :fitness_cases, :error_function, :greater_fitness_chance
    attr_accessor :elitism_percent, :crossover_percent, :mutation_percent
    def self.initialized(size, parameters)
      verify_parameters!(parameters.keys)
      population = self.new(size) { Program.randomized(rand(parameters[:size_limit].next), parameters[:instructions]) }
      population.generations_limit = parameters[:generations_limit]
      population.size_limit = parameters[:size_limit]
      population.instructions = parameters[:instructions]
      population.fitness_cases = parameters[:fitness_cases]
      population.error_function = parameters[:error_function] 
      population.greater_fitness_chance = parameters[:greater_fitness_chance] || 0.75
      population.elitism_percent = parameters[:elitism_percent]
      population.crossover_percent = parameters[:crossover_percent]
      population.mutation_percent = parameters[:mutation_percent]                  
      population
    end
    
    def evolve!
      update_fittest!
      generations_limit.times do 
        break if error(fittest) == 0       
        evolve_generation!    
        update_fittest!        
      end      
      fittest
    end
    
    def evolve_generation!
      @generation += 1
      number_of_crossovers = (self.size * crossover_percent).to_i      
      number_of_mutations = (self.size * mutation_percent).to_i
      elites = elitism
      self.map! do |ignore| 
        if !elites.empty?
          elites.pop
        elsif number_of_crossovers > 0 && number_of_crossovers -= 1          
          select_program.crossover(select_program)
        elsif number_of_mutations > 0 && number_of_mutations -= 1          
          select_program.mutate(Program.randomized(rand(size_limit.next), instructions))
        else
          select_program.reproduce
        end
      end
    end
    
    def update_fittest!
      generations_fittest = self.min{|x, y| error(x) <=> error(y) }
      @fittest = if fittest        
        error(generations_fittest) < error(fittest) ? generations_fittest : fittest
      else
        generations_fittest
      end
    end
    
    def elitism
      if elitism_percent
        self.sort{|x, y| error(x) <=> error(y) }.slice(0, (self.size * elitism_percent).to_i)
      else
        []
      end
    end
    
    def select_program
      first_program, second_program = random_program, random_program
      if rand < greater_fitness_chance
        error(first_program) <= error(second_program) ? first_program : second_program
      else
        error(first_program) <= error(second_program) ? second_program : first_program
      end      
    end
    
    def random_program
      self[self.size - 1]
    end        
    
    def error(program)
      return error_memory[program] if error_memory.has_key?(program)
      error_memory[program] = error_function.call(
        fitness_cases.map{|fitness_case| fitness_case.call(program) })
    end    
    
  private
  
    def self.verify_parameters!(parameters)
      parameters.each do |parameter|
        raise Exception.new("Parameter '#{parameter}' is not supported") unless SUPPORTED_PARAMETERS.include?(parameter)
      end
    end
  end
end