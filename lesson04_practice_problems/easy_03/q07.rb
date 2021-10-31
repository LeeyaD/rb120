# What is used in this class but doesn't add any value?
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end
# A: the instance variables 'brightness' and 'color' we don't do anything with them
# CORRECT A: the keyword 'return' since Ruby evaluates the last line of code in a method