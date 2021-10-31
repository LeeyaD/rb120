# 1. Textual description of problem
# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns marking a square. The first player to mark 3 squares in a row wins.

# 2. Extract major nouns/verbs
# - Nouns: player, board (3x3 grid), square
# - Verbs: turns, mark
# LS: (diff)
# - Nouns: player, board, grid, square
# - Verbs: play, mark

# 3. Organize & Associate Verbs w/ Nouns
# ONLY A STARTING POINT FOR US TO SPIKE & EXPLORE
# Player
# - mark
# - play
# Board
# - grid
# - square
# LS:
# Board
# Square
# Player
# - play
# - mark
# LS omitted 'grid' since it's the same as 'board'

# 4. Spike to explore!
class Board
  def initialize
    # we need some way to modle the 3x3 grid, maybe 'squares'?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a 'status' to keep track of this square's mark?
  end
end

def Player
  def initialize
    # maybe a 'marker' to keep track of this player's symbol (i.e. X or O)
  end

  def mark; end
end

class TTTGame # writing methods we wish we had to start
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?
      
      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

# we'll start a game like this
game = TTTGame.new

game.play