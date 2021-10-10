# Consider the following class definition:
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
# There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?
# We can implement encapsulation by making our instance variable 'database_handle' & it's corresponding setter & getter methods private
# ANSWER: Remove attr_accessor all together (don't just make it private)!