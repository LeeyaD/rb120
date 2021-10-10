# What would happen in this case?
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name}."
  end
end
# This code "works" because of that mysterious to_s call in Pet#initialize. However, that doesn't explain why this code produces the result it does. Can you?

name = 42 # local var name initialized to the integer, 42
fluffy = Pet.new(name) # instance var @name assigned to the Str object "42"
name += 1 # local var name reassigned to the value of itself, 42, plus 1 -> 43
puts fluffy.name.class # => "42"
puts fluffy.class # => My name is 42.
puts fluffy.name.class # => "42"
puts name.class # => 43