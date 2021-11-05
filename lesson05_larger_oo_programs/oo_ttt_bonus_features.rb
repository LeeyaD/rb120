require 'pry'
require 'pry-byebug'
module GameFlow
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

module Displayable
  def joinor(array, delimiter=', ', last='or')
    return array.first if array.size == 1
    output = ""
    last_item = "#{last} #{array.pop}"
    array.each { |num| output << "#{num}#{delimiter}"}
  
    output << last_item
    (array.size == 1) ? output.gsub(",", "") : output
  end
end

class Board
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  def initialize
    @squares = {}
    reset
  end

  def []=(square, marker)
    @squares[square].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    return false unless squares.all?(&:marked?)
    squares.collect(&:marker).all? do |sq|
      sq == squares.first.marker
    end
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  include GameFlow

  attr_reader :marker, :name

  def initialize(marker)
    @marker = marker
    @name = set_name
  end
end

class Human < Player
  def set_name
    clear_screen
    answer = nil
    loop do
      puts "What's your name? "
      answer = gets.chomp.strip.capitalize
      break if answer
      puts "Please enter a name."
    end
    return_to_continue
    answer
  end
end

class Computer < Player
  def set_name
    ["Howl", "Naussica", "Chihiro", "Lin"].sample
  end
end

class Score
  WINS = 2

  attr_accessor :score
  attr_reader :human_name, :computer_name

  def initialize(human_name, computer_name)
    @human_name = human_name
    @computer_name = computer_name
    reset
  end

  def reset
    @score = { human_name => 0, computer_name => 0}
  end

  def update(winner)
    self.score[winner] += 1
  end

  def grand_winner
    self.score.key(WINS)
  end

  def display
    puts ""
    puts "The scores are..."
    puts "#{human_name}: #{score[human_name]}"
    puts "#{computer_name}: #{score[computer_name]}"
    puts ""
  end
end

class TTTGame
  include Displayable
  include GameFlow

  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = true

  attr_reader :board, :human, :computer, :human_move, :scoreboard, :winner, :grand_winner

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @scoreboard = Score.new(human.name, computer.name)
    @human_move = FIRST_TO_MOVE
  end

  def play
    clear_screen
    display_welcome_message
    return_to_continue
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_move
      find_round_winner
      display_result
      update_and_display_score
      find_and_display_grand_winner
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def find_and_display_grand_winner
    find_grand_winner
    display_grand_winner if grand_winner
  end

  def find_grand_winner
    @grand_winner = scoreboard.grand_winner
  end

  def display_grand_winner
    puts "#{grand_winner} won the game with a score of #{Score::WINS}!"
  end

  def update_and_display_score
    update_score
    pause(1)
    display_score
  end

  def display_score
    scoreboard.display
  end

  def update_score
    scoreboard.update(winner) if winner
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe #{human.name}!"
    puts ""
    pause(1)
    puts "Today you'll be playing against #{computer.name}."
    puts ""
    pause(1)
    puts "First player to get to #{Score::WINS} wins the game!"
    puts ""
  end

  def display_goodbye_message
    puts ""
    puts "Thank you for playing. Goodbye!"
  end

  def display_board
    puts "You're #{HUMAN_MARKER}. Computer is #{COMPUTER_MARKER}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.strip.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @human_move = !FIRST_TO_MOVE
    else
      computer_moves
      @human_move = FIRST_TO_MOVE
    end
  end

  def human_turn?
    human_move
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    return_to_continue
  end

  def find_round_winner
    @winner = if board.winning_marker == human.marker
                human.name
              elsif board.winning_marker == computer.marker
                computer.name
              else
                nil
              end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.strip.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    @human_move = FIRST_TO_MOVE
    board.reset
    scoreboard.reset if grand_winner
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new

game.play
