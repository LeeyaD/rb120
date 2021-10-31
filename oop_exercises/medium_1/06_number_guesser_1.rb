# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

game = GuessingGame.new
game.play
# get a random number between & including 1-100 for user to guess

You have 7 guesses remaining.
# keep track of guesses left
# display # of guesses left
Enter a number between 1 and 100: 104
# prompt user for guess
# get user input
Invalid guess. Enter a number between 1 and 100: 50
# prompt user again if input is invalid
Your guess is too low.
# display whether guess was correct, too high or too low

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!
# display text above & below this comment when guess is right
You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
#display this text when user runs out of quesses

# Note that a game object should start a new game with a new number to guess with each call to #play.
