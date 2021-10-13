require 'pry'
require 'pry-byebug'

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
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
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
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
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Score
  WINS = 2 #change to 10 wins when you're done w/ assignment

  attr_reader :board, :human, :computer
  
  def initialize(human, computer)
    @human = human
    @computer = computer
    set_board
  end

  def set_board
    @board = { "#{human}": 0, "#{computer}": 0 }
  end

  def update(winner) 
    board[winner] += 1 if winner
  end

  def display
    puts "The current score is..."
    board.each do |name, point|
      sleep 1
      puts "#{name}: #{point}"
    end
  end

  def reset
    @board = { "#{human}": 0, "#{computer}": 0 }
  end
end

class RPSGame
  attr_accessor :human, :computer, :score, :winner, :grand_winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    new_scoreboard
  end

  def new_scoreboard
    @score = Score.new(human.name, computer.name)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
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
    if grand_winner
      puts "#{grand_winner} is the grand winner with a score of #{Score::WINS}!"
    end
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
      human.choose
      computer.choose
      display_moves
      find_winner
      display_winner
      score.update(winner)
      score.display
      find_grand_winner
      display_grand_winner
      score.reset if grand_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
