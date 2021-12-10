#### Additional Tips
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

### MODULES
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


### METHOD LOOKUP PATH
* order in which classes are inspected when a method is called
* Ruby'll first look for it's definition in the current class, then proceed further up the lookup path until it finds a method of the same name 
* the class method `#ancestors` which returns an array of class/module names in the lookup path, in order
Remember this tricky example!
```ruby
module Foo1; end

module Foo2; end

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
* Ruby keyword allowing us to be explicit about what our program is referencing, which depends on the scope it's being used in
* withing a class, inside an instance method, it refers to the calling object
* withing a class but outside an instance method, it refers to the class itself


### EQUIVALENCE
* the equality `#==` method compares the equality of two objects, returning `true` or `false`
* the criteria for determining equivalence is defined differently by various built-in Ruby classes (`String#==`, `Array#==`, `Hash#==`)
* when creating custom classes, it's important to define it's own `#==` method otherwise Ruby will look for it further up the lookup path and call `BsaicObject#==` which returns `true` only when the objects being compared are the same exact object.
* `equal?` method is used to compare objects to check if they point to the *same* object/space in memory. 


### WORKING WITH COLLABORATOR OBJECTS
* a collab. obj. is an object of any kind, stored as state within another object
* relationship is based on association (i.e. `has-a`) and not inheritance (i.e. `is-a`)
* it models complicated problem domains by rep. the connections between various parts in a program.


#### REFERENCING & SETTING @VARS vs. USING GETTERS & SETTERS
* Let's say we want to alter how a piece of data in our object is displayed. If we reference the `@var` directly, we'll have to add this display-altering code to every method that exposes this data. This will cause a lot of duplicate code and the chances of errors being raised from missing a method are high. If we're referencing this data with a getter method, we only need to add the display-altering code once and in one place; the getter method. This allows our code stays duplicate free (i.e. DRY) and accurate because we know the change will be program-wide with no methods accidentally missed.

* Similarly for our setter method, if we wanted to validate input before updating/changing our objects state, we'd have to add our validating code to every method that may add/alter data in our instance variable. By using a setter method, we bottleneck where any additions/alterations can be made and if we want to add validation code, it only needs to be done in one place; the setter method.


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


=begin
The local zoo is creating an app to redesign their habitats and decide
which animals to put together. The first version of the app resulted in a
bloodbath. Define the necessary classes and methods to implement the following functionality so that herbivores
can't be placed in habitats with carnivores and vice versa.
=end

giraffe = Giraffe.new
elephant = Elephant.new
lion = Lion.new

savannah = Habitat.new

savannah << giraffe
savannah << elephant
savannah << lion # => Don't put carnivores and herbivores in the same habitat!

prairie = Habitat.new

prairie << lion
prairie << elephant # => Don't put carnivores and herbivores in the same habitat!