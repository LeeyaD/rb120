# Consider the following class:
class Machine
  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def switch_getter
    self.switch
  end
  
  private
  
  attr_writer :switch
  attr_accessor :switch # FE

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Modify this class so both flip_switch and the setter method switch= are private methods.


# FURTHER EXPLORATION
# Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.