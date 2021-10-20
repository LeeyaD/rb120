# Add a class for each move - But I saw no need for class Move since I can initialize each class WITH state
# the state is pretty clear...for example class Rock -> Rock#name => 'rock' can't be anything else

# Keep track of a history of moves

# Computer personalities

# 1. Write a textual description of the program or exercise.
# When class Computer is iniitalized, a random computer name is chosen.
# Based on which computer is chosen; moves will be chosen according to the following personalities:
# > R2D2 chooses only rock
# > Hal chooses mostly scissors, rarely rock and never paper
# > Number 5 chooses mostly lizard & spock
# > Chappie chooses randomly, no preferences

# 2. Extract the major nouns and verbs from the description.
# Nouns: computer, R2D2, Hal, Number 5, Chappie
# Verbs: choose

# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)
# Computer
#  > R2D2 can #choose (only rock)
#  > Hal can #choose (mostly scissors, rarely rock and never paper)
#  > Number 5 can #choose (mostly lizard & spock)
#  > Chappie can #choose (randomly, no preferences)

# 4. Do a spike to explore the problem w/ temporary code
class RPSGame
  rock = Rock.new
  paper = Paper.new
  scissors = Scissors.new
  lizard = Lizard.new
  spock = Spock.new

  MOVES = {
    rock: rock, paper: paper, scissors: scissors,
    lizard: lizard, spock: spock
  }
end

class Computer < Player
  PREFERENCES = {
    'R2D2' => { rock: 1 }, 
    'Hal' => { scissors: 4, lizard: 2, spock: 2, rock: 1 },
    'Number 5' => { scissors: 1, lizard: 2, spock: 2, rock: 1, paper: 1 },
    'Chappie' => { scissors: 1, lizard: 1, spock: 1, rock: 1, paper: 1 }
  }

  def set_name
    self.name = ['R2D2', 'Hal', 'Number 5', 'Chappie'].sample
  end

  def choose
    choice = choices.sample
    self.move = RPSGame::MOVES[choice]
  end

  def choices
    PREFERENCES[name].each_with_object(obj) do |(move, tendency), array| 
      array << Array.new(tendency, move)
    end.flatten
  end
end

class R2D2 < Computer
  # > R2D2 chooses only rock
  PREFERENCES = { rock: 1 }

  def initialize # may be able to put in a module
    super
    @personality = PREFERENCES
  end

end

class Hal < Computer 
  # > Hal chooses mostly scissors, rarely rock and never paper
  PREFERENCES = { scissors: 4, lizard: 2, spock: 2, rock: 1 }
  
  def initialize # may be able to put in a module
    super
    @personality = PREFERENCES
  end
end

class Number5 < Computer 
  # > Number 5 chooses mostly lizard & spock
  PREFERENCES = { scissors: 1, lizard: 2, spock: 2, rock: 1, paper: 1 }
  
  def initialize # may be able to put in a module
    super
    @personality = PREFERENCES
  end
end

class Chappie < Computer 
  # > Chappie chooses randomly, no preferences
  PREFERENCES = { scissors: 1, lizard: 1, spock: 1, rock: 1, paper: 1 }

  def initialize # may be able to put in a module
    super
    @personality = PREFERENCES
  end
end


# 5. When you have a better idea of the problem, model thoughts into CRC Cards (optional)

class Move
  def initialize(value)
    @value = value
  end

  def to_s
    value.to_s
  end

  protected

  attr_reader :value
end

class Rock < Move
  def >(other_move)
    ['scissors', 'lizard'].include?(other_move.value)
  end

  def <(other_move)
    LOSING_MOVES[value].include?(other_move.to_s)
  end
end
class Paper < Move; end
class Scissors < Move; end
class Lizard < Move; end
class Spock < Move; end