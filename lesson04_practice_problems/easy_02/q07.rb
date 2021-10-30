# If we have a class such as the one below:
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
# Explain what the @@cats_count variable does and how it works. 
# It's a class variable that keeps track of how many instances of the Cat class are created
# Each time a new object from Cat class is initialized/created, the class variable increments by 1
# What code would you need to write to test your theory?
puts Cat.cats_count
kitty = Cat.new("black")
puts Cat.cats_count