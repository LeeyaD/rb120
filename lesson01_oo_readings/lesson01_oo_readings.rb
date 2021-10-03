# OOP - Object-Oriented Programming
# Ruby manipulates programing constructs called 'objects'; containers of data that can be changed & manipulated w/o affecting the entire program. This programming model that allows developers to section off areas of code that performed certain procedures so programs can become the interaction of many small parts, as opposed to one massive blob of dependency.

# VOCAB - Encapsulation: A form of data protection. The ability to hide pieces of functionality, making it unavailable to the rest of the code base. Thus data cannot be manipulated or changed w/o explicit intention. This ability is done by creating objects, and exposing interfaces (i.e. methods) to interact w/ those objects.
# * We create encapsulation by NOT creating methods that'll interact w/ the data we want to hide Ex. only creating a 'attr_reader' therefore, that particular atribute can't be changed, it's permanent as long the instance exists.
# AND by designating certain methods public, private, or protected.

# VOCAB - Polymorphism: The ability for objects of different types to respond to the same method invocation.
# in other words, in Ruby, we conentrate on the fact that methods with the same name do different things

# VOCAB - Modules: Another way to implement polymorphism in our programs. Similar to classes, they contain shared behavior. *You CANNOT create an object from a module.*
# * Syntax
module Speak
end
# VOCAB - Mixin: When a module is mixed in with a class using the 'include' method invocation. Once mixed in, the behaviors declared in that module are available to the class & it's objects.
# --------Mixin: when a module is used to mix additional behavior and information into a class. Mixins allow us to customize a class without having to rewrite code.
# EXAMPLE #
# 'include Speak' in 'GoodDog' & 'HumanBeing' classes, instances from both classes now respond to methods within the 'Speak' module (i.e. .speak, .whisper)

# OBJECTS
# - a combination of data & methods, objs can receive messages, send messages, and process data
# - created from classes
# - classes are molds/templates & objects the things produced from those molds/templates
# - Individual objects contain diff. info from other objs but they're instances of the same class

# CLASSES
# - defines it's objects attributes (STATE) & behaviors
#   - states track attributes for individual objects using INSTANCE variables
#    - clearly scoped at the obj (instance) level since each obj has them to keep track of their states
#   * instance var keep track of state *
#   - behaviors are what objects can do using instance methods
# - idea that a class groups behaviors (i.e. methods)
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

# VOCAB - Instantiation: the entire workflow of creating a new obj / instance from a class.
# #iniitalize is a 'constructor' in Ruby & constructors don't return any values.
# a constructors sole purpose is to initiate the state of an object
# 'constructor overloading' is the ability to have multiple constructors in a class.
# * ^ Ruby doesn't allow this but we can mimic this w/ default parameter values

# INITIALIZING A NEW OBJECT
class GoodDog
  def initialize # <- called the moment an object is created
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new # => "This object was initialized!"
# the class method, #new, ? leads to ? the instance method, #initialize

# INSTANCE VARIABLE - @[var] ('aka' member fields)
# - exists as long as the object (instance) exists
# - In Ruby, they're only accessible via methods
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
# 'attr_accessor' takes a symbol ':name' as an arg and creates the getter & setter methods and the instance variable
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
# an instance method that's built into every class in Ruby, it returns the string representation of the object
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

# INHERITANCE
# When a class inherits the behaviors of another class, referred to as the 'superclass'. This allows us to define basic classes with larger reusability and smaller 'subclasses' for fine-grained, detailed behavior
# "define basic classes with larger reusability" extract common behaviors from classes that share that behavior and move it to a superclass
# -- CLASS INHERITANCE
# * Syntax
class GoodDog < Animal
end
# * inheritance can be a great way to remove duplication in our codebase

# SUPER
# a Ruby keyword that allows us to call methods earlier in the method lookup path
# an example
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end
sparky = GoodDog.new
puts sparky.speak # "Hello! from GoodDog class"
# more common to use it in #initialize

# when super is called with no arguments, it automatically forwards all arguments passed into the method from which it was called. These arguments then get passed into the method super calls located further up the method lookup chain
# when super is called with specified arguments, only those arguments get along
# when super is called with empty '()', super(), it calls the method in the superclass with no arguments
# ** if there's a method in the superclass that takes no arguments its safest to use 'super()'

# MIXING IN MODULES
# another way to DRY up our code.
# unlike inheritance, it's not hierarchical 
# example of class based inheritance
#  Animal
#  - Fish
#  - Mammal
#   -- Cat
#   -- Dog
# we want a #swim method for class Fish, problem is some mammals can swin too.
# can't move #swim to class Animal b/c not all animals can swim, only some
# so how to we make #swim, a shared behavior, availabe to class Fish and class Dog & class Cat?
# we use a module
# ** Note: common naming convention for Ruby is to use the "able" suffix on whatever verb describes the behavior the module is modeling (e.g. our Swimmable module, or a module that describes "walking" as Walkable). Not all modules are named like this but it is quite common.
# *-- extend --* Using 'extend' rather than 'include' when mixing in a module, means the class itself can use the methods as opposed to to instances of the class.

# INHERITANCE vs. MODULES
# 2 primary ways Ruby impliments inheritance
# - ONE. Traditional inheritance, hierarchical
# -- one type inherits the behaviors of another type, thereby specializing the type of the superclass into fine-grained, detailed behavior
# - TWO. Interface inheritance, mixing in modules
# -- no inheritance from another time BUT inherits the interface provided by the mixed in module. In this case, re the module, the result is not a specialized type
# Consider the following 3 things when deciding whether to use inheritance vs. modules
# 1. You can only subclass (class inheritance) from one class. You can mix in as many modules (interface inheritance) as you'd like.
# 2. If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a dog "is an" animal and it "has an" ability to swim.
# 3. You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

