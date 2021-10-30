# If we have the class below, what would you need to call to create a new instance of this class.
# to create a new instance of this class we'd need to call #new and pass it 2 arg;, color & material
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
