* Before the interview clear off table, write Nouns for code examples!

#### Additional Tips
Precision of Language: In programming, we must always concern ourselves with outputs, return value, and object mutations. We must use the right terms when we speak, and not use vague words like "results." Furthermore, we need to be explicit about even the smallest details.

Present or teach OOP topics. You should be able to talk about:
* why they exist (benefit)
* how to use them in code (code example)

### WHAT IS OOP? (01)
A Programming model where areas of code that perform certain procedures are sectioned off, allowing programs to become an interaction of many small parts that can be changed/manipulated without affecting the entire program.

#### Benefits
* By sectioning off code into smaller parts we reduce dependencies and make debugging & maintaining the codebase easier.
* Defining basic classes and leveraging concepts like inheritance to introduce more detailed behaviors means our code is more "DRY" and has a greater level of reusability and flexibility.
* Naming those small parts (i.e. classes & objects) after real-world nouns and modeling them appropriate to the problem, lets programmers think at a higher level of abstraction when designing and helps them break down and solve problems that arise.


# CLASSES AND OBJECTS
#### Example
Create a simple class with 1 attribute & 1 behavior.

* Classes are like templates, they define specify what attributes & behaviors objects created from the class will have by using instance variables and instance methods.
* Each object has its own state, the data assigned to those instance variables are specfic to each object.


### INSTANCE VARIABLES vs. CLASS VARIABLES
#### Example
Create a simple class with 2 attributes (one instance, one class) & 1 behavior.

### Instance variables
* have `@` appended to the front of the variable name
* store the state of an object
* are scoped at the object-level and are only accessible via an instance method. 
**know this fact but don't mention it**: have to be initialized in order to be referenced. If they're initialized in a method, that method must be called first. If this doesn't happen, the initialization doesn't occur and when referenced the instance variable will return nil.

#### Class variables 
* have `@@` appended to the front of the variable name
* store the state of the class so all objects share the same copy of it
* are scoped at the class-level and can be accessed by both instance & class methods. 


### INSTANCE METHODS vs. CLASS METHODS
#### Example
Create a simple class with an attribute & 2 behaviors; one instance-level and one class-level.

#### Instance methods
* instance-level method defined within our class
* available to all objects instantiated from the same class
* has access to instance and class variables
* serves as a way for us to expose information about the state of our object and class

#### Class methods
* class-level method defined on the class itself, within our class
* called directly on the class itself whether an object has been instantiated or not
* has access to class variables only 
* serves as a way for us to expose information about the state of our class


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
Access control means restricting access to things, in this case methods hence the name "**Method** Access Control". In Ruby, we apply this concept to our methods thru the use of *access modifiers*, which are Ruby's built-in `Module` methods **public**, **protected**, and **private**. If a method is defined under **private** it's a private method, **protected** it's a protected method and **public** it's a public method. An important note though is any method not defined under a keyword is automatically made public.

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


### CLASS INHERITANCE
* when one class (subclass) inherits behaviors from another class (superclass), thereby specializing the type of superclass.
* applicable when there's a **is-a** relationship (i.e. hierarchical) between classes (e.g. a dog **is-an** animal, jazz **is-a** genre of music, etc).
* allows us to extract common behavior to the superclass to be reused by subclasses > increases the reusability and flexibility of our code and reduces duplication in our codebase.

### Modules
Used to group reusable code in one place with 3 specific use cases.

#### Interface Inheritance
* define common functionality found in similar classes in a module that we add to classes via 'mixins' (i.e. the class inherits the interface provided by the mixed in module)
* where there's no hierarchical relationship but there is an association; we call this a **has-a** relationship
* another way we achieve polymorphism and keep our code flexible and DRY in design. 

#### Namespacing (scope/namespace resolution operator)
* organize and group similarly named and/or related classes
* easily recognize related classes
* reduces chance of similarly named classes colliding in the code base.

#### Module Methods
* containers for methods that seem out of place in our code.


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


```ruby
module Flightable
  def fly
    # METHOD IMPLEMENTATION
  end
end

class Superhero 
  include Flightable
  
  attr_accessor :ability
  
  def self.fight_crime
    # METHOD IMPLEMENTATION
  end
  
  def initialize(name)
    @name = name
  end
  
  def announce_ability
    puts "I fight crime with my #{ability} ability!"
  end
end

class LSMan < Superhero ; end

class Ability
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

superman = Superhero.new('Superman')
superman.fly # => I am Superman, I am a superhero, and I can fly!
LSMan.fight_crime
# => I am LSMan!
# => I fight crime with my coding skills ability!
```
ONLY touch methods that say 'METHOD IMPLEMENTATION' & use the Ability class


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