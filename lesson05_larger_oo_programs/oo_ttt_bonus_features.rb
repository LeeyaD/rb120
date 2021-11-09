require 'yaml'

MESSAGES = YAML.load_file('oo_ttt_messages.yml')

module GameFlow
  VALID_YES_NO = %w(y n)
  VALID_YES = %w(y yes)
  VALID_NUM_CHOICE = %w(1 2)

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

  def messages(message)
    puts MESSAGES[message]
  end
end

module Displayable
  def joinor(array, delimiter=', ', last='or')
    return array.first if array.size == 1
    output = ""
    last_item = "#{last} #{array.pop}"
    array.each { |num| output << "#{num}#{delimiter}" }

    output << last_item
    array.size == 1 ? output.gsub(",", "") : output
  end
end

module AIStrategy
  attr_accessor :threat, :attack

  def choose_random_square
    board[board.unmarked_keys.sample] = computer.marker
  end

  def select_square(third_sq)
    board[third_sq] = computer.marker
  end

  def choose_middle_square
    board[5] = computer.marker
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

  def find_3rd_square(marker)
    Board::WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares, marker)
        line.each do |key|
          return key if @squares[key].marker == Square::INITIAL_MARKER
        end
      end
    end
    nil
  end

  def middle_sq_free?
    @squares[5].marker == Square::INITIAL_MARKER
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

  def two_identical_markers?(squares, marker)
    return false if squares.all?(&:marked?)
    squares.collect(&:marker).count(marker) == 2
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

  attr_accessor :marker
  attr_reader :name

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
    answer
  end

  def who_goes_first?
    answer = nil
    loop do
      puts ""
      puts "Who do you want to go first? (1 for yourself or 2 for the computer)"
      answer = gets.chomp.strip
      break if VALID_NUM_CHOICE.include?(answer)
      messages('invalid_1_2_choice')
      puts ""
    end

    answer
  end
end

class Computer < Player
  def set_name
    ["Howl", "Naussica", "Chihiro", "Lin"].sample
  end

  def who_goes_first?
    messages('computer_choosing')
    pause(1)
    %w(1 2).sample
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
    @score = { human_name => 0, computer_name => 0 }
  end

  def update(winner)
    score[winner] += 1
  end

  def grand_winner
    score.key(WINS)
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
  include AIStrategy

  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_accessor :human_move
  attr_reader :board, :human, :computer, :scoreboard,
              :winner, :grand_winner, :chooser

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @scoreboard = Score.new(human.name, computer.name)
  end

  def play
    clear_screen
    display_welcome_message
    show_rules if show_rules?
    choose_marker
    first_player_selection_sequence
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_move
      display_result
      update_and_display_score
      find_and_display_grand_winner
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def choose_marker
    change_marker if change_marker?
  end

  def change_marker
    human.marker = COMPUTER_MARKER
    computer.marker = HUMAN_MARKER
  end

  def change_marker?
    answer = nil
    loop do
      messages('change_marker')
      answer = gets.chomp.strip
      break
    end

    VALID_YES.include?(answer)
  end

  def show_rules?
    messages('show_rules?')
    answer = gets.chomp.strip.downcase
    VALID_YES.include?(answer)
  end

  def show_rules
    clear_screen
    messages('rules')
    return_to_continue
  end

  def first_player_selection_sequence
    clear_screen
    @chooser = who_chooses_first
    @human_move = !(chooser.who_goes_first? == "2")
    puts ""
    if human_move
      puts "You're going first!"
    else
      puts "#{computer.name} goes first!"
    end
    return_to_continue
  end

  def who_chooses_first
    case who_chooses_first_player
    when "1"
      human
    when "2"
      computer
    end
  end

  def who_chooses_first_player
    answer = nil
    loop do
      puts "Who gets to choose who goes first? "
      puts "(1 for you or 2 for #{computer.name})"
      answer = gets.chomp.strip
      break if VALID_NUM_CHOICE.include?(answer)
      messages('invalid_1_2_choice')
      puts ""
    end

    answer
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
    puts "Today you'll be playing against #{computer.name}."
    puts ""
    puts "First player to win #{Score::WINS} rounds wins the game!"
    puts ""
    return_to_continue
  end

  def display_goodbye_message
    puts ""
    puts "Thank you for playing. Goodbye!"
  end

  def display_board
    puts "You're #{human.marker}. Computer is #{computer.marker}."
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

  def detect_threat
    @threat = board.find_3rd_square(human.marker)
  end

  def detect_attack
    @attack = board.find_3rd_square(computer.marker)
  end

  def computer_selects_sq
    if attack
      select_square(attack)
    elsif threat
      select_square(threat)
    elsif board.middle_sq_free?
      choose_middle_square
    else
      choose_random_square
    end
  end

  def computer_moves
    detect_threat
    detect_attack
    computer_selects_sq
  end

  def current_player_moves
    if human_turn?
      human_moves
      @human_move = false
    else
      computer_moves
      @human_move = true
    end
  end

  def human_turn?
    human_move
  end

  def display_result
    find_round_winner
    clear_screen_and_display_board
    puts winner ? "#{winner} won!" : "It's a tie!"
    return_to_continue
  end

  def find_round_winner
    @winner = case board.winning_marker
              when human.marker then human.name
              when computer.marker then computer.name
              end
  end

  def play_again?
    answer = nil
    pause(1)
    loop do
      puts ""
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.strip.downcase
      break if VALID_YES_NO.include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    scoreboard.reset if grand_winner
    first_player_selection_sequence
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new

game.play
