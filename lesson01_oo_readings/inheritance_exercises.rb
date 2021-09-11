module Towable  
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model, :vehicle_type
  @@number_of_vehicles = 0

  def initialize(y, c, m, vt)
    @year = y
    @color = c
    @model = m
    @vehicle_type = vt
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(miles, gallons)
    miles / gallons
  end

  def self.how_many_vehicles
    @@number_of_vehicles
  end

  def to_s
    "This #{self.vehicle_type} is a #{self.year} #{color} #{self.model}"
  end

  def age
    "This #{self.vehicle_type} is #{calculate_age} years old."
  end

  private

  def calculate_age
    t = Time.now
    t.year - self.year
  end
end

class MyCar < Vehicle
  VEHICLE_TYPE = "car"
end

class MyTruck < Vehicle
  include Towable
  VEHICLE_TYPE = "truck"
end

my_car = MyCar.new(1989, "green", "Ford", "car")
puts my_car
my_truck = MyTruck.new(2000, "grey", "Kmart", "truck")
puts my_truck
p Vehicle.how_many_vehicles
# p "Method Look up Chain for MyCar"
# p MyCar.ancestors
# p "Method Look up Chain for MyTruck"
# p MyTruck.ancestors
# p "Method Look up Chain for Vehicle"
# p Vehicle.ancestors

puts my_truck.age
puts my_car.age
# puts my_car.calculate_age
require 'pry'
require 'pry-byebug'
class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(n, g)
    self.name = n
    self.grade = g
  end

  def better_than_grade?(other)
    # binding.pry
    self.grade > other.grade
  end

  protected

  attr_reader :grade
end
joe = Student.new("Joe", 95)
bob = Student.new("Bob", 91)

puts "Well done" if joe.better_than_grade?(bob)
puts joe.grade

# Given the following code...
# bob = Person.new
# bob.hi
# And this error...
# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>...
# What is the problem and how would you go about fixing it? #hi is private, make it public