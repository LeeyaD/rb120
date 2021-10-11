The game flow should go like this:
the user makes a choice
the computer makes a choice
the winner is displayed

The only difference now is that we will be coding it in Object Oriented Programming style, using classes and objects.

The classical approach to object oriented programming is:
1. Write a textual description of the problem or exercise.
2. Extract the major nouns and verbs from the description.
3. Organize and associate the verbs with the nouns.
   -> The NOUNS == CLASSES and the VERBS == BEHAVIORS/METHODS.
------------
Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then its a tie.
------
Nouns: player, move*, rule
Verbs: choose, compare
*ignored "rock", "paper" or "scissors", since they are all variations on a move -- almost like different states of a move. Therefore, we capture the major noun: move.

Player
 - choose
Move
Rule

- compare