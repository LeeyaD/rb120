Interview is more like a conversation, it's okay to ask; Did I answer your question?; Was that enough detail?; Do you want me to go into it more?

Won't be able to past in code snippets in interview

Also, Interview code examples should be simple but not basic-basic

* Before the interview clear off table, write Nouns for code examples!

#### Additional Tips
Written & Interview are a mix of Conceptual & Code-Based Questions

Don't add more abstraction than needed in your explanation (e.g. talking about simple classes & objects don't add an attr_*)

Precision of Language: In programming, we must always concern ourselves with outputs, return value, and object mutations. We must use the right terms when we speak, and not use vague words like "results." Furthermore, we need to be explicit about even the smallest details.

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

* Likewise for our setter method, if we wanted to add some sort of validation we'd have to do so in every method that may add/alter our data. By using a setter method, we bottleneck where any additions/alterations can be done and if we want to add/update validation code, it only needs to be done in one place.


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


### ENCAPSULATION
A form of data protection that let's us make certain data/functionality of an object unavailable to access and/or change from the outside without explicit intention. 

#### Benefit(s) (similar to MAC section)
* Encapsulation gives us the power to control the level of accessibility to our program, allowing us to hide or expose functionality only to the users and/or parts of the program that need it. 

#### Implementation
##### Encapsulation can be achieved in 1 of 2 ways.
1. Through the use of Method Access Modifiers (see previous section: prevMAC) and
2. By **not** creating methods that interact with the data we want to hide.
``` ruby
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
  
  protected

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
rich = Student.new('Rich', 95)

# p leeya.grade
# p andrew.grade
# p rich.grade
# p leeya.calculate_grade # will error out, trying to access private method
p leeya > andrew
p andrew > rich
```
Here by not creating a setter method for our @acct_number we're not allowing this piece of data to be changed or manipulated from the outside.


### METHOD ACCESS CONTROL (prevMAC)
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



### CLASS INHERITANCE
When one class inherits behaviors from another class. The class inheriting the behavior is called the subclass, the one providing the behavior is the superclass. Present where there's a *is-a* relationship between classes.

#### Benefit(s)
This domain model based on hierarchy allows us to:

* extract common behavior to the superclass to be reused by subclasses, helping us avoid duplication in our code

* subclasses are left to define and implement fine-grained, detailed behavior.

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
Here the both `Sewing` and `ShoeMaking` subclass `Hobbies`. Sewing is-a Hobbie as is Shoemaking. The common behavior `#take_class` and `#buy_supplies` have been extracted to the superclass `Hobbies` while specialized behavior specific to each subclass is defined within them (i.e. `#remodel_room` and `#find_workshop`)


### Modules
Used to group reusable code in one place; they are used for interface inheritance, namespacing, and to store module methods.

#### Benefit(s) & Implementation
* Interface Inheritance
Another way we achieve polymorphism and keep our code flexible and DRY in design. We add common functionality to similar classes where there's no hierarchical relationship but there is an association (i.e. a "has-a" relationship). We do this by mixing in modules using Ruby keyword `include` (as many as we want). This usage is
```ruby
module Measurable
  def measure
    puts "#{self.class} can use me!"
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
Here we're mixing the module `Measurable` in to two classes, `Seamstress` and `Cobbler` because the classes are similar and have a "has-a" relationship (i.e. a seamstress and a cobbler have an ability to measure). Below the class definitions, we're calling the `#measure` method that each class now has access to, on each newly instantiated object. We see this in our output output.

* Namespacing (scope/namespace resolution operator)
When we organize and group classes, methods, and constants. This allows us to easily recognize related classes and reduces the change of classes colliding with similarly named classes in a code base.
```ruby
module Food
  class Korean; end
end

module Language
  class Korean; end
end

food = Food::Korean.new
korean = Language::Korean.new 
```
Here we're creating a comprehensive app about everything there is to know about Korea. We've decided that it'd be best to section off our data and functionality by major areas, `Food` and `Language`. And so, we use modules to group both our `Korean` classes into their respective named spaces.

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


### Class Inheritance vs Interface Inheritance
#### Class Inheritance
* models a hierarchical domain, a "is-a" relationship
* one type inherits from another, thereby specializing the type of superclass.
* a class can only subclass from one class

#### Interface Inheritance
* doesn't inherit from another type, rather inherits the interface provided by the mixed in module
* doesn't result in a specialized type
* a class can have as many mixed in modules as we want
* objects cannot be instantiated from a module


### POLYMORPHISM
When objects of different types respond to the same method invocation in different ways. 

#### 2 main ways this is implemented are
1. Polymorphism thru inheritance
Benefits are the same as 'Class Inheritance' & 'Interface Inheritance' (see `Modules` for code)
``` ruby
class Hobbies # class inheritance
  def start_project
    select_pattern
  end

  def select_pattern; end
end 

class Sewing < Hobbies
  def start_project
    super #allows us to call methods earlier in the method lookup path
    "Let's get sewing!"
  end
end

class ShoeMaking < Hobbies
  def start_project
    "Let's get shoe making!"
  end
end

hobbies = [Sewing.new, ShoeMaking.new]
hobbies.each { |hobby| p hobby.start_project }
```
Here our two different objects from the `Sewing` and `ShoeMaking` class respond to the same method call `#start_project`. The `Sewing` class by inheriting the method, `super` can be added to specialize the method further. The `ShoeMaking` class by overriding the inherited `#start_project` method entirely.

2. Polymorphism through duck-typing
Objects not only of different types but objects that are completely unrelated respond to the same method call
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
    "Taking 1 card..."
  end
end

[Illustrator.new, GunSlinger.new, Cards.new].each { |object| p object.draw }
```
Here we have 3 completely unrelated objects, `Illustrator`, `'GunSlinger`, `Cards` responding to the same method call `#draw`.


### METHOD LOOKUP PATH
The order in which classes are inspected when a method is called. When a method is called Ruby will first look for it's definition in the current class, then proceed further up the lookup path until it finds a method of the same name. To see this in action we use the class method #ancestors which returns an array of class names in the lookup path based on the order they're checked.
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
Here we see for a method called on an instance of the PaperBack class, Ruby would look for it in the following order until it is found `PaperBack > Books > Object > Kernel > BasicObject` if no method is found a `NoMethodError` is raised.

`Digital > Downloadable > Lendable > Books > Object > Kernel > BasicObject`Here Ruby first checks the class, then any mixed in modules from the last one mixed in to the first (bottom - up)

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


### SELF
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