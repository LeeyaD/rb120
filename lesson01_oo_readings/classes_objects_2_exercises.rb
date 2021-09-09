class MyCar
  attr_accessor :color, :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
  end

  def self.gas_mileage(miles, gallons) #1
    miles / gallons
  end

  def to_s #2
    "This car is a #{self.year} #{color} #{self.model}"
  end
end

my_car = MyCar.new(1989, "green", "Ford")
puts my_car

# 3. When running the following code...
class Person
  attr_reader :name # => attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
# We get an error...
# test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
# Why do we get this error and how do we fix it?
# - We haven't given objs created from our Person class the ability to reassign it's name beacause we don't have a setter method defined (i.e. no #name= method exists)
# - To fix this, we need to define a #name= method, we can either write one out or change our attr_reader into an attr_accessor