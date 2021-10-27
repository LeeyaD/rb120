# 1. Write a textual description of the program or exercise.
# As long as the user doesn't quit, keep track of a history of moves by both the human and computer. 
# What data structure will you reach for? A hash; keys are the player & computer names, values are the moves they've made in the game

# history = { player: [rock, paper], computer: [paper, scissors] }
# Will you use a new class, or an existing class? The existing class Move
# What will the display output look like? (rock 4, paper/spock 5, lizard 6, scissors 8)
# > a table with 2 columns, headers are the players' names, each column width is 19 (|--------|--------|), with the move centered

# 2. Extract the major nouns and verbs from the description.
# Nouns: history, moves
# Verbs: track

# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)
# Moves
#  - history
#  - #track

# 4. Do a spike to explore the problem w/ temporary code

# 5. When you have a better idea of the problem, model thoughts into CRC Cards (optional)
module DisplayableHistory
  DISPLAY_LENGTH = 15

  def padding(num)
    " " * (DISPLAY_LENGTH - num)
  end

  def dashes
    "-" * DISPLAY_LENGTH
  end

  def history_header    
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
    human_history = move_history[human_name]
    computer_history = move_history[computer_name]
    
    puts history_header
    display_history_data(human_history, computer_history)
    return_to_continue
  end

  def see_history?
    answer = nil
    
    loop do
      puts "Would you like to see a history of moves made? (y/n)"
      answer = gets.chomp.strip.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, answer must be a y or n."
    end
    
    return true if answer == 'y'
    return false if answer == 'n'
  end
end

class MoveHistory #add to RPSGame#initialize: history_of_moves = MoveHistory(human.name, computer.name)
  include DisplayableHistory # ^^^symbols
  attr_accessor :move_history

  def initialize(human_name, computer_name) # symbols
    @move_history = { human_name => [], computer_name => [] }
    assign_player_names
  end
  
  def assign_player_names
    @human_name, @computer_name = get_player_names
  end
  
  def get_player_names
    move_history.keys
  end
  
  def update(human_move, computer_move) #Move objects value, string
    move_history[human_name] << human_move
    move_history[computer_name] << computer_move
  end
  
  def reset
    move_history = { human_name => [], computer_name => [] }
  end

  protected

  attr_reader :human_name, :computer_name
end