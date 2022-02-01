### Introduction to ggplot2

### Run install.packages("ggplot2") to get ggplot2 on your system
### Run install.packages("directlabels") so that lables can be added 
### directly to the plots

library(ggplot2)
library(directlabels)

# mpg is a data set that come with the ggplot2 install,
str(mpg)

ggplot(mpg, aes(x=displ, y=hwy))

### we did not add points to the plot

ggplot(mpg, aes(x=displ, y=hwy))+
    geom_point()

### Adding facets which split plots by a specified variable
ggplot(mpg, aes(x=displ, y=hwy))+
    geom_point() +
    facet_wrap(~class)

### We can also add a smooting function to the data
ggplot(mpg, aes(x=displ, y=hwy))+
    geom_point() +
    geom_smooth()

### Complete a linear smoothing
ggplot(mpg, aes(x=displ, y=hwy))+
    geom_point() +
    geom_smooth(method = 'lm')

### Adding labels to the various classes on the plot
ggplot(mpg, aes(x=displ, y=hwy, color=class))+
    geom_point(show.legend = FALSE) +
    directlabels::geom_dl(aes(label = class), method="smart.grid")

######################### Avoiding Overplotting
ggplot(mpg, aes(x=drv, y=hwy))+
    geom_point()

ggplot(mpg, aes(x=drv, y=hwy))+
    geom_jitter()

ggplot(mpg, aes(x=drv, y=hwy))+
    geom_boxplot()

ggplot(mpg, aes(x=drv, y=hwy))+
    geom_violin()

ggplot(mpg, aes(x=drv, y=hwy, fill = drv))+
    geom_violin()

### Histograms
ggplot(mpg, aes(hwy)) +
    geom_histogram()

ggplot(mpg, aes(hwy)) +
    geom_histogram(bins = 10)

ggplot(mpg, aes(hwy)) +
    geom_freqpoly()

ggplot(mpg, aes(hwy)) +
    geom_freqpoly(binwidth=1)

ggplot(mpg, aes(displ, color = drv)) +
    geom_freqpoly(binwidth = 0.5)


ggplot(mpg, aes(displ, fill = drv)) +
    geom_histogram(binwidth = 0.5) +
    facet_wrap(~drv, ncol = 1 )


##### The fast but lower quality version qplot()

qplot(displ, hwy, data = mpg)
qplot(displ, data = mpg)

qplot(displ, hwy, data = mpg, color = "blue")
qplot(displ, hwy, data = mpg, color = I("blue"))
