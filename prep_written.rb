# Specific Topics of Interest
# - Classes and objects
# -->>
# - Use attr_* to create setter and getter methods
# -->> 
# - How to call setters and getters
# -->> 
# - Instance methods vs. class methods
# -->>
# - Method Access Control
# -->> 
# - Referencing & setting instance variables vs. using getters & setters
# -->> 
# - CLASS INHERITANCE
# -->>
# - ENCAPSULATION
# -->> 
# - POLYMORPHISM
# -->> 
# - MODULES
# -->> 
# - METHOD LOOKUP PATH
# -->> 
# - self
# --> Calling methods with self
# -->>>
# --> More about self
# -->>>
# - FAKE OPERATORS AND EQUALITY
# --> Ruby has what we call syntactic sugar which allows us to invoke methods using syntax that is easier to read and makes these methods seem like Ruby operators, but since they're not. They're fake operators. 
# For example, the inclusive range, .., is an operator and looks like this when used
5..10
# On the other hand when we use plus, +, 

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

# - Working with collaborator objects
# -->> 

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

# When writing answers to test questions, make sure you're as precise as possible, and that you use the proper vocabulary. Doing this helps you debug and understand more complex code later in your journey. If your definitions are imprecise, you can't use them to decompose a complicated method or program. Also, you may be unable to pass the test.

# Additional Tips
# This assessment has a different style than the RB109 written assessment,so you should expect several open-ended questions where you will need to explain certain OOP concepts using code examples.

# While working through the assessment questions it is useful to run your code often to check it, so make sure to have either ruby document/terminal or an online repl prepared beforehand.
