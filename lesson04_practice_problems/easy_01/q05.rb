# Which of these two classes has an instance variable and how do you know?
# class Pizza has an instance variable. Instance variables always begin with one '@' symbol & then the name
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
