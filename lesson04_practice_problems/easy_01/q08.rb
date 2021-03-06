# If we have a class such as the one below:
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
# You can see in the make_one_year_older method we have used self. What does self refer to here?
# here self refers to the object instance itself and is needed in a setter method for ruby to know we want to reassign our instance variable. Without it Ruby will thing we're just initializing a local variable 