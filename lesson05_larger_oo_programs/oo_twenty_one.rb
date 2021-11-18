require 'pry'
require 'pry-byebug'
require 'yaml'

module GameFlow
  MESSAGES = YAML.load_file('oo_twenty_one_messages.yml')
  VALID_YES = %w(y yes)

  def messages(message)
    puts MESSAGES[message]
  end

  def clear_screen
    system 'clear'
  end

  def return_to_continue
    empty_line
    puts "Press 'enter' to continue"
    gets
    clear_screen
  end

  def pause(num)
    sleep(num)
  end

  def pause_and_clear_screen(num)
    pause(num)
    clear_screen
  end

  def empty_line
    puts ""
  end
end

class Participant
  include GameFlow

  attr_accessor :hand
  attr_reader :name

  def initialize
    @hand = []
  end

  def busted?
    total > Game::GAME_LIMIT
  end

  def counting_cards(values, sum)
    values.each do |value|
      sum += if value == "A"
               11
             elsif value.to_i == 0
               10
             else
               value.to_i
             end
    end
    sum
  end

  def counting_a(values, sum)
    values.select { |value| value == "A" }.count.times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def total
    values = hand.map(&:value)

    sum = 0
    sum = counting_cards(values, sum)
    new_sum = counting_a(values, sum)
    new_sum
  end

  def compare_hands(other_player)
    if total > other_player.total
      self
    elsif total < other_player.total
      other_player
    elsif total == other_player.total
      # return nil
    end
  end

  def reset
    self.hand = []
  end

  def use_player_name
    self.class == Player ? "You" : name
  end

  def end_of_turn_sequence
    name = use_player_name
    if busted?
      puts "#{name} busted with #{total}!"
      empty_line
    else
      empty_line
      puts "#{name} chose to stay."
    end
    empty_line
  end

  def human?
    self.class == Player
  end
end

class Player < Participant
  def initialize
    super
    set_name
  end

  def set_name
    answer = nil
    loop do
      puts "What is your name?"
      answer = gets.chomp.strip.capitalize
      break if !answer.empty?
      puts "Please enter a name."
      empty_line
    end

    @name = answer
  end

  def show_hand
    puts "You have:"
    hand.each do |card|
      pause(0.75)
      puts card
    end
    empty_line
  end

  def hit?
    answer = nil
    loop do
      empty_line
      puts "Would you like to hit or stay?"
      answer = gets.chomp.strip.downcase
      break if %w(hit stay).include?(answer)
    end

    answer == 'hit'
  end
end

class Dealer < Participant
  DEALER_LIMIT = 17

  def initialize
    super
    @name = self.class.to_s
  end

  def show_hand
    puts "#{name} has:"
    hand.each_with_index do |card, idx|
      pause(0.75)
      if idx == 0
        puts "[Hidden Card]"
      else
        puts card
      end
    end
    puts ""
  end

  def hit?
    total <= 17
  end
end

class Deck
  SUITS = %w(Spades Hearts Diamonds Clubs)
  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_accessor :cards

  def initialize
    create_deck
  end

  def create_deck
    @cards = VALUES.product(SUITS).shuffle!
    @cards.map! do |card|
      value, suit = card
      Card.new(value, suit)
    end
  end

  def deal_card
    cards.slice!(0, 1)
  end

  def reset
    create_deck
  end
end

class Card
  FACE_CARDS = {
    "J" => "Jack", "Q" => "Queen",
    "K" => "King", "A" => "Ace"
  }

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    val = FACE_CARDS.key?(value) ? FACE_CARDS[value] : value
    "#{val} of #{suit}"
  end
end

class Game
  include GameFlow

  GAME_LIMIT = 21

  attr_accessor :deck, :winner
  attr_reader :player, :dealer

  def initialize
    clear_screen
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def welcome_sequence
    clear_screen
    display_welcome_message
    pause(1)
    show_rules if show_rules?
  end

  def show_rules
    clear_screen
    messages('rules')
    return_to_continue
  end

  def show_rules?
    empty_line
    messages('rules?')
    answer = gets.chomp.strip.downcase
    VALID_YES.include?(answer)
  end

  def display_welcome_message
    puts "Welcome to Twenty-One #{player.name}!"
  end

  def display_goodbye_message
    puts "Thank you for playing. Goodbye!"
  end

  def deal_initial_cards
    clear_screen
    puts "Dealing first two cards..."
    empty_line
    pause(1.5)
    2.times do
      deal_card(player)
      deal_card(dealer)
    end
  end

  def deal_card(player)
    player.hand << deck.deal_card
    player.hand.flatten!
  end

  def show_cards
    dealer.show_hand
    pause(1)
    player.show_hand
    pause(0.5)
    # show_player_total
    # empty_line
  end

  def show_player_total
    puts "You have a total of #{player.total}."
  end

  def hit(player)
    empty_line
    name = player.use_player_name
    puts name + " chose to hit..."
    return_to_continue
    deal_card(player)
  end

  def player_turns
    show_cards
    show_player_total
    participant_turn(player)
    return_to_continue
    participant_turn(dealer)
  end

  def participant_turn(player)
    if !player.human?
      puts "Dealer's turn..."
      empty_line
    end

    # show_cards
    # show_player_total if player.human?

    loop do
      hit = player.hit?
      if hit
        hit(player)
        show_cards
        pause(0.75)
        show_player_total if player.human?
      end
      break if !hit || player.busted?
    end

    player.end_of_turn_sequence
  end

  def player_turn
    loop do
      hit = player.hit?
      if hit
        hit(player)
        pause(0.75)
        show_player_total if !player.busted?
      end
      break if !hit || player.busted?
    end

    player.end_of_turn_sequence
  end

  def dealer_turn
    loop do
      hit = dealer.hit?
      if hit
        hit(dealer)
      end

      break if !hit || dealer.busted?
    end

    dealer.end_of_turn_sequence
  end

  def show_result
    @winner = player.compare_hands(dealer)
    if winner
      empty_line
      puts "#{winner.name} won with #{winner.total}."
    else
      puts "No one won, it was a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      empty_line
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.strip.downcase
      break if %w(y n).include?(answer)
      puts "Please choose y or n"
    end

    answer == 'y'
  end

  def reset
    self.winner = nil
    deck.reset
    player.reset
    dealer.reset
    clear_screen
  end

  def start
    welcome_sequence
    loop do
      # deal_and_show_initial_cards
      deal_initial_cards
      player_turns
      show_result if !winner
      break if !play_again?
      reset
    end
    display_goodbye_message
  end
end

Game.new.start
