# Computer personalities
# Keep track of a history of moves
# Add a class for each move
# Add Lizard & Spock

# Keeping Score
# Right now, the game doesn't have very much dramatic flair. It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins. Can you build this functionality? We have a new noun -- a score. Is that a new class, or a state of an existing class? You can explore both options and see which one works better.

# 1. Write a textual description of the program or exercise.
# - Starting from a score of 0 at the start of the game, at the end of each round increase the winning player's score by 1 point. As long as the user doesn't quit, the first player to get to 10 points wins the game.

# 2. Extract the major nouns and verbs from the description.
# - Nouns: score
# - Verbs: starting, increase

# 3. Organize and associate the verbs with the nouns (nouns -> classes | verbs -> methods)
# Score
# - starting
# - increase

# 4. Do a spike to explore the problem w/ temporary code
# - New Class
# - - Can add state to our class Scoreboard in the future should we want to keep track of winners & their scores
# - - Can format & display all scores
class Score
  # has a scoreboard
  # - scoreboard is created at start of game when player objects are created?
  # - - hash: player names the keys, scores the values
  # has a winner
  def add_point; end # increase 

  def reset; end # starting

  def declare_winner; end

  def display; end
end

class Player; end
class Human < Player; end
class Computer < Player; end
class Move; end
class RPSGame; end
# IF adding as state to an existing class, will need a module Scorable
# - CON: displaying scores
# - - when we want to display scores, we'll need a class RPSGame method to properly format & display both class Human and class Computer scores together
# - CON: future functionality
# - - if we want to keep track of winners and their scores we can't add state to the module, we'll need to add more state to class Player
module Scorable
  # can increase scores, #increase_score
  # can reset scores, #reset_score
  # can check if score has 10 points, #find_winner
  # can declare a winner, #declare_winner
end

class Player
  # has a score
end

# 5. When you have a better idea of the problem, model thoughts into CRC Cards (optional)
class Score
  attr_reader :human, :computer
  # has scores; human & computer objects

  # can increase (scores)
  def add_point; end

  # can display (scores)
  def display; end

  # can reset (scores)
  def reset; end
end