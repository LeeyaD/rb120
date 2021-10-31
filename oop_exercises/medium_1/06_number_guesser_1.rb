# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:
class GuessingGame
  attr_accessor :guesses
  attr_reader :number

  def initialize # not needed!
    @guesses = 7
    @number = (1..100).to_a.sample
  end

  def display_guesses_left
    puts "You have #{guesses} guesses remaining."
  end

  def valid_input?(answer)
    (1..100).include?(answer)
  end

  def get_user_input
    answer = ''
    loop do
      puts "Enter a number between 1 and 100: "
      answer = gets.chomp.strip.to_i
      break if valid_input?(answer)
      puts "Invalid guess. Enter a number between 1 and 100: "
    end
    answer
  end

  def guess_right?(guess)
    number == guess
  end

  def guessing_result(guess)
    if guess > number
      puts "Your guess is too high."
    else
      puts "Your guess is too low."
    end
  end

  def update_guesses
    self.guesses -= 1
  end

  def no_guesses_left?
    guesses == 0
  end

  def reset_guesses
    self.guesses = 7
  end

  def play
    reset_guesses

    loop do
      display_guesses_left
      guess = get_user_input
      break if guess_right?(guess)
      guessing_result(guess)
      update_guesses
      break if no_guesses_left?
    end

    if no_guesses_left?
      puts ""
      puts "You have no more guesses. You lost!"
    else
      puts ""
      puts "That's the number! You won!"
    end
  end
end

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.
# ...
# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!
# # display text above & below this comment when guess is right
# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.
# ...
# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# Note that a game object should start a new game with a new number to guess with each call to #play.

# FURTHER EXPLORATION
# We took a straightforward approach here and implemented a single class. Do you think it's a good idea to have a Player class? 
# A: Unsure...IF there was a player class..
# What methods and data should be part of it? 
# A: behavior having to do with @guesses; storing the no. of guesses they have, updating/reseting guesses, asking for/getting/validating input
# How many Player objects do you need? 
# A: just one
# Should you use inheritance, a mix-in module, or a collaborative object?
# A: collab object since we plan on storing state 