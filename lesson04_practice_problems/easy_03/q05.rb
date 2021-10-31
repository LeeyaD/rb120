# If I have the following class:
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
# What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer
# NoMethodError b/c Ruby can't find the instance method (it doesn't exist)
tv.model
# method logic would run like normal
Television.manufacturer
# method logic would run just fine
Television.model
# NoMethodError b/c Ruby can't find the class method (it doesn't exist)
