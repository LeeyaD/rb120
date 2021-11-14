require 'pry'
require 'pry-byebug'

class Participant
  attr_accessor :hand
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def hit
    # can get 1 card dealt to their hand
  end
  def stay; end
  def busted?; end
  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Player
  def initialize
    # what would the 'data' or 'state' of a Player object have?
    # maybe cards? a name?
  end

end

class Dealer
  DEALER_LIMIT = 17
end

class Deck
  SUITS = %w(spades hearts diamonds clubs)
  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  attr_accessor :cards

  def initialize
    @cards = VALUES.product(SUITS).shuffle!
  end

  def deal_initial_cards
    
  end

  def deal_card
    cards.shift
  end
end

class Card
  FACE_CARDS = {
    "J" => "Jack", "Q" => "Queen",
    "K" => "King", "A" => "Ace"
  }

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Game
  GAME_LIMIT = 21

  attr_accessor :deck
  attr_reader :player, :dealer
  
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end

  def start
    display_welcome_message
    # deal_cards
    # show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

Game.new.start