# PROBLEM HAS 'approach/algorithm' & 'hint'
# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:

class Card
  include Comparable

  RANKING = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank_index(r)
    RANKING.index(r)
  end

  def <=>(other_card)
    if rank_index(rank) < rank_index(other_card.rank)
      -1
    elsif rank_index(rank) == rank_index(other_card.rank)
      0
    else
      1
    end
  end

  # def ==(other_card)
  #   [rank, suit] == [other_card.rank, other_card.suit]
  # end

  def to_s
    "#{rank}" + " of " + "#{suit}"
  end
end

# For this exercise, numeric cards are low cards, ordered from 2 through 10. Jacks are higher than 10s, Queens are higher than Jacks, Kings are higher than Queens, and Aces are higher than Kings. The suit plays no part in the relative ranking of cards.

# If you have two or more cards of the same rank in your list, your min and max methods should return one of the matching cards; it doesn't matter which one.

# Besides any methods needed to determine the lowest and highest cards, create a #to_s method that returns a String representation of the card, e.g., "Jack of Diamonds", "4 of Clubs", etc.

#max method
# CALLING OBJ: An array of Card objects
# RETURN: The highest ranking Card object
# - if given array contains 2 high cards of equal rank, return either of them, doesn't matter which
# - numeric cards are low, ordered 2 thru 10. Jacks are higher than 10s, Queens higher than Jacks, Kings higher than Queens, and Aces higher than Kings

# DS: Array
# ALGO:
# INIT an empty hash called 'index_values'
# INIT an empty array called 'sorted_cards'
# INIT a constant 'RANKING' that lists from left to right, the lowest to highest cards
# RANKING = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
# ITERATE thru given Array of Card objects, for each Card obj:
# -- DETERMINE the index # of its rank in RANKING & store it in a local variable 'key'
# -- - also store the Card object in a local variable 'value'
# -- ADD pair, key (index #) & value (rank), to 'index_values' hash
# GATHER an array of keys from 'index_values' hash & store in a var, 'indexes'
# SORT 'indexes' and store in 'sorted_indexes'
# ITERATE thru 'sorted_indexes' and for each index:
# -- REFERENCE the Card object in 'index_values' using the given index
# -- ADD Card value to 'sorted_cards'
# RETURN the last Card object in 'sorted_cards' for our #max method and the first for #min

# Examples:
cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

# Output:
# 2 of Hearts
# 10 of Diamonds
# Ace of Clubs
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true

# FURTHER EXPLORATION
# Assume you're playing a game in which cards of the same rank are unequal. In such a game, each suit also has a ranking. Suppose that, in this game, a 4 of Spades outranks a 4 of Hearts which outranks a 4 of Clubs which outranks a 4 of Diamonds. A 5 of Diamonds, though, outranks a 4 of Spades since we compare ranks first. Update the Card class so that #min and #max pick the card of the appropriate suit if two or more cards of the same rank are present in the Array.
class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  FACE_RANK = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def suit_rank
    FACE_RANK.fetch(suit)
  end

  def <=>(other_card)
    if value == other_card.value
      suit_rank <=> other_card.suit_rank
    end
    value <=> other_card.value
  end
end
 
cards = [Card.new(2, 'Hearts'),
         Card.new(2, 'Diamonds'),
         Card.new('Ace', 'Clubs'),
         Card.new('Ace', 'Spades')]
puts cards.min == Card.new(2, 'Diamonds')
puts cards.max == Card.new('Ace', 'Spades')