# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?
#  They're all objects, we can use #class to find out
puts true.class # => TrueClass
puts "hello".class # => String
puts [1, 2, 3, "happy days"].class # => Array
puts 142.class # => Integer