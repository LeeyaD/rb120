Around 20q 3hrs (180min)
last question may take 30min.
19q in 150min is 7.8min each
#### Additional Tips
This assessment has a different style than the RB109 written assessment,so you should expect several open-ended questions where you will need to explain certain OOP concepts using code examples.

While working through the assessment questions it is useful to run your code often to check it, so make sure to have either ruby document/terminal or an online repl prepared beforehand.

### WHAT IS OOP?
A Programming model where areas of code that perform certain procedures are sectioned off, allowing programs to become an interaction of many small parts that can be changed/manipulated without affecting the entire program.

#### Benefits
* By sectioning off code into smaller parts we reduce dependencies and make debugging & maintaining the codebase easier.
* Defining basic classes and leveraging concepts like inheritance to introduce more detailed behaviors means our code is more "DRY" and has a greater level of reusability and flexibility.
* Naming those small parts (i.e. classes & objects) after real-world nouns and modeling them appropriate to the problem, lets programmers think at a higher level of abstraction when designing and helps them break down and solve problems that arise.

### CLASSES AND OBJECTS
Classes define our object's attributes & behaviors like templates through the varied use of instance & class variables and instance & class methods. Objects are created from classes and contain a combination of data and methods.

Here, our class `Dog` is defined with one attribute (a name) and one behavior (a method that gives us access to our attribute). We create a new `Dog` object by calling `#new` on class `Dog`. We pass #new an argument that will be passed to #initialize where it will be assigned the instance variable `@name`.

```ruby
class Dog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

dog1 = Dog.new('Duke')
p dog1.name
```

### INSTANCE VARIABLES vs. CLASS VARIABLES
Instance variables have `@` appended to the front of the variable name. They store the state of an object, are scoped at the object-level and are only accessible via an instance method. They have to be initialized in order to be referenced, so if they're initialized in a method, that method must be called first. If this doesn't happen, the initialization doesn't occur and when referenced the instance variable will return nil.

```ruby #instance variable
module Capable
  def recharge_energy
    @energy = true
  end
end

class Human
  include Capable

  def exercise
    "I can exercise!" if @energy
  end
end

leeya = Human.new
p leeya.exercise
```

Class variables have `@@` appended to the front of the variable name. They store the state of the class, are scoped at the class-level and can be accessed by both instance & class methods. 

```ruby #class variable
class Human
  @@number_of_humans = 0

  def initialize
    @@number_of_humans += 1
  end

  def self.number_of_humans
    @@number_of_humans
  end

  def number_of_humans
    "I'm a human object. There is/are #{@@number_of_humans} of us."
  end
end

leeya = Human.new
p Human.number_of_humans
p leeya.number_of_humans
```

#### HOW TO CALL SETTERS & GETTERS
```ruby
class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

dog1 = Dog.new('Lucky')
p dog1.name
```
We call **setter** methods by name within the class using the keyword self or outside the class by name on an instance of the class.

**within the class**

`self.name = 'Duke'`

**outside the class on our object**

`dog1.name = 'Duke' # using Ruby's syntactic sugar`

We call **getter** methods by name both within the class or outside of the class on an instance of our class.

**within the class**

`name # value of instance variable is returned`

**outside the class on our object**

`dog1.name # value of instance variable is returned`

### USING ATTR_* TO CREATE SETTER & GETTER METHODS
Ruby's has built-in `attr_*` methods that take symbols as arguments and use them to create a getter & setter method and an instance variable of the same name. 

