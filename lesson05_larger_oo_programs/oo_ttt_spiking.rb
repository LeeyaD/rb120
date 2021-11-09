# Allow the player to pick any marker

# ON DECK: Computer turn refinements
# 1. Textual Description

# 2. Extract major nouns/verbs
# Nouns:
# Verbs:

# 3. Organize & Associate Nouns/Verbs (Nouns > classes, Verbs > behaviors/methods)

# 4. Spike it! & Do CRC cards one you understand it better
def choose_and_set_marker
  human_marker = choose_marker
  set_marker
end

def set_marker
  human.marker = COMPUTER_MARKER
  computer.marker = HUMAN_MARKER
end

def choose_marker
  answer = nil
  loop do
    puts "Would you like to be 'X' or 'O'? (1 for X or 2 for O)"
    puts "You are 'X' by default, would you like to be 'O' instead? (y/yes to switch to 'O')"
    answer = gets.chomp.strip
    break if %w(y yes).include?(answer)
  end

  answer.start_with?('y')
end




class TTTGame
  include AIStrategy

  def computer_moves # currently set to random
    defend_square if immediate_threat?
    choose_random_square
    
  end
end
