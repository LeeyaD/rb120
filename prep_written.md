#### Additional Tips
Precision of Language: In programming, we must always concern ourselves with outputs, return value, and object mutations. We must use the right terms when we speak, and not use vague words like "results." Furthermore, we need to be explicit about even the smallest details.

### WHAT IS OOP? (01)
A Programming model where areas of code that perform certain procedures are sectioned off, allowing programs to become an interaction of many small parts that can be changed/manipulated without affecting the entire program.


#### Benefits
* By sectioning off code into smaller parts we reduce dependencies and make debugging & maintaining the codebase easier.
* Defining basic classes and leveraging concepts like inheritance to introduce more detailed behaviors means our code is more "DRY" and has a greater level of reusability and flexibility.
* Naming those small parts (i.e. classes & objects) after real-world nouns and modeling them appropriate to the problem, lets programmers think at a higher level of abstraction when designing and helps them break down and solve problems that arise.


### CLASSES AND OBJECTS (02)
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


### INSTANCE VARIABLES vs. CLASS VARIABLES (03)
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


#### HOW TO CALL SETTERS & GETTERS (04)
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


### USING ATTR_* TO CREATE SETTER & GETTER METHODS (05)
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


#### REFERENCING & SETTING @VARS vs. USING GETTERS & SETTERS (06)
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

### INSTANCE METHODS vs. CLASS METHODS (07)
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


### ENCAPSULATION (08)
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


### METHOD ACCESS CONTROL (09)
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
    "Student: #{name} | Grade: #{self.grade}"
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
The `#grade` method is a public method and shows how public methods can be called from both inside and outside the class. From inside the class, we call `#grade` within our `#show_grade` method and from outside the class we call `#grade` on our instantiated `Student` object `leeya`. Both method calls return the value of our instance variable `@grade` as expected.

The `#calculate_grade` method is a private method and shows how private methods can only be called from within the class. This is demonstrated when the code `p leeya.show_grade` outputs what we expect and the code `p leeya.calculate_grade` raises the `NoMethodError` as expected.

Let's comment out`p leeya.calculate_grade` and run the code again. At this point all our other method calls run and output what we expect:
* `p leeya.grade` outputs leeya's grade, `90`
* `p andrew.show_grade` outputs "Student: Andrew | Grade: 93."
* `p leeya > andrew` outputs "Andrew's grade is higher."

From this we know that objects of the `Student` class can expose a student's grade via 2 methods and compare one student's grade to another. Let's say we only want to access a student's grade with explicit intent by using the `#show_grade` method and that we want to restrict `#grade`'s ability to access this data from outside the class.

If we move `#grade` under the access modifier **private** we restrict access to the student's grade from outside the class, we know this because a `NoMethodError` is raised when `p leeya.grade` is run. Although this is what we want, if we comment out `p leeya.grade` we see that we're also raising a `NoMethodError` when `p leeya > andrew` runs. Because we made `#grade` into a private method, we can no longer share data between objects of the same class because private methods can only be called on the calling object.

If we don't want our student's grades accessible from outside the the class and only want to access them when comparing grades amongst other students (i.e. other objects of the same class) we need to make `#grade` a protected method. Let's move `#grade` out from under the **private** access modifier, add the **protected** modifier above it and comment back in `p leeya.grade` but move it so it's the very last code to run.

Now our code runs the way we'd like, we've limited access to students' grades but are still able to compare grades between other student objects.


### CLASS INHERITANCE (OOP10)
When one class inherits behaviors from another class. The class inheriting the behavior is called the subclass, the one providing the behavior is the superclass. Applicable when there's a *is-a* relationship between classes (e.g. a dog **is-an** animal, jazz **is-a** type of music, etc).

#### Benefit(s)
This domain model based on hierarchy allows us to extract common behavior to the superclass to be reused by subclasses > increases the reusability and flexibility of our code and reduces duplication in our codebase.

