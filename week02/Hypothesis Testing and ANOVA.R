### Hypothesis Testing and ANOVA
### Lecture 02.06

################ Comparing the means of two samples: the t-test ###########

# Do the two machines complete the task in the same time?

# Data (times) for Machine 1
machine1 <- c(24.58, 22.09, 23.70, 18.89, 22.02, 28.71, 24.44, 20.91, 23.83, 20.83)
 
#### Data (times) for Machine 2
machine2 <- c(21.61, 19.06, 20.72, 15.77, 19, 25.88, 21.48, 17.85, 20.86, 17.77)
 
boxplot(machine1, machine2)
 
# Assuming the variance of each machine sample is equal, the hypothesis test is:
 
t.test(machine1, machine2, var.equal = TRUE, alternative = "two.sided", mu=0)
 
# Assuming the variance of each machine sample is not equal, the hypothesis test is:
 
t.test(machine1, machine2, var.equal = FALSE, alternative = "two.sided", mu=0)
 

### How is the eqivalency of the variance determined:  The F-test

var.test(machine1, machine2, ratio=1, alternative = "two.sided")

###############################################################################
### ANOVA Analysis of three Methods used to measure the a property.  The question is 
### do the three Methods agree (H0:  mu1 = mu2 = mu3), or does one or more of the
### Methods provide a different value (HA).

method1.scores <- c(95, 91, 89, 90, 99, 88, 96, 98, 95)
method2.scores <- c(83, 89, 85, 89, 81, 89, 90, 82, 84, 80)
method3.scores <- c(68, 75, 79, 74, 75, 81, 73, 77)

boxplot(method1.scores, method2.scores, method3.scores)

## Place in a single vector

All.Scores <- c(method1.scores, method2.scores, method3.scores)

### Need to identify which scores belong to which methods
Method <- rep(c("method1", "method2", "method3"), 
            times = c(length(method1.scores), length(method2.scores), length(method3.scores)))

## Now combine all data into a data frame

Methoddf <- data.frame(Method, All.Scores)

analysis <- aov(All.Scores~Method, data=Methoddf)
summary(analysis)



