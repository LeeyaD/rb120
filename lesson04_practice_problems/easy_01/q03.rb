# In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.
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
# When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!

#Thru string interpolation & self.class
# here self refers to the object instance, when we call #class on self we get the name of the class our instance was created from, in this case Car.
# then we interpolate our return value, Car, into the output string 
