# If we have a class such as the one below:
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
# In the name of the cats_count method we have used self. What does self refer to in this context?
# here self refers to the class itself and is what makes this method a class method. without it the method would be an instance method