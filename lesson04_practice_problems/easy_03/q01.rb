# If we have this code:
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
# What happens in each of the following cases:
# case 1:
hello = Hello.new
hello.hi
# A: 'Hello' will output

# case 2:
hello = Hello.new
hello.bye
# A: NoMethodError will be raised b/c Ruby won't be able to find that instance method in class Hello nor it's lookup chain Greeting > Object > Kernel > BasicObject

# case 3:
hello = Hello.new
hello.greet
# A: ArgumentError will be raised because #greet was expecting 1 arg but we gave it 0

# case 4:
hello = Hello.new
hello.greet("Goodbye")
# A: 'Goodbye' will output

# case 5:
Hello.hi
# A: NoMethodError will be raised b/c Ruby won't  be able to find that class method, not in Hello nor it's lookup chain Greeting > Object > Kernel > BasicObject


