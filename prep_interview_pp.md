```ruby
module Flightable
  def fly
    # METHOD IMPLEMENTATION
  end
end

class Superhero 
  include Flightable
  
  attr_accessor :ability
  
  def self.fight_crime
    # METHOD IMPLEMENTATION
  end
  
  def initialize(name)
    @name = name
  end
  
  def announce_ability
    puts "I fight crime with my #{ability} ability!"
  end
end

class LSMan < Superhero ; end

class Ability
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

superman = Superhero.new('Superman')
superman.fly # => I am Superman, I am a superhero, and I can fly!
LSMan.fight_crime
# => I am LSMan!
# => I fight crime with my coding skills ability!
```
ONLY touch methods that say 'METHOD IMPLEMENTATION' & use the Ability class


The local zoo is creating an app to redesign their habitats and decide
which animals to put together. The first version of the app resulted in a
bloodbath. Define the necessary classes and methods to implement the following functionality so that herbivores
can't be placed in habitats with carnivores and vice versa.

```ruby
giraffe = Giraffe.new
elephant = Elephant.new
lion = Lion.new

savannah = Habitat.new

savannah << giraffe
savannah << elephant
savannah << lion # => Don't put carnivores and herbivores in the same habitat!

prairie = Habitat.new

prairie << lion
prairie << elephant # => Don't put carnivores and herbivores in the same habitat!
```