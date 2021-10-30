# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
# What is the result of the following:
trip = RoadTrip.new
trip.predict_the_future #=> "You will " + a randomly chosen string from RoadTrip#choices
# we're calling #predict_the_future on a RoadTrip object which we have access to thanks to inheritance. When Ruby calls #choices (from inside #predict_the_future), it's going to look for it in the current object class which is RoadTrip. 