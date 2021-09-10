module Mammal
  def self.out_of_place_method(arg)
    arg *2
  end
end

value = Mammal.out_of_place_method(4)
