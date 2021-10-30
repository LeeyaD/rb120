# If I have the following class:
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
# Which one of these is a class method (if any) and how do you know? 
# A: #manufacturer is a class method because it's defined w/ self as a prefix which refers to the class itself and not an instance
# How would you call a class method?
# A: On the class itself, so in this case Television#manufacturer