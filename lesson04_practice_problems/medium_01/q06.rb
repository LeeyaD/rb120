# If we have these two methods in the Computer class:
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
# and
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
# What is the difference in the way the code works?
# A: Functionally there's no difference
# First example
# - @template is directly calling our instance variable to change the value stored
# - calling our getter method
# Second example
# - Calling our setter method to change the value of our instance method
# - prefixed our getter method w/ self...