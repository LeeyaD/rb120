# Problem 1
# Given the below usage of the Person class, code the class definition.
# class Person
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'
# -----------------------------------------------------------

# Problem 2
# Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(first_name, last_name = "")
#     @first_name = first_name
#     @last_name = last_name
#   end

#   def name
#     @first_name + ' ' + @last_name
#   end
# end

# bob = Person.new('Robert')
# puts bob.name                  # => 'Robert'
# puts bob.first_name            # => 'Robert'
# puts bob.last_name             # => ''
# bob.last_name = 'Smith'
# puts bob.name                  # => 'Robert Smith'
# -----------------------------------------------------------

# Problem 3
# Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name=(n)
    parse_full_name(n)
  end

  def name
    @first_name + ' ' + @last_name
  end

  def to_s # Problem 5: Let's add a to_s method to the class
    name
  end
  private

  def parse_full_name(full_name)
    if full_name.split.size == 1
      self.first_name = full_name
      self.last_name = ''
    else
      @first_name, @last_name = full_name.split
    end
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
puts bob.first_name            # => 'John'
puts bob.last_name             # => 'Adams'
# -----------------------------------------------------------

# Problem 4
# Using the class definition from step #3, let's create a few more people -- that is, Person objects.
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

puts bob.name == rob.name
puts bob
# -----------------------------------------------------------

# Problem 5 (see above, #3)