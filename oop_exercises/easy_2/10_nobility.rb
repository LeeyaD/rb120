# Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.
module Walkable
  def walk
    "#{full_name} #{gait} forward"
  end

  def full_name # solution was 4 #to_s methods, one in each class. This way limits future functionality
    self.class == Noble ? "#{title} #{name}" : "#{name}"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :name, :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  private

  def gait
    "struts"
  end
end
# We need a new class Noble that shows the title and name when walk is called:
byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other purposes that we aren't showing here.
byron.name
# => "Byron"
byron.title
# => "Lord"