#### Implementation
```ruby
class Handcraft
  def start_project; end
  def buy_supplies; end
end

class Sewing < Handcraft
  def select_pattern; end
end

class ShoeMaking < Handcraft
  def measure_foot; end
end
```
Here both `Sewing` and `ShoeMaking` subclass `Handcraft`. `Sewing` **is-a** type of craft done by hand as is `Shoemaking`. The common behavior `#start_project` and `#buy_supplies` have been extracted to the superclass `Handcraft` while specialized behavior specific to each subclass is defined within them. `#select_pattern` within `Sewing` and `#measure_foot` within `ShoeMaking`.


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
Here we're pretending to create a comprehensive app about everything there is to know about Asia. We've decided that given how extensive each topic is for each county, it'd be best to section off our data and functionality by major areas like `Food` and `Language`. And so, we use modules to group both our `Korean` classes into their respective named spaces. Now when we create new objects from either class for example, it's clear from the namespace which topic we're referring to.

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
* doesn't inherit from another type, rather inherits the interface provided by the mixed in module in 
* doesn't result in a specialized type
* a class can have as many mixed in modules as we want
* objects cannot be instantiated from a module


### POLYMORPHISM (OOP13)
When objects of different types respond to the same method invocation in different ways. 

#### 2 main ways this is implemented are
1. Polymorphism thru inheritance
``` ruby
class Handcraft
  def start_project
    select_pattern
  end

  def select_pattern
    puts "First we need a pattern."
  end
end 

class Sewing < Handcraft
  def start_project
    super
    puts "Let's get sewing!"
  end
end

class ShoeMaking < Handcraft
  def start_project
    puts "Let's get shoe making!"
  end
end

handcraft = [Sewing.new, ShoeMaking.new]
handcraft.each { |hobby| hobby.start_project }
```
Here we have polymorphism through inheritance, 2 different but related objects responding to the same method call. Although `Sewing` and `ShowMaking` are different classes, they're related because they both subclass `Handcraft`.
First we initialize the local variable `handcraft` to a 2-element `Array` where the elements are two objects instantiated from different classes; one from the `Sewing` class and the other from the `ShoeMaking` class. On the next line, we're iterating through our `handcraft` array, passing each object to the block where we call the same method on them, `#start_project`. This is where polymorphism happens, these two different objects are responding to the same method call. The `Sewing` class uses the built-in Ruby keyword `super` to specialize the implementation of the class inherited method `#start_project` meanwhile the `ShoeMaking` class overrides it entirely.

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
Polymorphism through duck-typing is when objects that are not only of different types, but that are unrelated, respond to the same method call. Here we have 3 different objects being instantiated from the unrelated classes `Illustrator`, `'GunSlinger`, and `Cards`. The objects are being instantiated in an array that is being iterated through. With each iteration, each object gets passed to the block where the method `#draw` is called on it. This is where polymorhism is occurring, even though these objects are different and unrelated, they're responding to the same method call, `#draw`, with different implementations.
```ruby
class ShoeMaker
  def start_project
    measure_feet
    choose_pattern
  end
end

class Carpenter
  def start_project
    choose_furniature_piece
    choose_wood_type
  end
end

class Mason
  def start_project
    choose_stone
    measure_structure
  end
end

[ShoeMaker.new, Carpenter.new, Mason.new].each { |object| p object.start_project }
```

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

**When used within an instance method it refers to the instance itself (i.e. the calling object)**
```ruby
def name=(n)
  self.name = n
end
```
Here we're using `self` inside a setter method, without it Ruby will interpret `name` as a local variable and no state would be set.

**When used within a class but outside of an instance method, `self` refers to the class itself**
```ruby
class Seamstress
  def self.who_am_i?
    puts "I'm a #{self}"
  end
end

Seamstress.who_am_i?
```
Here we're using `self` outside of an instance method but within the class and so both are refering to the class itself. The first one on line ??? is prepended to the method name in our method definition because we're defining a class method.

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
What `self` refers to depends on what scope it's used in. Thi fact is further substantiated by the output from the code above. In it we see:
* when `self` is inside the module `Measurable` but outside a method, it refers to the module itself.
* when `self` is inside an instance method defined in the module `Measurable`, it refers to the instance itself (i.e. the calling object).
* when `self` is inside the class `Seamstress` but outside a method, it refers to the class itself.
<!-- * when `self` is outside any class it refers to the `main` scope --> Maybe leave this out...???


