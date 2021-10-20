# Add a class for each move - But I saw no need for class Move since I can initialize each class WITH state
# the state is pretty clear...for example class Rock -> Rock#name => 'rock' can't be anything else

# Keep track of a history of moves
# As long as the user doesn't quit, keep track of a history of moves by both the human and computer. What data structure will you reach for? Will you use a new class, or an existing class? What will the display output look like?

# 1. Write a textual description of the program or exercise.


# 2. Extract the major nouns and verbs from the description.
# Nouns: 
# Verbs: 

# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)
# Computer


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