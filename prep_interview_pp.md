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

# ------------------------------------------------------------------
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

# ================================================================
```ruby
#describe what the code below outputs and why from Joseph Ochoa

module Attackable
  def attack
    "attacks!"
  end
end

class Characters
  attr_accessor :name, :characters 
  
  def initialize(name) 
    #
    self.name 
    @characters = [] 
  end
  
  def display
    name
  end
  
  protected 
  attr_reader :name
  attr_writer :name
end

class Monster < Characters
  include Attackable
  
  def initialize(name)
    super
  end
end

class Barbarian < Characters
  def ==(other)
    if(super.self == super.self) # 
      super.self == super.self
    end
  end
end

conan = Barbarian.new('barb') 
rob = Monster.new('monst')
conan.characters << rob
p conan.display
```
# ================================================================

# Without adding any methods below, implement a solution; originally by Natalie Thompson, 
# this version by Oscar Cortes
```ruby
class ClassA 
  attr_reader :field1, :field2
  
  def initialize(num)
    @field1 = "xyz"
    @field2 = num
  end
end

class ClassB 
  attr_reader :field1

  def initialize
    @field1 = "abc"
  end
end

obj1 = ClassA.new(50)
obj2 = ClassA.new(25)
obj3 = ClassB.new

p obj1 > obj2
p obj2 > obj3
```
# ========================================================================
```ruby
class BenjaminButton 
  
  def initialize
  end
  
  def get_older
  end
  
  def look_younger
  end
  
  def die
  end
end

class BenjaminButton
end

benjamin = BenjaminButton.new
p benjamin.actual_age # => 0
p benjamin.appearance_age # => 100

benjamin.actual_age = 1
p benjamin.actual_age

benjamin.get_older
p benjamin.actual_age # => 2
p benjamin.appearance_age # => 99

benjamin.die
p benjamin.actual_age # => 100
p benjamin.appearance_age # => 0
```
# ========================================================================

# Originally by Natalie Thompson, this version by James Wilson
```ruby
class Wizard
  attr_reader :name, :hitpoints
  
  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end  
  
  def fireball
    "casts Fireball for 500 damage!"
  end
  
end

class Summoner < Wizard
  attr_reader :souls
  
  def initialize(name, hitpoints)
    # only add one line here
    @souls = []
  end
  
  def soul_steal(character)
    @souls << character
  end
end

gandolf = Summoner.new("Gandolf", 100)
p gandolf.name # => "Gandolf"

valdimar = Wizard.new("Valdimar", 200)
p valdimar.fireball #=> "casts fireball for 500 damage!"

p gandolf.hitpoints #=> 100

p gandolf.soul_steal(valdimar) #=> [#<Wizard:0x000055d782470810 @name="Valdimar", @hitpoints=200>]

p gandolf.souls[0].fireball #=> "casts fireball for 500 damage!"
```

```ruby
module Rammable
  def ram(item)
    self.class.ram(item)
  end
end

class Farm

  def self.ram(item)
    "I ram #{item}s all the time."
  end
end

class Goat < Farm
  include Rammable

  def ram(item)
    puts super + " I am ramming a #{item}."
  end
end

class Cow < Farm
  def ram
    puts "I be mad!"
  end
end

class Pig < Farm
  def ram(item)
    puts "Destroy the #{item}!"
  end
end

class Kid < Goat
  def play(item)
    puts "I like to play! #{ram(item)}"
  end
end

hippy = Kid.new
hippy.play("ball") #What will this output?
```