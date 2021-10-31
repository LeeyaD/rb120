# What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?
# A: adding an attr_accessor that will supply the two methods we're removing, getter & setter, for us
class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  # def type
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end