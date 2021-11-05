# Computer turn refinements
# Computer AI Defense
# Computer AI Offense
# Allow the player to pick any marker

# ON DECK: Keep Score
# 1. Textual Description
# The computer currently picks a square at random. Let's make the computer defensive minded, so that if there's an immediate threat, then it will defend the 3rd square. We'll consider an "immediate threat" to be 2 squares marked by the opponent in a row. If there's no immediate threat, then it will just pick a random square.

# 2. Extract major nouns/verbs
# Nouns: square, computer
# Verbs: defend/defense

# 3. Organize & Associate Nouns/Verbs (Nouns > classes, Verbs > behaviors/methods)
# Computer
# - defense

# 4. Spike it! & Do CRC cards one you understand it better
module AIOffense; end
module AIDefense #contain various AI Defense strategies
# if there's an immediate threat, i.e. 2 marked squares by an opponent, defend the 3rd sq

# defend_square if threat?
end

class Board
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  def []=(square, marker)
    @squares[square].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

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
  include AIDefense

  def computer_moves # currently set to random
    board[board.unmarked_keys.sample] = computer.marker
    
    defend_square if threat?
  end
end
