module Revolve
  class Population < Array
    attr_accessor :generation, :error_memory, :fittest
    def initialize(*args)
      @generation = 0
      @error_memory = {}
      block_given? ? super(*args) : super(args)
    end
    
    SUPPORTED_PARAMETERS = {:size_limit => nil, :instructions => nil, :generations_limit => nil, 
                            :instructions => nil, :fitness_cases => nil, :error_function => nil, 
                            :greater_fitness_chance => 0.75, :elitism_percent => 0, 
                            :crossover_percent => 0, :mutation_percent => 0, :reproduction_percent => 0}
    
    attr_accessor *SUPPORTED_PARAMETERS.keys
    def self.initialized(size, parameters)
      verify_parameters!(parameters.keys)
      population = self.new(size) { Program.randomized(rand(parameters[:size_limit]).next, parameters[:instructions]) }
      SUPPORTED_PARAMETERS.each {|key, value| population.send("#{key}=", parameters[key] || value) }
      population
    end
    
    def evolve!
      update_fittest!
      generations_limit.times do |i|
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
      self.map do |ignore| 
        if !elites.empty?
          elites.shift
        elsif number_of_crossovers > 0 && number_of_crossovers -= 1          
          select_program.crossover(select_program)
        elsif number_of_mutations > 0 && number_of_mutations -= 1          
          select_program.mutate(instructions, size_limit)
        else
          produce
        end
      end.each_with_index {|program, index| self[index] = program }
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
        self.uniq.sort{|x, y| error(x) <=> error(y) }.slice(0, (self.size * elitism_percent).to_i)
      else
        []
      end
    end
    
    def produce
      Program.randomized(rand(size_limit).next, instructions)
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
      self[rand(self.size)]
    end        
    
    def error(program)
      return error_memory[program] if error_memory.has_key?(program)
      error_memory[program] = error_function.call(
        fitness_cases.map{|fitness_case| fitness_case.call(program) })
    end    
    
  private
  
    def self.verify_parameters!(parameters)
      parameters.each do |parameter|
        raise Exception.new("Parameter '#{parameter}' is not supported") unless SUPPORTED_PARAMETERS.keys.include?(parameter)
      end
    end
  end
end