# METHOD LOOKUP PATH
# Ruby has a distinct lookup path when a method is called, we use #ancestorsto see the 'lookup chain'
# => the order in which classes are inspected when you call a method
class Animal
  include Walkable
end
-----Animal Lookup Path------
Animal
Walkable
Object
Kernel
BasicObject

class GoodDog < Animal
  include Swimmable
  include Climbable
end
-----GoodDog Lookup Path------
GoodDog
Climbable
Swimmable
Animal
Walkable
Object
Kernel
BasicObject
# * the order in which we mixin our modules is important b/c Ruby looks at the last module we included FIRST
class GoodDog < Animal
  include Swimmable, Climbable
# including modules on one line, Ruby looks up left to right
-----GoodDog Lookup Path------
GoodDog
Swimmable
Climbable
# * even modules mixed in to superclasses are included in the lookup path

# MORE MODULES
# 2 more uses for modules
#  ONE. namespacing; separating classes/methods/constants into named spaces
# -- using modules to group related classes
module Mammal
  class GoodDog
    def speak(sound)
      p "#{sound}"
    end
  end
end
buddy = Mammal::Dog.new
# We call classes & constants in a module by appending the class name to the module name with two colons(::)
# :: - scope resolution operator - tells Ruby where to look for a specific bit of code
#    - it's how Ruby doesn't confuse Math::PI with Circle::PI, it knows where to look for 'PI'
# ** Built in modules that we want to use need to be explicitely brought in using 'require' (e.g. require 'date')
# 2nd EXAMPLE of using modules to group classes
module Forest
  class Rock ; end
  class Tree ; end
  class Animal ; end # Animals can be in a forest and in a town too (see below).
end
# In a single script, we can't define two Animal classes (they'd clash) but we solve this issue by putting them in separate modules
module Town
 class Pool ; end
 class Cinema ; end
 class Square ; end
 class Animal ; end
end
Forest::Animal.new
Town::Animal.new
#  TWO. using modules as a container for methods, called 'module methods'
# -- useful for methods that seem out of place in our code
module Mammal
  def self.out_of_place_method(arg)
    arg *2
  end
end
value = Mammal.out_of_place_method(4)
# defining methods within a module means we call the methods directly on the module OR
value = Mammal::some_out_of_place_method(4)
# but the first way is preferred
# ** Doesn't make sense to have variables in modules since they change but helpful constants are great

# PRIVATE, PROTECTED, AND PUBLIC
# ** another definition from exercise: The main difference between them is protected methods allow access between class instances, while private methods don't. If a method is protected, it can't be invoked from outside the class. This allows for controlled access, but wider access between class instances.
# VOCAB - Access Control: The ability to allow or restrict access to a particular thing through the use of 'access modifiers'. In Ruby, since we're concerned about allowing/restricting access to the methods in our class, the concept is referred to as Method Access Control.
# In Ruby MAC in achieved thru the use of 'private', 'protected' and 'public' access modifiers
# PUBLIC - all methods are automatically public unless 'private'/'protected' are used
#  - public method: available to the rest of the program to use (to anyone who knows the either the class or object's name) and "...comprise the class's interface (that's how other classes and objects will interact with this class and its objects)."
# ?? Should we do was codecademy deems good practice and state 'public' for clarity in our code?
# PRIVATE - methods that aren't available to the rest of the program, but only from other methods in the class (see syntax below). Separates the private implementation from the public interface
# defined simply by using the 'private' method, any methods located below it are private UNLESS another method like 'protected' is called to negate it
# * Syntax
def public_disclosure
  "#{self.name} in human years is #{human_years}"
  # * originally, couldn't be called with 'self' as it was the equivalent of calling 'sparky.human_years' but as of Ruby 2.7 it can be called w/ 'self' however it's availability remains the same, only the current object can call it
end

private

def human_years
  age * DOG_YEARS
end
# PROTECTED -
# - ONE - from inside the class, protected methods are accessible just like public methods.
# - TWO - from outside the class, protected methods act just like private methods.
class Person
  attr_writer :age

  def initialize(name)
    @name = name
  end

  def age_against(other)
    if age == other.age
      "#{name} is same age as #{other.name}."
    elsif age < other.age
      "#{name} is younger than #{other.name}."
    else
      "#{name} is older than #{other.name}."
    end
  end

protected # try to change this to private

attr_reader :age, :name
end

bob = Person.new("Bob")
bob.age = 20
jane = Person.new("Jane")
jane.age = 19
puts bob.age_against(jane)
# Difference btwn PRIVATE & PROTECTED can be seen here, when we have 2 objects of the same type (the Person class) that need access to each other's state or behavior
# protected allows access between objects of the same type, i.e. only instances of the class or a subclass can call the method. This allows us to share sensitive data between instances of the same class type)
# when a method is PRIVATE only the class--not instances of the class--can access it

# ACCIDENTAL METHOD OVERRIDING
# Every class inherently subclasses from class Object. Familiarize yourself w/ some common Object methods to make sure you don't accidentally override them as this can have devastating consequences for your application.

# FROM ZETCODE PART 2: RUBY EXCEPTIONS
# 