#### Additional Tips
Written & Interview are a mix of Conceptual & Code-Based Questions

Read through all the questions first, you may end up going into detail

Don't add more abstraction than needed in your explanation (e.g. talking about simple classes & objects don't add an attr_*)

This assessment has a different style than the RB109 written assessment,so you should expect several open-ended questions where you will need to explain certain OOP concepts using code examples.

While working through the assessment questions it is useful to run your code often to check it, so make sure to have either ruby document/terminal or an online repl prepared beforehand.

Precision of Language: In programming, we must always concern ourselves with outputs, return value, and object mutations. We must use the right terms when we speak, and not use vague words like "results." Furthermore, we need to be explicit about even the smallest details.

### WHAT IS OOP? (OOP1)
A Programming model where areas of code that perform certain procedures are sectioned off, allowing programs to become an interaction of many small parts that can be changed/manipulated without affecting the entire program.


#### Benefits
* By sectioning off code into smaller parts we reduce dependencies and make debugging & maintaining the codebase easier.
* Defining basic classes and leveraging concepts like inheritance to introduce more detailed behaviors means our code is more "DRY" and has a greater level of reusability and flexibility.
* Naming those small parts (i.e. classes & objects) after real-world nouns and modeling them appropriate to the problem, lets programmers think at a higher level of abstraction when designing and helps them break down and solve problems that arise.


### CLASSES AND OBJECTS (OOP2)
Classes are like templates, they define our object's attributes & behaviors through the use of instance & class variables and instance & class methods. Objects are created from classes and contain the combination of attributes and behaviors outlined in the class definition.

