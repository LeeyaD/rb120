require 'yaml'

MESSAGES = YAML.load_file('oo_rps_messages.yml')

module GamePlay
  def messages(message)
    MESSAGES[message]
  end

  def clear_screen
    system 'clear'
  end

  def return_to_continue
    puts ""
    puts "Press 'enter' to continue"
    gets
    clear_screen
  end

  def pause(num)
    sleep num
  end

  def pause_and_clear(num)
    pause(num)
    clear_screen
  end
end

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

  def reset_move_history
    self.history_of_moves = { human.name => [], computer.name => [] }
  end
end

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
      puts "Sorry, you must enter a value."
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
  attr_reader :value, :beats

  def to_s
    value
  end

  def >(other_move)
    beats.include?(other_move.value)
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = ['scissors', 'lizard']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['paper', 'spock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['scissors', 'rock']
  end
end

class Score
  include GamePlay

  WINS = 3

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
    pause(1)
    puts "#{human}: #{board[human.to_sym]} | " \
    "#{computer}: #{board[computer.to_sym]}"
    puts ""
  end

  private

  attr_writer :board
  attr_reader :human, :computer
end

class RPSGame
  include Memorable
  include GamePlay

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
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @score = Score.new(human.name, computer.name)
    @history_of_moves = { human.name => [], computer.name => [] }
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts ""
    puts "Win #{Score::WINS} rounds to become the Grand Winner!"
    puts ""
  end

  def show_rules?
    puts "Would you like to see the rules? (y/yes)"
    answer = gets.chomp.strip.downcase
    ['y', 'yes'].include?(answer) || answer == "\r"
  end

  def show_rules
    clear_screen
    puts messages('rules')
    return_to_continue
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
    pause(1)
    puts "#{computer.name} chose: #{computer.move}."
    puts ""
  end

  def find_winner
    self.winner = nil
    if human.move > computer.move
      self.winner = human.name.to_sym
    elsif computer.move > human.move
      self.winner = computer.name.to_sym
    end
  end

  def display_winner
    puts winner ? "#{winner} won!" : "It's a tie!"
    puts ""
  end

  def find_grand_winner
    self.grand_winner = score.board.key(Score::WINS)
  end

  def display_grand_winner
    puts ""
    puts "#{grand_winner} is the grand winner with a score of #{Score::WINS}!"
    puts ""
  end

  def winner_sequence
    pause(1)
    find_winner
    display_winner
  end

  def grand_winner_sequence
    find_grand_winner

    display_grand_winner if grand_winner
    display_history_table if see_history?

    score.set_board if grand_winner
    reset_move_history if grand_winner
  end

  def score_sequence
    return_to_continue
    score.update(winner)
    score.display
  end

  def move_sequence
    clear_screen
    players_move
    update_move_history
    pause_and_clear(1)
    display_moves
  end

  def welcome_sequence
    pause_and_clear(1)
    display_welcome_message
    show_rules if show_rules?
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

  def game_play_sequence
    move_sequence
    winner_sequence
    score_sequence
    return_to_continue
  end

  def play
    welcome_sequence
    loop do
      game_play_sequence
      grand_winner_sequence
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  attr_accessor :human, :computer, :score, :winner,
                :grand_winner, :history_of_moves
end

RPSGame.new.play
