### Descriptive Statistics and Distibution Shapes
### Lecture Video 02 04

### The vector lizard contains the head to tip of tail lengths, in inches, of
### one species of lizard.

lizard <- c(6.2, 6.6, 7.1, 7.4, 7.6, 7.9, 8, 8.3, 8.4, 8.5, 8.6,
            + 8.8, 8.8, 9.1, 9.2, 9.4, 9.4, 9.7, 9.9, 10.2, 10.4, 10.8,
            + 11.3, 11.9)

n <- length(lizard)  # nmuber of samples
n

### Measures of Center
meanlenght <- mean(lizard)
meanlenght
medianlength <- median(lizard)
medianlength

### Exterme values
maxlength <- max(lizard)
maxlength
minlength <- min(lizard)
minlength

### Summary with Quartiles
summary(lizard)


### Measures of Spread
sdlizard <- sd(lizard)
sdlizard
rangelizard <- range(lizard)
rangelizard
IQRlizard <- IQR(lizard, 7) #### Note that this is the interquantile range which
# when set to 7, gives the Interquartile range.
IQRlizard

#### To calcualte skewness and kutosis we need to load a package of functions
#### Loading a package requires the install.packages() command.
#### Once installed, you have the package, to use the package you need to run the 
#### code line library().  This must be executed each time to run an R script.
#### The package that contians the skewnees and kurtois function is e1071

install.packages(e1071) #run this line once to install the package on your system
library(e1071)  #run this line once at the begining of you coding session

hist(lizard)
skewness(lizard)
kurtosis(lizard)

### Exercises
# 1.  Consider the sample of GPA's from first year students.
# 2.61, 3.11, 4.00, 1.97, 2.23, 3.22, 3.55, 3.87, 2.21, 2.94, 2.68, 2.66
# Calculate two measures of center and min and max values.
# Descibe the skewness and kurtosis of distribution.