#### Implementation
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
Here, our class `Dog` is defined with one attribute (a name) and one behavior (a method that exposes that attribute). We created a new `Dog` object by calling `#new` on class `Dog` and passing it a required argument that'll be passed to `#initialize` where it will be assigned to the instance variable `@name`. To sum up, we've instantiated a `Dog` object called `dog1` with one attribute (a name) and one behavior (the ability to tell us it's name.)


### INSTANCE VARIABLES vs. CLASS VARIABLES (OOP3)
Instance variables have `@` appended to the front of the variable name. They store the state of an object, are scoped at the object-level and are only accessible via an instance method. They have to be initialized in order to be referenced. If they're initialized in a method, that method must be called first. If this doesn't happen, the initialization doesn't occur and when referenced the instance variable will return nil.
```ruby #instance variable
module Capable
  def recharge
    @energy = true
  end
end

class Human
  include Capable
  
  attr_reader :energy

  def exercise
    @energy ? "I can exercise!" : "I can't exercise"
  end
end

leeya = Human.new
p leeya.energy
p leeya.exercise
leeya.recharge
p leeya.energy
p leeya.exercise
```
Here, we see an important aspect of instance variables demonstrated. Until we run the `#recharge` method, our instance variable `@energy` isn't initialized and returns `nil`, we see this in the output from `leeya.energy` and `leeya.exercise`. After we call `#recharge` it initializes the instance variable `@energy` to `true`, we see this in the output when we call the previous 2 instant methods again.

Class variables have `@@` appended to the front of the variable name. They store the state of the class, are scoped at the class-level and can be accessed by both instance & class methods. 
```ruby
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
darlene = Human.new
p Human.number_of_humans
p darlene.number_of_humans
```
Here, we see how instance and class methods both have access to class variables. `@@number_of_humans` is initialized to zero in the definition of our `Human` class and every time an object is instantiated, the value of `@@number_of_humans` increases by 1. After we create the object `leeya` from the `Human` class, we call our instance method `#number_of_humans` on it and we call our class method `#number_of_humans` on our `Human` class. Both output the correct number of objects created thus far, showing that both have access to the class variable. We see it again when we instantiate another object from the `Human` class (`darlene`) and run the same methods, the count has increased by 1.


#### HOW TO CALL SETTERS & GETTERS (OOP4)
```ruby
class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name(new_name)
    name = new_name # add & remove `self.` here
  end

  def speak
    "My name is #{name}."
  end
end

dog1 = Dog.new('Lucky')
p dog1.name
dog1.change_name('Duke')
p dog1.name
dog1.name = 'Bo'
p dog1.name
p dog1.speak
```
How we call **setter** methods depends on whether we're calling it inside or outside of the class.

Here when calling our setter method `#name=` **within the class** in `#change_name`, we have to call it with the keyword `self` appended to the front like this `self.name = new_name`. If we don't, Ruby will think we're initializing a local variable instead of calling our setter method and the data won't be changed. We see this when we first run the code without `self.` appended to the front of `name`, `dog1`'s name remains `Lucky`. If we run the code again, this time with `self.` appended, `dog1`'s name changes from `Lucky` to `Duke`.

When calling the setter method `#name=` **outside the class** the syntax when using Ruby's syntactic sugar is `dog1.name = 'Duke'`. Without the added sugar we'd call it like a regular method: `dog1.name=('Duke')`.

Calling the **getter** method `#name` both within & outside of the class, returns the same thing, the value of our instance variable `@name`. We see this demonstrated in the numerous calls to `#name` outside of the class and when we invoke the `#speak` method, its implementation includes our getter method.


### USING ATTR_* TO CREATE SETTER & GETTER METHODS (OOP5)
Ruby has built-in `attr_*` methods that take symbols as arguments and use them to create a getter & setter method and an instance variable of the same name. 

#### Benefit(s)
`attr_*` methods can take multiple arguments at once, which saves us implementation time and lines of code since we don't have to write out all those individual setter & getter methods.

#### Implementation
```ruby
class Dog
  attr_reader :name
  # attr_writer :name
  # attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "My name is #{@name}."
  end
end

dog1 = Dog.new('Lucky')
p dog1.name
p dog1.name = 'Duke'
p dog1.speak
p dog1.name
```
* Here we see how `#attr_reader` on it's own, uses the name of the argument being passed to it to only create a getter method and instance variable. Our first call to the getter method `#name` runs successfully and returns `Lucky` because our instance variable `@name` was set to that value when `dog1` was created. Our code then raises an error when calling the setter method `#name=` which has not been created.

* Let's comment out `#attr_reader` & the following code `p dog2.name` on line ??? and comment in `#attr_writer`. Here we see how `#attr_writer` on it's own, uses the name of the argument being passed to it to only create a setter method and instance variable. Calling our setter method `#name=` runs successfully, we know this because when we invoke `#speak`, `Duke` is returned showing that our instance variable `@name` has been changed to that value. Our code then raises an error when calling the getter method `#name` which has not been created.

* Now let's comment out both `#attr_reader` & `#attr_writer` and comment in all other lines of code. From this, we see how `#attr_accessor` uses the name of the argument being passed to it to create a setter method, a getter method, and an instance variable. All of our getter (`#name`) & setter (`#name=`) method calls run successfully (i.e. they've been created) and they all return the value of our instance variable `@name` at that point in time.


#### REFERENCING & SETTING @VARS vs. USING GETTERS & SETTERS (OOP6)
We can reference and set instance variables in one of two ways. Either directly by using the instance variables themselves or indirectly by using getter & setter methods.

#### Benefit(s)
It's better to use getter & setter methods rather than referencing & setting data directly with instance variables for the following reasons:

* Let's say we want to alter how a particular piece of data in our object is displayed. If we reference the instance variable directly, we'll have to add this display-altering code to every method that exposes this data. This will cause a lot of duplicate code and the chances of errors being raised from missing a method are high. If we're referencing this data with a getter method, we only need to add the display-altering code once and in one place; the getter method. This allows our code stays duplicate free (i.e. DRY) and accurate because we know the change will be program-wide with no methods accidentally missed.

* Similarly for our setter method, if we wanted to validate input before updating/changing our objects state, we'd have to add our validating code to every method that may add/alter data in our instance variable. By using a setter method, we bottleneck where any additions/alterations can be made and if we want to add validation code, it only needs to be done in one place; the setter method.

