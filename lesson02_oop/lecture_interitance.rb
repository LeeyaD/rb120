class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

# PROBLEM 1
# One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviors. For example, bulldogs can't swim, but all other dogs can.
# Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"
class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

karl = Bulldog.new
puts karl.speak
puts karl.swim

# PROBLEM 2
# Let's create a few more methods for our Dog class.
# Create a new class called Cat, which can do everything a dog can, except swim or fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste all methods in Dog into Cat; try to come up with some class hierarchy.
class Cat < Pet
  def speak
    'meow!'
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run
# puts pete.speak

puts kitty.run
puts kitty.speak
# puts kitty.fetch

puts dave.speak

puts bud.run
puts bud.swim

# PROBLEM 3
# Draw a class hierarchy diagram of the classes from step #2
# Pet
# - Cat
# - Dog
# --- Bulldog

# PROBLEM 4
# What is the method lookup path and how is it important?
# The order in which Ruby looks up the method being called.

