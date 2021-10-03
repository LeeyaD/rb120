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

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'
# -----------------------------------------------------------

# Problem 3
# Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name = "")
    @first_name = first_name
    @last_name = last_name
  end

  def name
    @first_name + ' ' + @last_name
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'