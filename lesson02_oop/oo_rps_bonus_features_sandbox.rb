# Add a class for each move - But I saw no need for class Move since I can initialize each class WITH state
# the state is pretty clear...for example class Rock -> Rock#name => 'rock' can't be anything else

# Keep track of a history of moves
# As long as the user doesn't quit, keep track of a history of moves by both the human and computer. 
# What data structure will you reach for? A hash; keys are the player & computer names, values are the moves they've made in the game
# history = { player: [rock, paper], computer: [paper, scissors] }
# Will you use a new class, or an existing class? The existing class Move
# What will the display output look like? (rock 4, paper/spock 5, lizard 6, scissors 8)
# > a table with 2 columns, headers are the players' names, each column width is 19 (|--------|--------|), with the move centered

# 1. Write a textual description of the program or exercise.
# As long as the user doesn't quit, keep track of a history of moves by both the human and computer.

# 2. Extract the major nouns and verbs from the description.
# Nouns: history, moves
# Verbs: track

# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)
# Moves
#  - history
#  - #track

# 4. Do a spike to explore the problem w/ temporary code
# class RPSGame
#   history_of_moves = { human.name: [], computer.name: [] }
#   def track_moves
#     history_of_moves[human.name] << human.move.value
#     history_of_moves[computer.name] << computer.move.value
#   end

#   def display_history_of_moves
#     puts "|    #{human.name}     |    #{computer.name}    |"
#     puts "|    #{history[human.name][0]}     |    #{history[computer.name][0]}    |"
    
#     human_history = history_of_moves[human.name]
#     computer_history = history_of_moves[computer.name]
#     0.upto(human_history.size) do |idx|
#       puts "|    #{human_history[idx]}     |    #{computer_history[idx]}    |"
#     end
#   end
# end

# 5. When you have a better idea of the problem, model thoughts into CRC Cards (optional)
@history_of_moves = { human.name => [], computer.name => [] }
module Memorable
  DISPLAY_LENGTH = 15

  def update_move_history
    history_of_moves[human.name] << human.move.value
    history_of_moves[computer.name] << computer.move.value
  end

  def padding(num)
    " " * (DISPLAY_LENGTH - num)
  end

  def dashes
    "-" * DISPLAY_LENGTH
  end

  def history_header
    human_name = human.name
    computer_name = computer.name

    header_info = <<~HEREDOCS
    | #{human_name}#{padding(human_name.size)}| #{computer_name}#{padding(computer_name.size)}|
    | #{dashes}| #{dashes}|
    HEREDOCS

    header_info
  end

  def display_history_data(human, computer)
    0.upto(human.size - 1) do |idx|
      human_move = human[idx]
      computer_move = computer[idx]

      puts <<~HEREDOCS
      | #{human_move}#{padding(human_move.size)}| #{computer_move}#{padding(computer_move.size)}|
      HEREDOCS
    end
  end

  def display_history_table
    human_history = history_of_moves[human.name]
    computer_history = history_of_moves[computer.name]
    
    puts history_header
    display_history_data(human_history, computer_history)
  end
end