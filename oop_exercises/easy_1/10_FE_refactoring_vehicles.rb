# Would it make sense to define a wheels method in Vehicle even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?
# At the moment since all our subclasses have a different number of wheels and I can't think of a behavior we'd want to create. Although since the number of wheels won't change, this looks like a great use case for constants..