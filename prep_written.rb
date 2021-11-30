# Around 20q 3hrs (180min)
# last question may take 30min.
# 19q in 150min is 7.8min each

# Specific Topics of Interest
# - CLASSES AND OBJECTS
# -->> They're like molds or templates for our objects, They define our object's state & behaviors. Objects are created from classes and contain a combination of data and methods.
# Here, the #initialize method creates a new Dog object by assigning the instance variable @name to the dog's name specified by the argument.
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end
end

dog1 = Dog.new('Bob')
p dog1.name
dog1.name = 'Duke'
p dog1.name

# - USING ATTR_* TO CREATE SETTER & GETTER METHODS
# -->> Rather than write out our setter & getter methods e can use Ruby's syntactic sugar 'attr_*' to create them for us.
attr_reader :name # this 1 line of code is actually the method #attr_reader being called and it creates a getter method and instance variable of the same name as the argument being passed to it
def name
  @name
end
attr_writer :name # this is the method #attr_writer being called and it creates a setter method and instance variable of the same name as the argument being passed to it
def name=(name)
  @name = name
end
attr_accessor :name # the #attr_accessor method creates a getter method, a setter method and an instance variable of the same name as the argument being passed to it

# - HOW TO CALL SETTERS & GETTERS
def name=(n)
  @name = n
end
# -->> This is a setter method, we call it on class instances using Ruby's syntactic sugar, like so:
dog1.name = 'Duke' #this way is more readable but we can also call it without using Ruby's syntactic sugar, like:
dog1.name=('Duke') #parenthesis are optional
# ------
def name
  @name
end
# -->> This is a getter method, we call by name it on instances of classes too

# - INSTANCE METHODS vs. CLASS METHODS
# Both methods are defined in our class definition.
# -->> An instance method is an instance-level method. It has access to instance variables and serves as a way for us to expose information about the state of our object. It's called on instantiated objects of the class.
# -->> A class method is a class-level method. It has access to class variables and serves as a way for us to expose information about the state of our class. It's called directly on the class itself whether an object has been instantiated or not.
# The difference between the two in syntax is that we define a class method with either the class name or the keyword 'self' affixed to the front of the method name, like so:
class Human
  def self.what_am_i?
    "I am a class method."
  end

  def speak
    "I am an instance method."
  end
end
p Human.what_am_i?
leeya = Human.new
p leeya.speak

def Human.what_class_am_i?; end # or
def self.what_class_am_i?; end

# - METHOD ACCESS CONTROL
# -->> Access control is simply restricting access to things. In Ruby, we apply this concept to our methods thru the use of access modifiers. We can decide if we want certain methods to be public, protected, or private by defining them under access modifiers, keywords 'protected' or 'private' (methods not defined under either keywords are automatically public)

# - PUBLIC, PROTECTED, and PRIVATE methods 
# -->> 

# - REFERENCING & SETTING @VARS vs. USING GETTERS & SETTERS
# -->> It's better to use getter & setter methods when referencing and setting instance variables rather than doing so directly. 
class BankAccount
  attr_reader :name, :acct_number

  def initialize(name)
    @name = name
    @acct_number = set_acct_number
  end

  def set_acct_number
    # generates a unique 8-digit account #
    12345678
  end

  def acct_number
    "XXXX" + @acct_number.to_s[-4..-1]
  end
end
# For example, in this code #acct_number is our custom getter method and we see that whenever we expose the account number (i.e. call this method) we only want the last 4 digits visible. We can still achieve this when referencing the @var directly, but we'll need to sprinkle `"XXXX" + @acct_number.to_s[-4..-1]` wherever we're referencing @acct_number directly. Now, let's say we change our minds and now only want the last 2 digits exposed. If we're referencing the @var directly, we'll have to comb through our code to change every reference whereas by using our getter method, we only need to make the necessary changes to one method.
# The same goes for setting an @var, even if we choose not to format the data we want to save as state in our object. If we decide later on that we want to manipulate the incoming data before storing it, rather than comb through our code to change each instance of setting the var we can go to one place.


# - CLASS INHERITANCE
# -->> When one class known as the subclass, inherits behaviors from another class, known as the superclass. A subclass can only have one superclass but a superclass can have many subclasses. This kind of domain model based on hierarchy allows us to extract common behavior to the superclass to be reused by subclasses while leaving subclasses to define and implement fine-grained, detailed behavior.
class Animal
  def eat; end
  def move; end
end

class Dog < Animal
  def fetch; end
  def jump; end
end

class Turle < Animal
end

