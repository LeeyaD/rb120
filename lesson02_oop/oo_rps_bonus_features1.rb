require 'pry'
require 'pry-byebug'

class Player
  attr_reader :move, :name

  def initialize
    set_name
  end

  private

  attr_writer :move, :name
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp.strip.capitalize
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, spock:"
      choice = gets.chomp.strip.downcase.to_sym
      break if RPSGame::MOVES.keys.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = RPSGame::MOVES[choice]
  end
end

class Computer < Player
  PERSONALITIES = {
    'R2D2' => { rock: 1 },
    'Hal' => { scissors: 4, lizard: 2, spock: 2, rock: 1 },
    'Number 5' => { scissors: 1, lizard: 2, spock: 2, rock: 1, paper: 1 },
    'Chappie' => { scissors: 1, lizard: 1, spock: 1, rock: 1, paper: 1 }
  }

  def set_name
    self.name = ['R2D2', 'Hal', 'Number 5', 'Chappie'].sample
  end

  def choose
    choice = choices.sample
    self.move = RPSGame::MOVES[choice]
  end

  def choices
    PERSONALITIES[name].each_with_object([]) do |(move, frequency), array|
      array << Array.new(frequency, move)
    end.flatten
  end
end

class Move
  attr_reader :value

  def to_s
    value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    ['scissors', 'lizard'].include?(other_move.value)
  end

  def <(other_move)
    ['paper', 'spock'].include?(other_move.value)
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other_move)
    ['rock', 'spock'].include?(other_move.value)
  end

  def <(other_move)
    ['scissors', 'lizard'].include?(other_move.value)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    ['paper', 'lizard'].include?(other_move.value)
  end

  def <(other_move)
    ['rock', 'spock'].include?(other_move.value)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    ['paper', 'spock'].include?(other_move.value)
  end

  def <(other_move)
    ['scissors', 'rock'].include?(other_move.value)
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    ['scissors', 'rock'].include?(other_move.value)
  end

  def <(other_move)
    ['paper', 'lizard'].include?(other_move.value)
  end
end

class Score
  WINS = 2 # change to 10 wins when you're done w/ assignment

  attr_reader :board

  def initialize(human, computer)
    @human = human
    @computer = computer
    set_board
  end

  def set_board
    self.board = { "#{human}": 0, "#{computer}": 0 }
  end

  def update(winner)
    board[winner] += 1 if winner
  end

  def display
    puts "The current score is..."
    puts "#{human}: #{board[human.to_sym]} | " \
    "#{computer}: #{board[computer.to_sym]}"
  end

  private

  attr_writer :board
  attr_reader :human, :computer
end

class RPSGame
  rock = Rock.new
  paper = Paper.new
  scissors = Scissors.new
  lizard = Lizard.new
  spock = Spock.new

  MOVES = {
    rock: rock, paper: paper, scissors: scissors,
    lizard: lizard, spock: spock
  }

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new(human.name, computer.name)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def players_move
    human.choose
    computer.choose
  end

  def display_goodbye_message
    puts "Thanks for playing. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose: #{human.move}."
    puts "#{computer.name} chose: #{computer.move}."
  end

  def find_winner
    self.winner = nil
    if human.move > computer.move
      self.winner = human.name.to_sym
    elsif human.move < computer.move
      self.winner = computer.name.to_sym
    end
  end

  def display_winner
    puts winner ? "#{winner} won!" : "It's a tie!"
  end

  def find_grand_winner
    self.grand_winner = score.board.key(Score::WINS)
  end

  def display_grand_winner
    puts "#{grand_winner} is the grand winner with a score of #{Score::WINS}!"
  end

  def winner_sequence
    find_winner
    display_winner
  end

  def grand_winner_sequence
    find_grand_winner

    display_grand_winner if grand_winner
    score.set_board if grand_winner
  end

  def score_sequence
    score.update(winner)
    score.display
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.strip.downcase
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      players_move
      display_moves
      winner_sequence
      score_sequence
      grand_winner_sequence
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_accessor :human, :computer, :score, :winner, :grand_winner
end

RPSGame.new.play