```ruby #DOUBT A CODE EXAMPLE WILL BE REQUIRED...
class Person
  def new_address(location) # SETTING
    @location = location  # setting directly with our instance variable
    self.location = location # setting with a method
  end

  def display_name
    @name # referencing directly with our instance variable
    name # referencing with our getter method
  end
end
```

### INSTANCE METHODS vs. CLASS METHODS (OOP7)
An instance method is an instance-level method defined within our class that's available to all objects instantiated from the same class. It has access to instance and class variables and serves as a way for us to expose information about the state of our object and class.

A class method is a class-level method defined within our class. It has access to class variables only and serves as a way for us to expose information about the state of our class. It's called directly on the class itself whether an object has been instantiated or not.

**The difference between the two in syntax is that we define a class method with either the class name or the keyword `self` appended to the front of the method name.**

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
Here are what the followng method calls demonstrate:
* In this code, `Human.what_am_i?`, we're calling the class method `#what_am_i?` on class `Human`. This code in particular shows that we can call a class method even if no object has been instantiated. 
* In this code, `leeya.what_am_i?`, we're calling the instance method `#what_am_i?` on our newly instantiated object `leeya`. This is a simple instance method being called. 
* In this code, `Human.number_of_humans`, we're calling the class method `#number_of_humans` on class `Human`. This is a simple class method being called, this time it's exposing state about our class (the total number of objects that have been instantiated). 
* In this code, `leeya.number_of_humans`, we're calling the instance method `#number_of_humans` on the object `leeya`. This shows that instance methods have access to class variables and are capable of exposing information about the state of the class too.


### ENCAPSULATION (OOP8)
Hiding certain data/functionality of an object by making it unavailable to access and/or change from the outside without explicit intention. 

#### Benefit(s)
* It gives us the power to control the level of accessibility to our program, allowing us to expose functionality only to the users and/or parts of the program that need it. 

#### Implementation done in 1 of 2 ways
1. By **not** creating methods that interact with the data we want to hide
``` ruby
class Student
  attr_accessor :name
  attr_reader :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end
end

leeya = Student.new('Leeya', 90)
p leeya.grade
leeya.grade = 100
```
Here by not creating a setter method for our instance variable `@grade` we're not allowing this piece of data to be changed or manipulated from the outside. This can be seen when our code `leeya.grade = 100`, which is trying to change the value of the instance variable `@grade` in the object `leeya`, raises a `NoMethodError`.

2. Through the use of Method Access Modifiers (OOP9)


### METHOD ACCESS CONTROL (OOP9)
Access control means restricting access to things, in this case methods hence the name "**Method** Access Control". In Ruby, we apply this concept to our methods thru the use of *access modifiers*, which are Ruby's built-in keywords **public**, **protected**, and **private**. If a method is defined under **private** it's a private method, **protected** it's a protected method and **public** it's a public method. An important note though is any method not defined under a keyword is automatically made public.

A public method can be accessed (i.e. called) both inside and outside the class.

A private method can only be called within the class on ourselves (i.e the calling object).

A protected method like a private method can only be called within the class but it can be called not only on the calling object but other objects of the same class. We use this modifier when we want to share data between instances of the same class.

#### Benefit(s) (See ENCAPSULATION, OOP8)

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
  
  def show_grade
    "My name is #{name} and my grade is #{self.grade}."
  end

  def grade
    calculate_grade
  end

  private
  
  def calculate_grade
    volunteer ? @grade + 3 : @grade
  end
end

leeya = Student.new('Leeya', 90)
andrew = Student.new('Andrew', 90, true)

p leeya.grade
p andrew.show_grade
p leeya.calculate_grade # will error out, trying to access private method
p leeya > andrew
```
The `#grade` method is a public method. This code shows how public methods can be called from both inside and outside the class. From inside the class, we call `#grade` within our `#show_grade` method and from outside the class we call `#grade` on our instantiated `Student` object `leeya`. Both method calls run with no errors. 

