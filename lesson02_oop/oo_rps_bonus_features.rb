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
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Number 5', 'Chappie'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    # self.move = Move.new(Move::VALUES.values.sample)
  end
end

class Move
  VALUES = [:rock, :paper, :scissors, :lizard, :spock]

  WINNING_MOVES = {
    rock: ['scissors', 'lizard'],
    paper: ['rock', 'spock'],
    scissors: ['paper', 'lizard'],
    lizard: ['spock', 'paper'],
    spock: ['rock', 'scissors']
  }

  LOSING_MOVES = {
    rock: ['paper', 'spock'],
    paper: ['lizard', 'scissors'],
    scissors: ['rock', 'spock'],
    lizard: ['scissors', 'rock'],
    spock: ['lizard', 'paper']
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_MOVES[value].include?(other_move.to_s)
  end

  def <(other_move)
    LOSING_MOVES[value].include?(other_move.to_s)
  end

  def to_s
    value.to_s
  end

  private

  attr_reader :value
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
  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new(human.name, computer.name)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
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
