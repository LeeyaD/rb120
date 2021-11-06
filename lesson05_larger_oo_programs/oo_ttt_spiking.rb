# Allow the player to pick any marker
# Computer turn refinements

# ON DECK: Computer AI Offense
# 1. Textual Description
# TThe defensive minded AI is pretty cool, but it's still not performing as well as it could because if there are no impending threats, it will pick a square at random. We'd like to make a slight improvement on that. We're not going to add in any complicated algorithm (there's an extra bonus below on that), but all we want to do is piggy back on our find_at_risk_square from bonus #3 above and turn it into an attacking mechanism as well. The logic is simple: if the computer already has 2 in a row, then fill in the 3rd square, as opposed to moving at random.

# 2. Extract major nouns/verbs
# Nouns: square, computer
# Verbs: defend/defense

# 3. Organize & Associate Nouns/Verbs (Nouns > classes, Verbs > behaviors/methods)
# Computer
# - defense

# 4. Spike it! & Do CRC cards one you understand it better
module AIStrategy
  attr_accessor :threat

  def choose_random_square
    board[board.unmarked_keys.sample] = computer.marker
  end

  def find_at_risk_square
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_opposing_markers?(squares)
        line.each do |key|
          return key if @squares[key].marker == Square::INITIAL_MARKER
        end
      end
    end
    nil
  end

  def defend_square
    @threat = find_at_risk_square
    board[threat] = computer.marker if threat
  end

  def two_opposing_markers?(squares) # ["X", "O", " "]
    return false if squares.all?(&:marked?)
    squares.collect(&:marker).count(human.marker) == 2
  end
end

class Board
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    return false unless squares.all?(&:marked?)
    squares.collect(&:marker).all? do |sq|
      sq == squares.first.marker
    end
  end
end

class TTTGame
  include AIStrategy

  def computer_moves # currently set to random
    defend_square if immediate_threat?
    choose_random_square
    
  end
end
