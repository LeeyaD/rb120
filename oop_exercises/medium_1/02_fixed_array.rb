# A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:
class FixedArray
  attr_accessor :array

  def initialize(int)
    @array = Array.new(int)
  end

  def [](int)
    raise IndexError unless int < array.size
    array[int]
  end
  
  def []=(idx, obj)
    raise IndexError unless idx < array.size
    self.array[idx] = obj
  end

  def to_a
    array #clone is best so we don't offer up our data but a new Array
  end

  def to_s
    "#{array}" #to_a
  end
end


fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5
# FixedArray.new(2) => [nil, nil]
# class should create an array input length long with 'nil' as it's elements

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]
#[]= elemental assignment will come with this, should be destructive...
#to_a should output the entire array, brackets & all
fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'
#to_s should output the entire array in string form, not just the array's elements
puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# The above code should output true 16 times.
