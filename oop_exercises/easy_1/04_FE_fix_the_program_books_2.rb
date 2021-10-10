# What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps?

# I prefer creating and initializing at the same time like in the previous exercise. We'd be able to add a layer of data protection by not having a setter method at all or if we did want to allow the object's data to be changed...we'd be able to be explicit about it by making the setter method private and creating a public method called 'correct_title' or 'correct_author'