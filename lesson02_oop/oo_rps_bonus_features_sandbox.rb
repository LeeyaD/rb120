# Computer personalities
# Keep track of a history of moves


# Add a class for each move

# 1. Write a textual description of the program or exercise.


# 2. Extract the major nouns and verbs from the description.


# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)


# 4. Do a spike to explore the problem w/ temporary code


# 5. When you have a better idea of the problem, model thoughts into CRC Cards (optional)

class Move
  VALUES = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]

  WINNING_MOVES = {
    rock: ['scissors', 'lizard'],
    paper: ['rock', 'spock'],
    scissors: ['paper', 'lizard'],
    lizard: ['spock', 'paper'],
    spock: ['rock', 'scissors']
  }

  LOSING_MOVES = {
    rock: ['paper', 'spock'],
    paper: ['lizard', 'scissors'],
    scissors: ['rock', 'spock'],
    lizard: ['scissors', 'rock'],
    spock: ['lizard', 'paper']
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_MOVES[value].include?(other_move.to_s)
  end

  def <(other_move)
    LOSING_MOVES[value].include?(other_move.to_s)
  end

  def to_s
    value.to_s
  end

  private

  attr_reader :value
end

class Rock < Move; end
class Paper < Move; end
class Scissors < Move; end
class Lizard < Move; end
class Spock < Move; end