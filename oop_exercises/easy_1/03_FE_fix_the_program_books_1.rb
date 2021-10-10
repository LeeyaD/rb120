# What are the differences between attr_reader, attr_writer, and attr_accessor? 
#  attr_writer, creates an instance var & corresponding setter method, only allowing us to change our object's state 
#  attr_reader, creates an instance var & corresponding getter method, only allowing us to retrieve our object's state
#  attr_accessor, creates an instance var & corresponding setter & getter methods, allowing us to do both change & retrieve our object's state

# Why did we use attr_reader instead of one of the other two? Would it be okay to use one of the others? Why or why not?
# We used 'attr_reader' because it was all the functionality we needed. It would be okay to use the other two (writer so long as we still had the reader) but we didn't need to change the state of our object and using the other two would have allowed that.

# Instead of attr_reader, suppose you had added the following methods to this class:
def title
  @title
end

def author
  @author
end
# Would this change the behavior of the class in any way? If so, how? If not, why not? Can you think of any advantages of this code?
# No these methods do the extact same thing as attr_reader. An advantage would be if we wanted to format the data we retrieved but that can also be achieved more safely thru the use of a private method...
