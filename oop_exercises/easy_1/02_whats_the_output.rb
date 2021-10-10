class Pet
  attr_reader :name

  def initialize(name)
    @name = name#.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy' #local var name assigned to String obj, Fluffy
fluffy = Pet.new(name) #@name now points to the String obj, Fluffy too
puts fluffy.name # => 'Fluffy'
puts fluffy # => My name is FLUFFY.
puts fluffy.name # => 'FLUFFY'
puts name # => 'FLUFFY'
# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.