The `#calculate_grade` method is a private method. This code shoes how private methods can only be called from within the class and only on the calling object. 
The implementation details of the method though are within the private method `#calculate_grade`. This means that we can't call `#calculate_grade` from outside the class and that if we do use it inside the class it can only be called on ourselves, the calling object. This aspect of private methods is demonstrated when the code `leeya.show_grade` is run and outputs as expected and the code `p leeya.calculate_grade` raises the `NoMethodError` as expected.
If we don't want our student's grades accessible from outside the the class and only want to access them when comparing grades amongst other students (i.e. other objects of the same class) we can make `#grade` a protected method.


### CLASS INHERITANCE (OOP10)
When one class inherits behaviors from another class. The class inheriting the behavior is called the subclass, the one providing the behavior is the superclass. Applicable when there's a *is-a* relationship between classes (e.g. a dog **is-an** animal, jazz **is-a** type of music, etc).

#### Benefit(s)
This domain model based on hierarchy allows us to extract common behavior to the superclass to be reused by subclasses > increases the reusability and flexibility of our code and reduces duplication in our codebase.

#### Implementation
```ruby
class Hobbies
  def take_class; end
  def buy_supplies; end
end

class Sewing < Hobbies
  def remodel_room; end
end

class ShoeMaking < Hobbies
def find_workshop; end
end
```
Here both `Sewing` and `ShoeMaking` subclass `Hobbies`. `Sewing` **is-a** `Hobbie` as is `Shoemaking`. The common behavior `#take_class` and `#buy_supplies` have been extracted to the superclass `Hobbies` while specialized behavior specific to each subclass is defined within them. `#remodel_room` within `Sewing` and `#find_workshop` within `ShoeMaking`


### Modules (OOP11)
Used to group reusable code in one place; they are used for interface inheritance, namespacing, and to store module methods.

#### Benefit(s) & Implementation
* Interface Inheritance
Another way we achieve polymorphism and keep our code flexible and DRY in design. In a module, we define common functionality found in similar classes where there's no hierarchical relationship but there is an association; we call this a **has-a** relationship. We then add the module containing the common behavior to the classes by mixing them in using the Ruby keyword `include` (we can mix in as many modules as we want in a class).
```ruby
module Measurable
  def measure
    puts "A #{self.class} can use me to measure!"
  end
end

class Seamstress
  include Measurable
end

class Cobbler
  include Measurable
end

Seamstress.new.measure
Cobbler.new.measure
```
Here we're mixing the module `Measurable` in to two classes, `Seamstress` and `Cobbler` because the classes are similar and have a **has-a** relationship (i.e. a seamstress and a cobbler both have an ability to measure). After mixing the module in, we're able to call the `#measure` method that each class now has access to and we do so on each newly instantiated object.

* Namespacing (scope/namespace resolution operator)
When we organize and group classes, methods, and constants. This allows us to easily recognize related classes and reduces the chance of classes colliding with similarly named classes in a code base.
```ruby
module Food
  class Korean end
end

module Language
  class Korean; end
end

food = Food::Korean.new
korean = Language::Korean.new 
```
Here we're pretending to create a comprehensive app about everything there is to know about Korea. We've decided that given how extensive each topic is, it'd be best to section off our data and functionality by major areas like `Food` and `Language`. And so, we use modules to group both our `Korean` classes into their respective named spaces.

* Module Methods
When we use modules as containers for methods that seem out of place in our code.
```ruby
module ModuleName
  def self.class_method; end
end
ModuleName.class_method # or
ModuleName::class_method
```
Because we prepended `self` to our method definition, we can call the method either directly on the module or by using namespacing.


### Class Inheritance vs Interface Inheritance (OOP12)
#### Class Inheritance
* models a hierarchical domain between classes, **is-a** relationship
* one type inherits from another, thereby specializing the type of superclass.
* a class can only subclass from one class

#### Interface Inheritance
* models association between classes, **has-a** relationship
* doesn't inherit from another type, rather inherits the interface provided by the mixed in module in a 
* doesn't result in a specialized type
* a class can have as many mixed in modules as we want
* objects cannot be instantiated from a module