#### Benefit(s)
`attr_*` methods can take multiple arguments at once which saves us a lot of time and lines of code (all those individual getter & setter methods that don't need to be written!)

#### Implementation
* `attr_reader :name`

`#attr_reader` creates a getter method and instance variable using the same name as the argument being passed to it

* `attr_writer :name`

`#attr_writer` creates a setter method and instance variable using the same name as the argument being passed to it

* `attr_accessor :name` 

`#attr_accessor` creates a getter method, a setter method and an instance variable using the same name as the argument being passed to it

### INSTANCE METHODS vs. CLASS METHODS
An instance method is an instance-level method defined within our class that's available to all objects instantiated from the same class. It has access to instance and class variables and serves as a way for us to expose information about the state of our object and class.

A class method is a class-level method defined within our class. It has access to class variables only and serves as a way for us to expose information about the state of our class. It's called directly on the class itself whether an object has been instantiated or not.

**The difference between the two in syntax is that we define a class method with either the class name or the keyword 'self' affixed to the front of the method name.**

#### Implementation
```ruby
class Human
  attr_reader :name

  @@number_of_humans = 0

  def initialize(name)
    @name = name
    @@number_of_humans += 1
  end

  def self.what_am_i?
    "I am a class method."
  end

  def what_am_i?
    "I am an instance method."
  end

  def self.number_of_humans
    @@number_of_humans
  end

  def number_of_humans
    "I am a human object. There is/are #{@@number_of_humans} of us."
  end
end

p Human.what_am_i? # shows we can call a class method even if no obj has been init
leeya = Human.new('Leeya')
p leeya.what_am_i?
p Human.number_of_humans # calling a class method
p leeya.number_of_humans # demos how instance methods have access to @@vars too
```

### METHOD ACCESS CONTROL
Access control means restricting access to things, in this case methods hence the name "**Method** Access Control". In Ruby, we apply this concept to our methods thru the use of *access modifiers*, which are keywords **public**, **protected**, and **private**. If a method is defined under **private** it becomes a private method, **protected** a protected method and **public** a public method though any method not defined under any of these keywords is automatically made public.

A public method can be accessed (i.e. called) both inside and outside the class.

A private method can only be called within the class on ourselves (i.e the calling object).

A protected method like a private method can only be called within the class but it can be called not only on the calling object but other objects of the same class. We use this modifier when we want to share data between class instances.

#### Benefit(s)
* Access modifiers give us the power to control the level of accessibility to our methods, allowing us to hide or expose functionality only to the parts that need it. In that way it's a form of data protection.

#### Implementation
```ruby
class Student
  attr_reader :name, :volunteer

  def initialize(name, grade, volunteer=false)
    @name = name
    @grade = grade
    @volunteer = volunteer
  end

  def >(other_student)
    if grade > other_student.grade
      "#{name}'s grade is higher."
    else
      "#{other_student.name}'s grade is higher."
    end
  end
  
  def grade
    volunteer ? @grade + 3 : @grade
    # calculate_grade
  end

  # private
  
  # def calculate_grade
  #   volunteer ? @grade + 3 : @grade
  # end
end

leeya = Student.new('Leeya', 90)
andrew = Student.new('Andrew', 90, true)
rich = Student.new('Rich', 95)

p leeya.grade
p andrew.grade
p rich.grade
# p leeya.calculate_grade # will error out, trying to access private method
p leeya > andrew
p andrew > rich
```
Here, our `#grade` method is public and can be called from outside the class. The implementation details of the method though are within the private method `#calculate_grade` which cannot be accesed from outside the method but can be called within the method on the calling object.
If we don't want our student's grades accessible from outside the the class and only want to access them when comparing grades amongst other students (i.e. other objects of the same class) we can make `#grade` a protected method.

### Concept
Definition

#### Benefit(s)
* 
#### Implementation

#### REFERENCING & SETTING @VARS vs. USING GETTERS & SETTERS
We can reference and set instance variables in one of two ways. 

* Directly using the instance variable
```ruby
class Person
  def new_address(location) #setting
    @location = location
  end

  # referencing
  def display_name
    @name
  end

  def say_hello
    puts "Hello, I'm #{@name}."
  end
end

```
* Using a getter and/or setter method
```ruby
class Person
  def new_address(location) #setting
    self.location = location
  end

  # referencing
  def display_name
    name
  end

  def say_hello
    puts "Hello, I'm #{name}."
  end
end
```
#### Benefit(s)
It's better to use getter & setter methods rather than doing so directly with the instance variables.

* Let's say we want to alter how the `name` of an object of the `Person` class is displayed. Maybe instead of 'Leeya Davis' we want 'Davis, Leeya'. 

If we referenced the instance variable directly, we'll have to add this new code to every single method that exposes this data. This means a lot of duplicate code and the chances of missing a method or two are high. 

However, if we're referencing with a getter method we only need to add the necessary code in one place. This allows are code to remain clean and DRY.

* Likewise for our setter method adding and/or changing data stored in our object is 


# For example, in this code #acct_number is our custom getter method and we see that whenever we expose the account number (i.e. call this method) we only want the last 4 digits visible. We can still achieve this when referencing the @var directly, but we'll need to sprinkle `"XXXX" + @acct_number.to_s[-4..-1]` wherever we're referencing @acct_number directly. Now, let's say we change our minds and now only want the last 2 digits exposed. If we're referencing the @var directly, we'll have to comb through our code to change every reference whereas by using our getter method, we only need to make the necessary changes to one method.
# The same goes for setting an @var, even if we choose not to format the data we want to save as state in our object. If we decide later on that we want to manipulate the incoming data before storing it, rather than comb through our code to change each instance of setting the var we can go to one place.


# - CLASS INHERITANCE
# -->> When one class inherits behaviors from another class. The class inheriting the behavior is called the subclass, the one providing the behavior is the superclass. A subclass can only have one superclass but a superclass can have many subclasses. This kind of domain model based on hierarchy allows us to extract common behavior to the superclass to be reused by subclasses while leaving subclasses to define and implement fine-grained, detailed behavior.
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
# -->> When objects of different types respond to the same method invocation in different ways. 2 main ways this is implemented is:
# 1. Polymorphism thru inheritance
class Mammal
  def jump
  end
end 

class HumanBeing < Mammal
  def jump 
    "I'm jumping with my two legs!"
  end
end

class Gazelle < Mammal
  def jump
    "I'm jumping with my four legs!"
  end
end

mammals = [HumanBeing.new, Gazelle.new]
mammals.each { |mammal| p mammal.jump}

class Animal
  def eat; end
  def move
    "I'm "
  end
end

class Dog < Animal
  def move
    super + "running!"
  end
end

class Turtle < Animal
  def move
    super + "crawling..."
  end
end

dog = Dog.new
turtle = Turtle.new
p dog.move
p turtle.move
# Here our two different objects 'dog' and 'turtle' respond to the same method call #move by overriding the method inherited from the superclass Animal

# The 2nd way to implement Polymorphism is through duck-typing
class Dog
  def move
    "I'm running!"
  end
end

class Turtle
  def move
    "I'm crawling..."
  end
end

class Dolphin
  def move
    "I'm swimming"
  end
end

[Dog.new, Turtle.new, Dolphin.new].each { |animal| p animal.move }
# Here, the duck-typing occurs on 
# - MODULES
# -->> 

# - METHOD LOOKUP PATH
# -->> The order in which classes are inspected when a method is called. When a method is called Ruby will first look for it's definition in the current class, then proceed further up the lookup path until it finds a method of the same name. To see this in action we use the class method #ancestors which returns an array of class names in the lookup path based on the order they're checked.
```ruby
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
p Digital.ancestors
```
# Here we see for a method called on an instance of the PaperBack class, Ruby would look for it in the following order until it is found PaperBack > Books > Object > Kernel > BasicObject
# Otherwise, a NoMethodError is raised. 
# Digital > Downloadable > Lendable > Books > Object > Kernel > BasicObject
# Here Ruby first checks the class, then any mixed in modules from the last one mixed in to the first (bottom - up)

module Foo1
end

module Foo2
end

module Bar
include Foo1
  
  class Fooey
    include Foo2
  end
end

p Bar::Fooey.ancestors
# (X) Fooey > Foo2 > Bar > Foo1 > Object > Kernel > BasicObject
# (O) Bar::Fooey > Foo2 > Object > Kernel > BasicObject
# class Fooey doesn't inherit from a module, it's just stored in it

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
For example, let's take the following piece of code.
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


# CAROLINA'S NOTES ---------------------------------------
### Class inheritance

**Class inheritance** occurs when a class (subclass) inherits behavior/s from another class (superclass). The `<` symbol is used to signify inheritance. Class inheritance is used as a way to extract common behaviors among classes and move it to a superclass in order to have logic stored in one place; it removes duplication and creates "DRY" (Don't Repeat Yourself) code. It is a way to create subclasses from a superclass already defined; this makes it easier to create and maintain a program. Class inheritance provides the opportunity to reuse code for functionality and a faster implementation time.

*A class can only inherit from one superclass.* It is optimal to choose class inheritance if there is an 'is-a' relationship among classes and to model hierarchical domains. 

```ruby
class Dancer
  attr_reader :name, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def display_dancer
    "My name is #{name} and I am a #{type} dancer."
  end
end

class BalletDancer < Dancer ; end

class BallroomDancer < Dancer ; end

cassie = BalletDancer.new("Cassie", "Contemporary")  

carolina = BallroomDancer.new("Carolina", "Latin")   

p cassie.display_dancer														   # => "My name is Cassie and I am a Contemporary dancer."
p carolina.display_dancer														 # => "My name is Carolina and I am a Latin dancer."
```
The example above shows how class inheritance is used to store logic in one place, removing duplication while reusing code. 

Both the `BalletDancer` and `BallroomDancer` class inherit from the `Dancer` super-class on `line 225` and `line 227`. All the information necessary to get the desired output from `lines 233-234` is stored in the `Dancer` superclass. Subclasses inherit all the methods and modules from its superclass; so when the `cassie` object is instantiated from the `BalletDancer` class, the `::new` class method accepts two arguments and sends it to the `initialize` method in the `Dancer` superclass. Ruby looks for an `initialize` method in the `BalletDancer` class and when it cannot find it, it looks in the `Dancer` superclass and finds it. When `line 233` is executed, the string "My name is Cassie and I am a Contemporary dancer" is output to the screen because of the `p` inspect method. The `display_dancer` instance method is accessible by the instance from the `BalletDance` class, `cassie`, because it inherits all the *methods* from the `Dancer` class. 
_____

### Encapsulation
* We can encapsulate state in objects and behavior (behavior via mehtod access control by the use of private and protected methods.)

**Encapsulation** is a form of data protection where data cannot be changed or manipulated without intention. Encapsulation hides pieces of functionality that makes it unavailable to the rest of the code base; defining boundaries in an application and allowing code to acheive new levels of complexity. Encapsulation allows the internal representation of an object to be hidden from the outside and will only be *exposed* to methods and properties that users of the object need by using *method access control* through the public interface of a class (it's public methods).

```ruby
class HumanBeing
  def initialize(name)
    @name = name
  end

  def greeting
    "Hi, my name is #{self.name.capitalize}"
  end

  private

  attr_accessor :name
end

carolina = HumanBeing.new("Carolina")
p carolina.greeting
```

In this example, the object, or instance, `carolina` is instantiated from the class `HumanBeing` with the string `"Carolina"` passed in as an argument to the `#new` method that gets passed to the `initialize` instance method.
Both `name` getter and setter methods created by the `attr_accessor` are private and any object intantiated from the `HumanBeing` class cannot access the `name` getter method, or change the `name` setter method. But, the objects instance variable `@name` can be retrieved by using the getter method in the `greeting` method within the class definition.  

This example shows encapsulation, the access modifier `private` hides the getter and setter methods for `@name` instance variables of each object intantiated from the `HumanBeing` class and only exposes the return value of the getter method `name` through the `greeting` instance method.
_____


### Polymorphism

**Polymorphism**, which literally means many (poly) forms (morph), is the ability for different types of data to respond to a common interface. For example, objects of different types responding in different ways to the *same* method invocation. 

Polymorphism can be acheived through *class inheritance* if there is a class hierarchical interface where objects instantiated from a superclass and its subclasses can respond to the same method name. The response to the same method name can either come from using inheritance to acquire the behavior of a superclass or the method name is overridden (changing the implementation). Regardless of dramatically different implementation, if all the objects respond to the same method name, albeit inherited or overridden, that is polymorphism through inheritance in action. 

Polymorphism can also be acheived through *ducktyping*. *Duck typing* is when objects of different and *unrelated* types respond to the same method name. To acheive polymorphism through ducktyping, the class or the object type is irrelevent. The objects involved must respond to the same method name with the same number of arguments. The idea behind *ducktyping* is "If an object quacks like a duck, then we can treat it as a duck". In other words, the objects involved have the same method name, it does not matter what type of objects they are or from what class they are instantiated from; as long as they respond to the same method name with the same number of arguments they are treated all the same. The same method is calle on all the object and that is polymorphism through ducktyping in action. 
_____
POLYMORPHISM THROUGH INHERITANCE
```ruby
class Mammal
  def jump
  end
end 

class HumanBeing < Mammal
  def jump 
    "I'm jumping with my two legs!"
  end
end

class Gazelle < Mammal
  def jump
    "I'm jumping with my four legs!"
  end
end

class Sloth < Mammal; end         # Sloths cannot jump.
class Elephant < Mammal; end      # Elephants cannot jump.

mammals = [HumanBeing.new, Gazelle.new, Sloth.new, Elephant.new]
mammals.each { |mammal| p mammal.jump}
```

In the example above, the `HumanBeing`, `Gazelle`, `Sloth`, and `Elephant` classes all inherit from the superclass `Mammal`. They all have access to the `jump` instance method. Polymorphism through class inheritance occurs on `line 299`, where the `each` method is called on the array object referenced by `mammals`. The `mammals` local variable is initialized and assigned to an array that contains an instance of the `HumanBeing`, `Gazelle`, `Sloth`, and `Elephant` class on `line 298`. The `jump` instance method is called on each of these instances, and the fact that they can all respond to the same method call whether it's through class inheritance or method overriding, is polymorphism through class inheritance in action.

The return value of `line 198 is `:
"I'm jumping with my two legs!"
"I'm jumping with my four legs!"
nil
nil

The `p` inspect method is called on each instance at each iteration from `line 298` which will output and return the return value of the `jump`instance method called each instance. The last two return values are `nil` because the programmer chose to leave the `jump` instance method empty in the `Mammal` class because elephants and sloths cannot jump.  
_____
POLYMORPHISM THROUGH DUCKTYPING
```ruby
class Gun
  def shoot
    "Bang!"
  end
end

class BasketBallPlayer
  def shoot
    "Swish! Nothing but net."
  end
end

class Camera
  def shoot
    "Click!"
  end
end

[Gun.new, BasketBallPlayer.new, Camera.new].each { |noun| p noun.shoot}

```
Polymorphism through ducktyping occurs on `line 19` where the each method is called on an array containing an instance of the `Gun` class, `BasketBallPlayer` class, and the `Camera` class. All three *unrelated* classes respond to the same *generic* method call `shoot` when `shoot` is called on each instance and passed to the `p` method as an argument. The inspect `p` method outputs and returns a string representation of the `shoot` methods return value:

=> "Bang!"
=> "Swish! Nothing but net."
=> "Click!" 

Although the `Gun`, `BasketBallPlayer`, and `Camera` classes are unrelated, they each contain a `shoot` instance method, and all instances from any of these classes can respond to the  `shoot` method call. So when `line 19` is executed, each instance responds to the same `shoot` *generic* method, regardless of what class each object is instantiated from; that is polymorphism through ducktyping in action.
_____

### Modules

# Modules are used to group *reusable* code in one place; they are used for *interface inheritance*, *namespacing*, and to store *module methods*.

Modules are Ruby's solution for multiple inheritance; in Ruby, a class can only sub-class from one super class. But a class can have as many mixin modules as the programmer chooses. When modules are mixed in to a class via the `include` method invocation followed by the module name, that is called *interface inheritance*. Interface inheritance is best to choose if there's an "has-a" relationship. Interface inheritance creates a flexible and DRY (Don't Repeat Yourself) code design.

Modules are also used for *namespacing* which is when classes are organized and grouped under a module. *Namespacing* makes it easy to recognize related classes and reduces the chance of classes colliding with other similarly named classes in a code base. It's important to note that objects cannot be instantiated directly from a module; but objects can be instantiated from a class within a module in the following format : 

`SomeModule::SomeClass.new`

In the example code snippet above, the module name is followed by `::` a name space resolution operator, followed by the class name and the class method `::new`. 

Modules can also be used to house methods, *module methods*, and are created for methods that may seem out of place within code. To define a module method, prepend `self` to the method name definition within a module.

To define a module, replace the `def` keyword used to define methods with the keyword `module` followed by the module and and the keyword `end` to finish the module.
_____
INTERFACE INHERITANCE
```ruby
module Jumpable
  def jump
    "I'm jumping!"
  end
end 

class Mammal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class HumanBeing < Mammal
  include Jumpable
end

class Elephant < Mammal
end

class Cat < Mammal
  include Jumpable
end

class Sloth < Mammal
end

carolina = HumanBeing.new("Carolina")
kitty = HumanBeing.new("Kitty")
lazybones = Sloth.new("Lazy Bones")

p carolina.jump    # I'm jumping!
p kitty.jump       # I'm jumping!
p lazybones.jump   # undefined method `jump' for #<Sloth:0x00007fe9ba00d060 @name="Lazy Bones"> (NoMethodError)
```
Subclasses `HumanBeing`, `Elephant`, `Cat`, and `Sloth` all inherit from Fclass `Mammal`. Yet not all of these mammals can jump, only human beings and cats can jump from this list. To give these classes the ability to jump, the `Jumpable` module is created on `lines 1-5` with the instance method `jump` which will return the string "I'm jumping!" when called. The `Jumpable` module is made available to the `HumanBeing` class and `Cat` class using the `include` method invocation on `line 16` and `line 23`. When the `jump` instance method is called on the object `carolina` instantiated from the `HumanBeing` class on `line 29`, the string "I'm Jumping!" will be returned because `carolina` has access to the `Jumpable` module which can access the `jump` instance method. The same happens on `line 34` with the `kitty` object instantiated from the `Cat` class that can access the `Jumpable` module and has access to the `jump` instance method. Yet when `line 31` is executed, Ruby throws a `NoMethodError`; this is because the `Sloth` class does not have access to the `Jumpable` module. When ruby tries to look for the `jump` instance method, it is not in scope and does not exist. 

This example shows how modules are mixed in to classes via the `include` method invocation and how those classes have access to instance methods from within the modules mixed in.
_____
NAMESPACING
```ruby
module Dancer
  class BallroomDancer
    def dance(category)
      p "I'm dancing the #{category}!"
    end
  end

  class BreakDancer
    def spin(body_part)
      p "I'm spinning on my #{body_part}!"
    end
  end
end

carolina = Dancer::BallroomDancer.new
mark = Dancer::BreakDancer.new
carolina.dance("Jive") # "I'm dancing the Jive!"
mark.spin("head") # I'm spinning on my head!
```
In this example a module is used to organize classes into types of dancers. Within the `Dancer` module exists two classes, `BallroomDancer` and `BreakDancer`. In order for the object called `carolina` to be instantiated from the `BallroomDancer` class, the namespace resolution operator (`::`) is used on `line 15` after the `Dancer` module name followed by the `BallroomDancer`class and appending the class method `.new` (example: `Dancer::BallroomDancer.new`).
_____
MODULE METHODS
```ruby
module Dancer
  class BallroomDancer
    def dance(category)
      p "I'm dancing the #{category}!"
    end
  end

  class BreakDancer
    def spin(body_part)
      p "I'm spinning on my #{body_part}!"
    end
  end

  def self.out_of_place_method(n)
    n * 2
  end
end

doubled = Dancer.out_of_place_method(7)
```
Modules can be used to store methods that are out of place, for example the module method `out_of_place_method` defined on `lines 14-16`. This module method accepts an integer as a parameter and will multiply that integer by two. On `line 19` the `doubled` local variable is assigned to the return value of passing the integer 7 as an argument to the `out_of_place` module method from the `Dancer` module. `Line 19` can also be written as `doubled = Dancer::out_of_pace_method(7)`. 
_____
### Class Inheritance vs Interface Inheritance

A class can only subclass from one class and is best to choose if theres an "is-a" relationship. Class inheritance is also a great option if used to model herarchical domains. A class can have as many mixin modules as the programmer wants and is best to choose of there is a "has-a" relationship. Objects *cannot* be instantiated from modules. Aside from interface inheritance, modules can also be used for namespacing and grouping common methods together. 
_____
### Method lookup path

The `#ancestors` class method can be used on any class to find it's method lookup path and an array will be returned containing the names of the classes in the look up path based in the order they are checked. It is important in which order modules are included first in a class because Ruby will look at the last module included *first*. If the modules mixed in to a class have methods of the same name, the last module in the class will be looked at first by Ruby. Subclasses have access to modules and their methods that are included in the super-class. ALl classes come with three build-in ancestor classes; `Object`, `Kernel`, `BasicObject`.  
_____

### `self`

Using **`self`** is a way of being *explicit* about what a program is *referencing* and the intent as far as behavior. To understand what `self` is referencing, it is important to notice what *scope* it is used in. 

When `self` is used within the class body and *outside* of an instance method, `self` refers to the class itself and it is used to define class methods. 

When `self` is used *within* an instance method, `self` is referencing the *calling object* in order for Ruby to disambiguate between a local variable being initialized or a setter method being called. `self` is used when calling setter methods from within a class. 

```ruby
class HumanBeing
  attr_accessor :name, :age, :motto
  
  def initialize(name, age, motto)
    @name = name
    @age = age
    @motto = motto
  end

  def change_info(name, age, motto)
    self.name = name
    self.age = age
    self.motto = motto
  end

  def what_is_self
    self
  end

  def self.this_is_a_class_method
    self
  end

  self
end

carolina = HumanBeing.new("Carolina", 32, "You snooze, you looze.")
p carolina.what_is_self
p HumanBeing.this_is_a_class_method
```
The example above shows what `self` references depending on what scope it is used in. 

The `self` used in the `change_info` instance method on `lines 11-13` is referring to the setter method created by the `attr_accessor` on `line 2` for instance variables `@name`, `@age`, and `@motto`. The use of `self` before calling the setter methods is to let Ruby know that a setter method is being invoked, without it, Ruby will initialize *local variables* `name`, `age`, and `motto` and the code won't run as the programmer intended. 

Whenever `self` is used within an *instance method*, `self` refers to the *calling object*. This can be seen on `line 28` where the `what_is_self` method is called on the object named `carolina` and passed to the `p` method as an argument. This code will output an encoding of the `carolina` object id as well as its instance variables with its values. This is because when `what_is_self` is defined on `lines 16-18`, `self` is used within the method alone, and because `self` is used within an instance method, `self` refers to the *calling object*.

When the entire code is executed, the first output is the string 'HumanBeing'. This is because of the code `puts self` on `line 24`. When self is used within a class definition, *outside of an instance method*, `self` refers to the class itself. In this case `puts self` will output a string representation of the class itself, "HumanBeing". 

The `self` prepended to the `this_is_a_class_method` method definition on `line 20` indicates that a class method is being defined. The `self` within the `this_is_a_class_method` refers to the class itself and will output the string "HumanBeing" when `line 29` is executed. Notice that on `line 29` the class method is `this_is_a_class_method` is called on the class itself `HumanBeing` and passed as an argument to the `p` method which is why the string 'HumanBeing' is output and returned. 

### Fake Operators

**Fake operators** are methods disguised as operators; Ruby provides a liberal syntax that reads more naturally and gives *synctactical sugar* in the way these methods are invoked making them look like operators. 

For example, the most overriden fake operator is the `==` equivalence operator. The equivalence operator is commonly used as : `object1 == object 2`. It looks like an operator but `==` is actually a method and can be coded like : `object.==(object2)`. 

Fake operators can be defined in classes to change their default behavior. Doing so may make it difficult to decipher what a fake operator is actually doing making Ruby powerful yet potentially dangerous. 
 
When implementing a fake operator, it is important to choose functionality that makes sense by following the general usage and convention from the Ruby standard library. For example, when overriding the `#+` method in a class, the method should follow the Ruby standard library use for the method and it should be used to increment or concatenate values. 

Overriding fake operator methods gives the programmer flexibility to specify what data is to be manipulate.
_____

### Equivalence

The `==` method is an instance method from the `BasicObject` class that is used to compare the *values* of objects and is available to all classes in Ruby. Each class should define its own `==` method in order to *specify* what values to compare; defining `==` in a class automatically gives the programmer the `!=` method for use. 
_____

The `equal?` method is used to compare objects to check if they point to the *same*object or space in memory. 
_____

The `===` method is an instance method from the `Object` class and is available to all classes in Ruby. The `===` method checks to see if an object belongs to what it is being compared to. For example, in the code:

`(0..35) == 25`

Ruby is checking if the integer 25 is between the range of 0 to 34; it will return `true`.  

The `===` method is used *implicitly* by the `case` statement. For example, when there are ranges in a `when` clause, the `===` method is comparing each `when` clause withthe integer that is being looks for by the case statement. 
_____

The `eql?` method determines if two objects contain the same value and if they belong to the same class. The `eql?` method is often used by `Hash` to determine the equality among its members.
_____

### Truthiness

The ability to express what is 'true' or 'false' is captured in a *boolean* data type; a boolean is an object that soley conveys whether an object is 'true' or 'false'. They are represented by `true` and `false` objects, these objects have classes behind them and methods can be called on `true` and `false`. Booleans help build conditional logic and helps the programmer understand the state of an object or expression. 
 
When using a conditional, the `true` and `false` objects are not directly used. Instead conditional logic evaluates an expression or method call. Since everything in Ruby is *truthy* or *evaluates to* true *except* for `false` and `nil`, truthiness is easily evaluated in a conditional without the direct use of booleans. It is important to note that `false` and `nil` are not the same objects and are not equal. 

Logical operators are also used to return a boolean when evaluating two expressions; logical operators : `&&`, `||`. These logical operators exhibit a behavior called *short curcuiting*, they will stop evaluating an expression as soon as it can guarantee a return value. 

Truthiness is a concept in Ruby that *considers everything to be truthy other than `false` and `nil`*. Any expression used in a conditional, with or without logical operators, will be considered `true` as long as the expression does not evaluate to `false` or `nil`. The notion that Ruby considers everything to evaluate to true but a *truthy* expression is not the same as the `true` object is what is meant by *truthiness*. 
_____

### Collaborator Objects

A **collaborator object** is an object that is assigned to an instance variable in another object; collaborator objects are stored as a state within another object. They work together, in collaboration, with the class they are associated with. Collaborator objects can be strings, integers, arrays, or hashes but they are typically *custom objects*; custom objects are objects that are not inherited from the Ruby core library. Collaborator objects are at the core of OO design because they represent the connections between various actors in a program and play an important role in modeling complicated problem domains.

```ruby
class BallroomTeacher
  attr_reader :students

  dInitializeef initialize(name)
    @name = name
    @students = []
  end
end

class DanceStudent
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

carolina = BallroomTeacher.new("Carolina")
mel = DanceStudent.new("Mel")
james = DanceStudent.new("James")
chris = DanceStudent.new("Chris")

carolina.students << mel << james << chris

carolina.students.each { |student| p student.name }
```

On `line 17`, the object `carolina` is instantiated from the `BallroomTeacher` class and the string "Carolina" is passed as an argument to the `initialize` instance method via the `::new` class method. The string "Carolina" is assigned to the `@name` instance variable within the `initialize` method. Each time an object is instantiated from the `BallroomTeacher` class, an empty array is assigned to the `@students`instance variable. 

On `lines 18-20`, the objects `mel`, `james`, and `chris` are instantiated from the `DanceStudent` class.

Collaboration occurs on `line 22` where the `students` instance method is called on `carolina` and the objects `mel`, `james`, and `chris` are added to the empty array `@students` is referencing via the `<<` method. The objects `mel`, `james`, and `chris` are *collaborator objects* because they are assigned to an instance variable in another object (`carolina.students`). 

`Line 24` outputs a string referenced by each objects `@name` instance variable via the `name` getter method created by the `attr_reader` on `line 11` for each student. 
_____
# Classes and Objects
# Inheritance
  # Class Inheritance
  # Interface Inheritance
  # Super
  # Object Methods
  # Variable Scope with Inheritance
# Polymorphism & Encapsulation
  # Polymorphism
    # Polymorphism Through Inheritance
    # Polymorphism Through Duck Typing
  # Encapsulation
# Modules
  # Mixin Modules
  # Namespacing
  # Module Methods
# Self
  # Inside Instance Methods
  # Inside Class Methods
  # Inside Class Definitions
  # Inside Mixin Modules
  # Outside Any Class
# Fake Operators and Equality
  # Equivalence
    # ==
    # equal? and object_id
    # ===
    # eql?
  # Fake Operators
    # Comparison Methods
    # Right and Left Shift
    # Plus
    # Element Setters and Getters
# Collaborator Objects