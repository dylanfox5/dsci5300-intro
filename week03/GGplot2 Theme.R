### GGPLOT2 Worksheet ###
# The goal of this worksheet is to build in a stepwise fachion a graphic
# that includes all of the steps outlined in the Gammar of graphics

# Load ggplot and the data file DataSetHurricanes.csv
# Remember to save the data set to your working directory.
### install.packages("ggplot2")

library(ggplot2)
library(extrafont)
#font_import(prompt=FALSE)
#loadfonts(device="win")

hurricanes <- read.csv("DataSetHurricanes.csv")

# Examine the variables and types of data in the file by
# running the following command

str(hurricanes)

# Let's Incorporate and Aesthetic and add some geometery

ggplot(data=hurricanes, aes(x=Year, y=DamageMillions, color = WindMPH)) +
    geom_point()

# We may also want to add some  additional aesthetics by making the point
# sizes proportion to some variable. Run the following line:

ggplot(data=hurricanes, aes(x=Year, y=DamageMillions, 
                            size = DamageMillions, color = WindMPH)) +
    geom_point()


# Here is where ggplot gets very useful.  Having produced a basic graphic
# we can save that graphic as an Object and then add, as needed,
# various statistics, coordinates, facets, and themes.

# To save the graphic as an object, simply assign it a name.  Note that 
# the assignment does not include the geom_point command.  Its not that the
# the assignment can't include this command, its just that this may
# be something we wish to vary.

damage_plot <- ggplot(data=hurricanes, aes(x=Year, y=DamageMillions, 
                        size = DamageMillions, color = WindMPH))

# To reproduce the plot, we just add the command in as follows:

damage_plot + geom_point()

# We can also add other geometries with more plus signs.  Let's add a 
# line to the plot as follows

damage_plot + geom_point() + geom_line()

# Now that probably looks ugly as the line is very wide.  We can control 
# the size of the line as follows:

damage_plot + geom_point() + geom_line(size=0.5)

# Dealing with labels and titles can be accomplished by defining another 
# object and adding that object.  A label object uses the labs()
# command and can contain many items but we will only us a few.  
# Let's define a label object as follows:

label_object <- labs(title = "US Atlantic Hurricanes", 
                     subtitle = "1950 -2012", 
                     x = 'Year of Event', y= "Damage in $Millions", 
                     caption = "Source = Wikipedia")

# Let's add the label object to the graphic.  Remember we still need
# to include the geometries.

damage_plot + label_object + 
    geom_point() + geom_line(size = 0.5)

# On to the final object which is the Theme.  A theme contains information
# about the fonts and colors of the title, axes, etc. and information
# about the legend.  We make a theme using the theme() command.

### Prior to making a Theme, we need to install some fonts.
### To check to see shich fonts are installed, run windowFonts() at the
### console.  Typically, there are very few, sometimes only 3.
### To get more fonts, a lot more and truthfully you won't use most of 
### them, type the following at the consol.  !!! This may take some time.

############      install.packages("extrafont", dependencies = TRUE)
############      library(extrafont)
############      font_import(promt=FALSE)
############      loadfonts(device = "win")

### If you now run windowFonts() at the console, many, many more will 
### be available.

# The comand theme() will format the specified grpahic elements
# according to the instructions you supply regarding font, color, etc.
# Run the following to define the theme_object

theme_object <- theme (plot.title = element_text(color="Red", 
                                                 family = "Wide Latin"),
                       plot.subtitle = element_text(color="Red"), 
                       axis.title.x = element_text(color = "Red", 
                                                   face="bold"),
                       axis.title.y = element_text(color = 'Red', 
                                                   face="bold"),
                       plot.caption = element_text(color="Black", 
                                                   face = "italic"),
                       legend.background = element_rect(color="Gray"))

# As usual, to implement the theme in a graphic we have to add it on:

damage_plot + label_object + 
    geom_point() + geom_line(size = 0.5) + theme_object

### By using objects, it is easy to impliment the Grammar of Graphics.



# Prepare a graphic using the process of the Grammar of Graphics and the 
# object defintion approach outlined in the this worksheet.  Here are the
# detialed instructions:

# 1) Use the ecomonics data built into ggplot.  It can be accessed in the
# same way that the mpg data was accessed in class.

# 2) Start with the base plot of date on the x-axis and unemployment
# on the y-axis.  Choose any type of point geometry you wish.

# 3) To the base plot, add a smoothin function.

# 4) To the plot from #3, color the points accoding to another variable
# and size them according to yet another variable.

# 5) Save the plot in #4 (the approriate components anyway) as an object
# and remake the plot in #4 uisng your object.

# 6) Make a labels object and apply this to your plot object and include
# the appropriate geometries.  

# 7) Make a Theme and apply the theme to the grpahic generated in #6.  
# Note, that you may not use any colors of fonts that were used in the 
# worksheet theme.  Come up with some of your own.

# Turn in the code that for accomplihsed each of the steps 1 through 7
# Export your final figure and place it in a PowerPoint slide.  Turn that
# slide in as well.

library(extrafont)
#font_import(prompt=FALSE)
#loadfonts(device="win")