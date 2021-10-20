# Add a class for each move - But I saw no need for class Move since I can initialize each class WITH state
# the state is pretty clear...for example class Rock -> Rock#name => 'rock' can't be anything else

# Computer personalities
# Keep track of a history of moves




# 1. Write a textual description of the program or exercise.


# 2. Extract the major nouns and verbs from the description.


# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)


# 4. Do a spike to explore the problem w/ temporary code


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