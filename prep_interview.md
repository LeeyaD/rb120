#### Additional Tips
Present or teach OOP topics. You should be able to talk about:
* why they exist (benefit)
* how to use them in code (code example)

### WHAT IS OOP?
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


### ENCAPSULATION
* the grouping of data/functionality into objects while making that data unavailable to access and/or change from other parts of a codebase without explicit intention.
* Encapsulating data into objects has two chief benefits:
1. It protects data from unintentional manipulation by making methods where the intent is obvious
2. It allows us to hide complex operations while leaving a simple public interface to interact with those more complex operations.
* Encapsulation is implemented in 2 ways:
1. Thru the types of methods we create and/or don't create (e.g. `#change_name` over `#name=` or omitting a setter method)
2. Method Access Control (via *access modifiers*)

Let’s illustrate these benefits with an example.
```ruby
class Person
  attr_accessor :car

  def initialize(name)
    @name = name
    @car = nil
  end
end

class Car
  attr_reader :make, :model, :year, :engine_status

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
    @engine_status = :off
  end

  def start_engine
    switch_ignition
    start_relay
    start_motor
    puts "Engine is #{engine_status}!"
  end

  private

  attr_writer :engine_status

  def switch_ignition
    # implementation
    puts 'Starting ignition...'
  end

  def start_relay
    # implementation
    puts 'Starting relay...'
  end

  def start_motor
    # implementation
    puts 'Starting motor...'
    self.engine_status = :on
  end
end

joe = Person.new('Joe')
joe.car = Car.new('Chevy', 'Impala', 1958)

joe.car.start_engine
# => 'Starting ignition...'
# => 'Starting relay...'
# => 'Starting motor...'
# => 'Engine is on!'

puts joe.car.engine_status
# => 'on'

joe.car.engine_status = :off
# => private method `engine_status=' called for #<Car:0x0000000147948bd8 @make="Chevy", @model="Impala", @year=1958, @engine_status=:on> (NoMethodError)
```
The above code illustrates a simple but key point: in order to start the car, the object joe doesn’t need to know the implementation details of every method involved in starting the engine, or even that those methods exist. More specifically, objects of the Person class do not need to access the switch_ignition, start_relay and start_motor methods, which are all necessary steps in starting an engine. Rather, the only method that objects of the Person class need to know about is the start_engine method; all other implementation details that follow from this method can remain hidden and inaccessible.
And that is encapsulation in practice. We’ve packaged all of the complex details involved in starting an engine, have made them inaccessible outside of the Car class and instead have defined a simple public interface — the start_engine method — to handle all of the underlying complexity. In fact, this models the real world implementation of starting a car: one doesn’t need to know the internal mechanics of how exactly a car engine starts. Instead, a person only needs to know how to turn the ignition with a key. The rest of the implementation happens under the hood and out of sight; in other words, it is encapsulated.
Notice as well that while we have defined a public getter method for the @engine_status instance variable in line 11, we have made its setter method in line 27 private. While we may want the status of the engine to be publicly accessible (for example, a mobile app is able to check if the engine is running), we want only the internal implementation of the object’s class to be able to reassign it, which protects it from the possibility of being directly changed from outside the class. In practical terms, we don’t want an object other than a Car to be able to modify @engine_status. Rather, we want it to be changed only as a result of the internal implementation that begins with the public start_engine method and ends with the private start_motor method. We want the value of @engine_status to reflect the actual status of the engine, while also preventing arbitrary changes that don’t. Using method access control to structure our methods this way ensures that @engine_status is manipulated with clear intention and only in the specific way we’ve designed it to be changed in our program.

In summary, encapsulation allows a programmer to group data into objects and then hide that data from the rest of the codebase. Likewise, it also allows a programmer to expose only data that needs to be accessed outside of the class. By encapsulating data, we can prevent arbitrary changes to data, and we can also hide complex operations while providing a simple public interface to interact with them.


### METHOD ACCESS CONTROL
* access control is the ability to control access to things, restricting access to things
* Ruby uses the concept of access control to restrict and open access to the methods that allow one to retrieve and manipulate data within an object
* methods are public unless explicitly declared to be private or protected.
* Like private methods, protected methods can only be called from within the class, but unlike private methods they can be called on both self and other objects of the same class


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


### POLYMORPHISM
When objects of different types respond to the same method invocation in different ways.
1. Polymorphism thru inheritance (class & interface)
2. Polymorphism through duck-typing


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
