# VOCAB - Encapsulation: A form of data protection. The ability to hide pieces of functionality, making it unavailable to the rest of the code base. Thus data cannot be manipulated or changes w/o explicit intention. This ability is done by creating objects, and explosing interfaced (i.e. methods) to interactwith those objects.
# ??? - We create encapsulation by NOT creating methods that'll interact w/ the data we want to hide?

# VOCAB - Polymorphism: The ability for objects of different types to respond to the same method invocation

# VOCAB - Inheritance: When a class inherits the behaviors of another class, referred to as the 'superclass'. This allows us to define basic classes with larger reusability and smaller 'subclasses' for fine-grained, detailed behavior

# VOCAB - Modules: Another way to implement polymorphism in our programs. Similar to classes, they contain shared behavior. *You CANNOT create an object from a module.*
# * Syntax
module Speak
end
# VOCAB - Mixin: When a module is mixed in with a class using the 'include' method invocation. Once mixed in, the behaviors declared in that module are available to the class & it's objects.
# EXAMPLE #
# 'include Speak' in 'GoodDog' & 'HumanBeing' classes, instances from both classes now respond to methods within the 'Speak' module (i.e. .speak, .whisper)

# OBJECTS
# - created from classes
# - classes are molds & OBJS the things produced from those molds
# - Individual OBJS contain diff. info from other OBJS but they're instances of the same class

# CLASSES
# - defines it's objects attributes & behaviors
# * Syntax
class GoodDog # <- CamelCase
  # filename (snake_case) -> good_dog.rb
end
sparky = GoodDog.new # .new returns an object
# 'sparky' is an "obj / instance of class 'GoodDog'" == "we instantiated an obj called 'sparky' from the class 'GoodDog'"

# VOCAB - Instantiation: the entire workflow of creating a new obj / instance from a class

# METHOD LOOKUP
# Ruby has a distinct lookup path each time a method is called
# we can use #ancestors to see the method lookup chain