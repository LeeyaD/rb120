# If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? 
# By mixing in the module in each of those classes

# How can you check if your Car or Truck can now go fast?
# We can either create instances of the Car & Truck class and invoke #go_fast to see if we'll raise a NameError but a more intentional & efficient way would be to use #ancestors on the classes
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

puts Car.ancestors
puts Truck.ancestors