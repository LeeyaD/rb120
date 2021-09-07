# 1. How do we create an object in Ruby? Give an example of the creation of an object.

# By defining a class
class HumanBeing
end
# Then, instantiating an object from the class using the #new instance method
leeya = HumanBeing.new


# 2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# A group of behaviors (i.e. methods). Helps us use polymorphism in our program, when it's 'mixed in' (via #include) with a class, that class and its objects have access to the methods defined in that module
module Speak
end

class HumanBeing
  include Speak
end