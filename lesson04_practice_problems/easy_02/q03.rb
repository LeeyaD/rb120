# How do you find where Ruby will look for a method when that method is called? 
# A: You look at the object the method was called on, that is where Ruby will start looking for a method.
# How can you find an object's ancestors?
# A: by calling #ancestors on the object
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
# What is the lookup chain for Orange and HotSauce?
# Orange - Orange > Taste > Object > Kernel > BasicObject
# HotSauce - HotSauce > Taste > Object > Kernel > BasicObject