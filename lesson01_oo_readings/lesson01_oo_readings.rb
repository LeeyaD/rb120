# VOCAB - Encapsulation: A form of data protection. The ability to hide pieces of functionality, making it unavailable to the rest of the code base. Thus data cannot be manipulated or changes w/o explicit intention. This ability is done by creating objects, and explosing interfaces (i.e. methods) to interact w/ those objects.
# * - We create encapsulation by NOT creating methods that'll interact w/ the data we want to hide? Ex. only creating a 'attr_reader' therefore, that particular atribute can't be changed, it's permanent as long the instance exists.

# VOCAB - Polymorphism: The ability for objects of different types to respond to the same method invocation

# VOCAB - Inheritance: When a class inherits the behaviors of another class, referred to as the 'superclass'. This allows us to define basic classes with larger reusability and smaller 'subclasses' for fine-grained, detailed behavior

# VOCAB - Modules: Another way to implement polymorphism in our programs. Similar to classes, they contain shared behavior. *You CANNOT create an object from a module.*
# * Syntax
module Speak
end
# VOCAB - Mixin: When a module is mixed in with a class using the 'include' method invocation. Once mixed in, the behaviors declared in that module are available to the class & it's objects.
# EXAMPLE #
# 'include Speak' in 'GoodDog' & 'HumanBeing' classes, instances from both classes now respond to methods within the 'Speak' module (i.e. .speak, .whisper)
# ??? - Also used as a namespace?

# OBJECTS
# - created from classes
# - classes are molds & OBJS the things produced from those molds
# - Individual OBJS contain diff. info from other OBJS but they're instances of the same class

# CLASSES
# - defines it's objects attributes & behaviors 'aka' STATES & BEHAVIORS
#   - states track attributes for individual objects using INSTANCE variables
#    - clearly scoped at the obj (instance)  level since each obj has them to keep track of their states
#   * instance var keep track of state *
#   - behaviors are what objects can do using instance methods
#    - different objs that are still objs/instances of the same class have the same behavior
#   * instance methods expose behaviors for objects *
end
# * Syntax
class GoodDog # <- CamelCase
  # filename (snake_case) -> good_dog.rb
end
sparky = GoodDog.new # .new returns an object
# 'sparky' is an "obj / instance of class 'GoodDog'" == "we instantiated an obj called 'sparky' from the class 'GoodDog'"

# ** all objects of the same class have the same behaviors but different states

# VOCAB - Instantiation: the entire workflow of creating a new obj / instance from a class

# METHOD LOOKUP
# Ruby has a distinct lookup path each time a method is called
# we can use #ancestors to see the method lookup chain

# INITIALIZING A NEW OBJECT
class GoodDog
  def initialize # <- a 'constructor' b/c it gets triggered whenever we create a new object
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new # => "This object was initialized!"
# the class method, #new, ? leads to ? the instance method, #initialize

# INSTANCE VARIABLE - @[var]
# - exists as long as the object (instance) exists
class GoodDog
  def initialize(name)
    @name = name
  end
end

sparky = GoodDog.new("Sparky") # String obj passes from #new to #initialized where it's assigned to the local var 'name'. Our constructor then sets our instance var to name

# INSTANCE METHODS - regular syntax for defining methods
# * instance methods have access to instance variables, and so it's through instance methods that we can expose information abt the state of an obj

# ACCESSOR METHODS
# - getter method: allows us access to our obj state
# * it's only job is to return the instance var
def get_name
  @name
end
puts sparky.get_name # => 'Sparky'
# - setter method: allows us to change the attributes (state) of our object (instance)
def set_name=(name)
  @name = name
end
sparky.set_name = "Duke" # < syntactic sugar, Ruby knows this is a setter method (sparky.set_name=('Duke')) but allows us to use more natural assignment

# ** convention dictates getter & setter methods be named after the instance variables they're exposing & setting
def get_name -> def name
def set_name=(name) -> def name=(n)

# ** setter methods ALWAYS return the value that was passed in as an argument. Any attempt to return something else gets ignored (i.e. another last line of code in the method)

# ** getter & setter methods can take up a lot of space, especially with more attributes to track. Thus, 'attr_accessor' method is used, it replaces both the getter & setter methods
class GoodDog
  attr_accessor :name, :multiple, :attributes
end
puts sparky.name
sparky.name = "Duke"
# 'attr_accessor' takes a symbol ':name' as an arg and creates the method name for getter & setter methods using it as well as a instance variable
# ex. attr_accessor :name => #name, #name=, @name
attr_reader # if we want a getter method w/o a setter
attr_writer # vice versa

# ACCESSOR METHODS IN ACTION
# from (rather than call our instance var directly)
def speak
  "#{@name} says arf!"
end
# to (best practice to use our getter method, thanks to 'attr_accessor' up top)
def speak
  "#{name} says arf!"
end
# 1 Use case: Say we wanted to alter the appearance of the name, '@name.upcase', we'd have to write that whereever it's used. If we decide to change it's appearance later '@name.capitalize' we'd have to go thru our code & change every occurance.
# Had we used getter method, like below, we'd only have to change ONE place in our code
def name
  @name.upcase
end

# CALLING METHODS W/ SELF
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end
# calling our setter methods within #change_info didn't work..why? BECAUSE Ruby thought we were initializing local variables!
# We have to use 'self.' for Ruby to know we're calling the setter method & not initializing local variables
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
# Not required but we could adopt the same syntax for getter methods
def info
  "#{name} weighs #{weight} and is #{height} tall."
end
def info
  "#{self.name} weighs #{self.weight} and is #{self.height} tall."
end

# * 'self.' can be used for other instance methods, not just accessor methods
class GoodDog
  # ... rest of code omitted for brevity
  def some_method
    self.info
  end
end

# CLASS METHODS
# methods we can call directly on the class itself, without having to instantiate any objects
# * Syntax:
def self.what_am_i
  "I'm a GoodDog class"
end
# where functionality that doesn't pertain to individual instances is stored

# CLASS VARIABLES - @@
# capture information pertaining to the entire class itself

# THE to_s METHOD
# an instance method that's built into every class in Ruby
# * #puts automatically calls #to_s in it's arg
puts sparky == puts sparky.to_s
# By default, when called on a class, #to_s returns the objects class and an encoding of the object id
# * #puts calls #to_s on any arg that's not an array. For an array, it writes on separate lines the result of calling #to_s on each element
# when defining a #to_s method in our class we override the #to_s instance method
# ** #to_s is also automatically called in string interpolation
# KNOWING when #to_s is called (#puts & string interpolation) will help us understand how to read & write better OO code

# #p similar to #puts, automatically calls another built in Ruby method..#inspect
# * #inspect is very helpful for debugging purposes so we never want to override it
p sparky == puts sparky.inspect

# MORE ABOUT 'self'
# it can refer to different things depending on where it's referenced
# 2 clear uses:
# - ONE. Used when calling setter methods withing the class. This allows Ruby to differentiate between initializing a local variable & calling a setter method
# ** when used within an instance method, it references the CALLING OBJECT
self.name= == sparky.name= #ALSO...
def info
  "#{self.name} weighs #{self.weight} and is #{self.height} tall."
end
sparky.info #=> "#{sparky.name} weighs #{sparky.weight} and is #{sparky.height} tall."
# - TWO. Used when defining class methods
# ** when used outside of an instance method but within a class, it references the class itself
class GoodDog
  puts self
end
GoodDog # => GoodDog, therefore...
def self.class_method == def GoodDog.class_method
# it's actually being defined on the class