### POLYMORPHISM (OOP13)
When objects of different types respond to the same method invocation in different ways. 

#### 2 main ways this is implemented are
1. Polymorphism thru inheritance
``` ruby
class Hobbies
  def start_project
    select_pattern
  end

  def select_pattern
    puts "First we need a pattern."
  end
end 

class Sewing < Hobbies
  def start_project
    super
    puts "Let's get sewing!"
  end
end

class ShoeMaking < Hobbies
  def start_project
    puts "Let's get shoe making!"
  end
end

hobbies = [Sewing.new, ShoeMaking.new]
hobbies.each { |hobby| hobby.start_project }
```
Here we have polymorphism through inheritance, 2 different but related objects responding to the same method call. Although `Sewing` and `ShowMaking` are different classes, they're related because they both subclass `Hobbies`.
First we initialize the local variable `hobbies` to a 2-element `Array` where the elements are two objects instantiated from different classes; one from the `Sewing` class and the other from the `ShoeMaking` class. On the next line, we're iterating through our `hobbies` array, passing each object to the block where we call the same method on them, `#start_project`. This is where polymorphism happens, these two different objects are responding to the same method call. The `Sewing` class uses the built-in Ruby keyword `super` to specialize the implementation of the class inherited method `#start_project` meanwhile the `ShoeMaking` class overrides it entirely.

2. Polymorphism through duck-typing
``` ruby
class Illustrator
  def draw
    "I love using bold colors in my work."
  end
end

class GunSlinger
  def draw
    "Hands to the sky!"
  end
end

class Cards
  def draw
    "Take 1 card..."
  end
end

[Illustrator.new, GunSlinger.new, Cards.new].each { |object| p object.draw }
```
Polymorphism through duck-typing is when objects that are not only of different types, but that are completely unrelated, respond to the same method call. Here we have 3 different objects being instantiated from the completely unrelated classed `Illustrator`, `'GunSlinger`, and `Cards`. The objects are being instantiated in an array that is being iterated through. With each iteration, each object gets passed to the block where the method `#draw` is called on it. This is where polymorhism is occurring, even though these objects are different and completely unrelated, they're responding to the same method call, `#draw`, with different implementations.


### METHOD LOOKUP PATH (OOP14)
The order in which classes are inspected when a method is called. When a method is called Ruby will first look for it's definition in the current class, then proceed further up the lookup path until it finds a method of the same name. To see this in action we use the class method `#ancestors` which returns an array of class names in the lookup path based on the order they're checked.
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
puts "----PaperBack Method Lookup Path----"
puts PaperBack.ancestors
puts ""
puts "----Digital Method Lookup Path----"
puts Digital.ancestors
```
Here we see for a method called on an instance of the `PaperBack` class, Ruby will look for a method of the same name first in the class of the calling object then through each subsequent parent class until it is found. If no method is found a `NoMethodError` is raised. For the `PaperBack` class, the lookup path is as follows: `PaperBack > Books > Object > Kernel > BasicObject`.

For a method called on an instance of the `Digital` class, Ruby will look in a similar order. The only difference is after first checking in the current class of the calling object, Ruby will look through any mixed in modules from the last one mixed in, to the first (bottom-up). So for the `Digital` class, the lookup path is: `Digital > Downloadable > Lendable > Books > Object > Kernel > BasicObject`.

Remember this tricky example!
```ruby
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
```
(X) `Fooey > Foo2 > Bar > Foo1 > Object > Kernel > BasicObject`
(O) `Bar::Fooey > Foo2 > Object > Kernel > BasicObject`
Class Fooey doesn't inherit from a module, it's just stored in it


### SELF (OOP15)
Using `self` allows us to be explicit about what our program is referencing. What `self` refers to depends on what scope it's used in.

When used within an instance method it refers to the instance itself (i.e. the calling object)
For example, inside setter methods
```ruby
def name=(n)
  self.name = n
