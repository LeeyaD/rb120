require 'pry'
require 'pry-byebug'
module GameFlow
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

  def total
    values = hand.map(&:value)

    sum = 0
    values.each do |value|
      sum += if value == "A"
               11
             elsif value.to_i == 0
               10
             else
               value.to_i
             end
    end

    values.select { |value| value == "A" }.count.times do
      sum -= 10 if sum > 21
    end

    sum
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
      puts card
    end
    empty_line
  end

  def hit_or_stay?
    answer = nil
    loop do
      puts ""
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
    @name = self.class
  end

  def show_hand
    puts "#{self.name} has:"
    hand.each_with_index do |card, idx|
      if idx == 0
        puts "[Hidden Card]"
      else
        puts card
      end
    end
    puts ""
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
    return_to_continue
  end

  def show_and_deal_initial_cards
    deal_initial_cards
    show_cards
    show_player_total
    return_to_continue
  end

  def display_welcome_message
    puts "Welcome to Twenty-One #{player.name}!"
  end

  def display_goodbye_message
    puts "Thank you for playing. Goodbye!"
  end

  def deal_initial_cards
    puts "Dealing first two cards..."
    puts ""
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
    player.show_hand
  end

  def show_player_total
    puts "You have a total of #{player.total}."
  end

  def player_turn
    loop do
      hit = player.hit_or_stay?
      if hit
        empty_line
        puts "You chose to hit..."
        pause_and_clear_screen(1)
        deal_card(player)
        show_cards
        show_player_total
      end
      break if !hit || player.busted?
    end

    if player.busted?
      self.winner = dealer
      puts "You busted with #{player.total}!"
    else
      puts "You chose to stay."
    end
    empty_line
  end

  def dealer_turn
    loop do
      if dealer.total < 17
        puts "#{dealer.name} chose to hit..."
        pause_and_clear_screen(1)
        deal_card(dealer)
        show_cards
      end

      break if dealer.total >= 17 || dealer.busted?
    end

    if dealer.busted?
      self.winner = player
      puts "#{dealer.name} busted with #{dealer.total}!"
    else
      puts "#{dealer.name} chose to stay."
    end
    puts ""
  end

  def show_result
    @winner = player.compare_hands(dealer)
    if winner
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
      show_and_deal_initial_cards
      player_turn
      dealer_turn if !winner
      show_result if !winner
      break if !play_again?
      reset
    end
    display_goodbye_message
  end
end

Game.new.start