# - ENCAPSULATION
# -->> A form of data protection that let's us make certain data/functionality of an object unavailable to access and/or change from the outside without explicit intention. 
# This is done by NOT creating methods that interact with the data we want to hide. For example;
class BankAccount
  attr_reader :name, :acct_number

  def initialize(name)
    @name = name
    @acct_number = set_acct_number
  end

  def set_acct_number
    # generates a unique 8-digit account #
    12345678
  end

  def acct_number
    "XXXX" + @acct_number.to_s[-4..-1]
  end
end
leeya = BankAccount.new('Leeya')
p leeya.name
p leeya.acct_number
# Here by not creating a setter method for our @acct_number we're not allowing this piece of data to be changed or manipulated from the outside.
# Encapsulation can also be implimented through Method Access Control

# - POLYMORPHISM
# -->> 

# - MODULES
# -->> 

# - METHOD LOOKUP PATH
# -->> The order in which classes are inspected when a method is called. When a method is called Ruby will first look for it's definition in the current class, then proceed further up the lookup path until it finds a method of the same name. For example;
module Downloadable
end

module Lendable
end

class Books
end

class PaperBack < Books
end

class Digital < Books
  include Lendable
  include Downloadable
end
p PaperBack.ancestors
# Here we see for a method called on an instance of the PaperBack class, Ruby would look for it in the following order until it is found otherwise, a NoMethodError is raised; PaperBack > Books > Object > Kernel > BasicObject
p Digital.ancestors
# Digital > Downloadable > Lendable > Books > Object > Kernel > BasicObject
# Here Ruby first checks the class, then any mixed in modules from the last one mixed in to the first (bottom - up)

# - SELF
# --> Calling methods with self
# -->>>
# --> More about self
# -->>>

# - FAKE OPERATORS AND EQUALITY
# --> Ruby has syntactic sugar which allows us to invoke methods using syntax that is easier to read and makes these methods seem like Ruby operators, but since they're not really operators, they're fake operators. 
# For example, the inclusive range, .., is an operator and looks like this when used
5..10
# On the other hand, the plus +, looks like an operator because of syntax like this:
5 + 10 # => 15
# But it's really a method that when called without using Ruby's syntactic sugar, looks like this:
5.+(10)
# --> The equality operator, ==, is actually a method defined differently by various built-in Ruby classes (String#==, Array#==, Hash#==) to specify how to compare objects from those classes, for example:
a = "hello"
b = "hello"
p a.object_id
p b.object_id
p a == b
# This method is the String#== and from this code we know that #== doesn't look for the objects being compared to be the exact same object but rather for their values to be the same. 

# - TRUTHINESS
# --- Aside from false and nil, Ruby considers everything to be truthy. For example, 
!!5 
!!'hello'
!![1, 2, 3]
# here we're using the !! operator to convert these obj's truthy values into Booleans but truthy doesn't equal true so
5 == true
'hello' == true
[1, 2, 3] == true
# will all return false

# - WORKING WITH COLLABORATOR OBJECTS
# -->> A collaborator object is an object of any kind stored as state within another object and it's usually common with custom objects. For example:
class Company
  attr_accessor :employees

  def initialize(name)
    @name = name
    @employees = []
  end

end

class Employee
  def initialize(name)
    @name = name
  end
end
company1 = Company.new('Etsy')
leeya = Employee.new('Leeya')

company1.employees << leeya
p company1.employees
# here we have 2 objects being initialized; 'company1' is an instance of the Company class and 'leeya' is an instance of the Employee class. And on the next line we're adding out Employee object 'leeya' to the collection of employees at 'company1' so in this case 'company1' has a collaborator object ('leeya') stored in the 

# Precision of Language
# Some questions require that you explain code or concepts with words. It's important to explain how code works using precise vocabulary and to pinpoint the causal mechanism at work. In other words, use the right words and don't be vague.

# For example, let's take the following piece of code.
class Dog
  def initialize(name)
    @name = name
  end

  def say_hello
    puts "Woof! My name is #{@name}."
  end
end
# If we ask you to describe this code, you may say that "It defines a Dog class with two methods: an initializer and a method that has a message as a result." This description isn't wrong, but it's imprecise and lacks some essential details. An answer like this may receive a score of 5/10 on a 10-point question; 50% is not a passing score.

# A more precise answer says that "This code defines a Dog class with two methods:

# The #initialize method that initializes a new Dog object, which it does by assigning the instance variable @name to the dog's name specified by the argument.
# The #say_hello instance method which prints a message that includes the dog's name in place of #{@name}. #say_hello returns nil."
# In programming, we must always concern ourselves with outputs, return value, and object mutations. We must use the right terms when we speak, and not use vague words like "results." Furthermore, we need to be explicit about even the smallest details.

# Additional Tips
# This assessment has a different style than the RB109 written assessment,so you should expect several open-ended questions where you will need to explain certain OOP concepts using code examples.

# While working through the assessment questions it is useful to run your code often to check it, so make sure to have either ruby document/terminal or an online repl prepared beforehand.