end
```
without `self` Ruby will interpret `name` as a local variable and no state would be set.

When used within a class but outside of an instance variable, `self` will refers to the class itself
```ruby
class Seamstress
  def self.who_am_i?
    puts "I'm a #{self}"
  end
end

Seamstress.who_am_i?
```
Here we're using `self` outside of an instance method but within the class and so both are refering to the class itself. The first one though is prepending the method name in our method definition which means we're defining a class method.

```ruby
module Measurable
  p "I am #{self} and I'm inside a mixed in module"

  def measure
    puts "#{self.class} can use me!"
  end
end

class Seamstress
  include Measurable
  p "I am #{self} and I'm inside a class definition but outside methods!"
end

class Cobbler
  include Measurable
end

Seamstress.new.measure
Cobbler.new.measure
p self
```
From the output we see that `self`: 
* inside module `Measurable` but outside a method refers to the module itself 
* inside module `Measurable` but specifically inside an instance method refers to the instance itself (i.e. the calling object)
* inside class `Seamstress` but outside a method refers to the class itself
* outside any class it refers to the main scope


### FAKE OPERATORS
Ruby has syntactic sugar which allows us to invoke methods using syntax that is more natural and easy to read but the added sugar makes these methods seem like Ruby operators. Since these methods aren't really operators, they're called "fake operators". 

For example, the inclusive range, `..`, is an operator and looks like this when used `5..10`

On the other hand, the plus `+`, looks like an operator when called like this `5 + 10 # => 15` due Ruby's syntactic sugar. Without that sugar, the syntax would be `5.+(10)`

Overriding fake operator methods makes Ruby powerful by giving the programmer flexibility to specify what data can be manipulated.

When doing this it's important to choose functionality that follows the general usage and convention from the Ruby standard library. 

For example, when overriding the `#<<` method in a class, the method should follow the Ruby standard library use for the method and it should be used to add something to a collection. The 'something' being left up to the programmer to determine (e.g. a piece of data or an entire object)


### EQUIVALENCE
The equality operator, `==`, is actually a method defined differently by various built-in Ruby classes (`String#==`, `Array#==`, `Hash#==`) to specify how to compare objects from those classes.

When left undefined `#==` will default to `BsaicObject#==` which returns `true` only when the objects being compared are the same object.
```ruby
a = "hello"
b = "hello"
p a.object_id
p b.object_id
p a == b
```
This method being called in this code is `String#==` and we can see that `#==` doesn't look for the objects being compared to be the exact same object but rather for their values to be the same. 

The `equal?` method is used to compare objects to check if they point to the *same*object or space in memory. 


### TRUTHINESS
Aside from `false` and `nil`, Ruby considers everything to be *truthy*. Meaning excluding `false` and `nil` all other objects **evaluate** to `true`
```ruby 
p !!5 
p !!'hello'
p !![1, 2, 3]
```
Here we're using the `!!` operator to convert these object's truthy values into Booleans and since Ruby evaluates all objects except for `false` and `nil` to `true` we get `true` returned for all 3 lines.
```ruby
p 5 == true
p 'hello' == true
p [1, 2, 3] == true
```
Code above returned `false` all 3 times because truthy does not equal `true`, which is an actual object from the `TrueClass` class.


### WORKING WITH COLLABORATOR OBJECTS
A collaborator object is an object of any kind, though usually a custom object, stored as state within another object. The relationship is based on association (`has-a`) not inheritance (`is-a`).

#### Benefit(s)
* Modeling complicated problem domains by representing the connections between various parts in a program.

#### Implementation
```ruby
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
```
Here we have 2 objects being instantiated; `company1` is an instance of the `Company` class and `leeya` is an instance of the `Employee` class. On the next line we're adding our `Employee` object `leeya` to the collection of employees in `company1`. Here, `leeya` is a collaborator object`company1` has a collaborator object (`leeya`).

# ****************** RETURN TO METHOD ACCESS CONTROL TO FINISH!!! **********************