### FAKE OPERATORS (OOP16)
Ruby's syntactic sugar allows us to invoke methods using syntax that is natural and easy to read. The added sugar makes these methods seem like Ruby operators even though they're not, they're what we call **fake operators**. 

Plus `+` looks like an operator when called (`5 + 10`), thanks to Ruby's syntactic sugar. Without the added sugar, we'd call it like this `5.+(10)`. Written like that, it's easy to see that it's actually a method.

Overriding fake operator methods makes Ruby powerful by giving the programmer flexibility to specify what data can be manipulated.

When doing this it's important to choose functionality that follows the general usage and convention from the Ruby standard library. 

For example, when overriding the `#<<` method, it should follow the Ruby standard library use for the method and be used to add something to a collection.
#### Implementation
```ruby
class Dog
  attr_reader :name, :age, :breed

  def initialize(name, age, breed)
    @name = name
    @age = age
    @breed = breed
  end

  def ==(other_dog)
    self.breed == other_dog.breed
  end
end

lassie = Dog.new('Lassie', 4, "Collie")
bo = Dog.new('Bo', 5, "Collie")
duke = Dog.new('Duke', 7, "Great Dane")

p lassie == bo
p lassie == duke
```
Here we overrode the fake operator `#==` in our `Dog` class in order to give objects instantiated from this class the ability to compare themselves. The criteria for which was decided by us the programmer and in this code objects of the `Dog` class are considered equal when they're off the same breed. 


### EQUIVALENCE (OOP17)
The equality operator, `==`, is actually a method defined differently by various built-in Ruby classes (`String#==`, `Array#==`, `Hash#==`) to specify how to compare objects from those classes.

When left undefined `#==` will default to `BsaicObject#==` which returns `true` only when the objects being compared are the same exact object.
```ruby
a = "hello"
b = "hello"
p a.object_id
p b.object_id
p a == b
```
Here the `#==` method being called in this code is given to us by the `String` class. From the output we can see that `String#==` doesn't check if the 2 objects being compared are the same object, rather it returns `true` when the *values* of both objects are the same.

The `equal?` method is used to compare objects to check if they point to the *same* object/space in memory. 


### TRUTHINESS (OOP18)
Aside from `false` and `nil`, Ruby considers everything to be *truthy*. Objects that are truthy **evaluate** to `true`.
```ruby 
p !!5 
p !!'hello'
p !![1, 2, 3]
```
Here we're using the `!!` operator to convert these objects' truthy values into Booleans and since none of these objects are `false` nor `nil` all 3 lines return `true`.
```ruby
p 5 == true
p 'hello' == true
p [1, 2, 3] == true
```
This code returns `false` all 3 times because truthy does not equal `true`. Evaluating to true is not the same as being an actual object from the `TrueClass` class, which is what `true` actually is.


### WORKING WITH COLLABORATOR OBJECTS (OOP19)
A collaborator object is an object of any kind, usually a custom object, that is stored as state within another object. The relationship is based on association (i.e. `has-a` relationship) and not inheritance (i.e. `is-a`relationship).

#### Benefit(s)
* It models complicated problem domains by representing the connections between various parts in a program.

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
etsy = Company.new('Etsy')
leeya = Employee.new('Leeya')

etsy.employees << leeya
p etsy.employees
```
Here we have 2 objects being instantiated; `etsy` is an instance of the `Company` class and `leeya` is an instance of the `Employee` class. In the next line of code we're adding our `Employee` object `leeya` to the collection of employees in `etsy`. With this, `leeya` is now a collaborator object of `etsy`.