# An alternative approach to this problem would be to modify the Pet class to accept a colors parameter. If we did this, we wouldn't need to supply an initialize method for Cat.

# Why would we be able to omit the initialize method? 
# Because when a new Cat object is created, the next place Ruby will look for #initialize will be in the superclass Pet

# Would it be a good idea to modify Pet in this way? Why or why not? 
# Maybe if we want that to be an attribute for other subclasses of Pet, otherwise no since it's too specialized.

# How might you deal with some of the problems, if any, that might arise from modifying Pet?
# Depends on the problem but Modules come to mind in terms of maintaining functionality and also keeping modifying the Pet class to a minimum....