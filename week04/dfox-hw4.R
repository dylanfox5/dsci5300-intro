### intro to DS -- week 4 hw

## problem 1
a <- matrix(c(1, 4, 3, -1, 2, 1), ncol=3)
aT <- t(a)
aT

## problem 2
b <- c(6, 2, 5)
c <- a %*% b
c

## problem 3
A <- matrix(c(2, 5, -2, 1, 3, 0, 4, -3, 2), ncol=3)
B <- matrix(c(-1, 0, -2, 1, 5, 2, 3, -2, 1), ncol=3)
A+B
A %*% B
B %*% A

## problem 4
detA <- det(A)
detA

## problem 5
C <- matrix(c(35, -90, 25, 6, -15, 3, -7, 21, -7), ncol=3)
D <- c(15, -40, 11)
ans <- solve(C) %*% D
ans

## problem 6
dose <- c(0.10, 0.20, 0.25, 0.30, 0.45, 0.55, 0.70, 0.90, 1.00)
length <- c(1.01, 1.73, 1.82, 2.01, 3.12, 3.78, 6.38, 7.91, 9.12)
# a
plot(dose, length, main="Effect of Vitamin C on Tooth Growth")
# b
lm <- lm(formula = length ~ dose)
lm
abline(lm)
# c
summary(lm) # p-value: 7.829e-07
# d
lm
predict(lm) # a dose of 0.65 would have a tooth growth of ~5.2

## problem 7
cityx <- read.csv("/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/final-project/cityx.csv")
library(dplyr)
head(cityx)
str(cityx)
summary(cityx)
na_count <- sapply(cityx, function(y) sum(length(which(is.na(y)))))
na_count
cor(cityx)

# What does each observation represent? i.e., a specific location in city x?
# What do the metrics tell us? Are the metrics percentages or the number of individuals with that illness?
# How do we measure how drastic each illness is? 
# Which illnesses have low numbers? (low priority)
# Which illnesses have high numbers? (potential high priority)

# After running a few commands, we can start to gather some information about the data.
# The dataset contains 28 variables and there are 198 observations. At first glance, it is 
# difficult to tell what each observation represents. In addition, there are a handful of
# variables that are difficult to determine what illness they specifically represent.
# Besides the Population2010 variable (integer), all variables are numerical data types. 
# We can quickly see a high level overview of the distribution of each variable by running
# the summary() command. We can also determine that there are only 2 NA values in the dataset,
# under the COREW_CrudePrev variable. Finally, we can run the cor() method to see a high level 
# overview of the correlations between each variable. This lets us quickly see which illnesses
# are highly/lowly correlated. Overall, I would start with the questions above to gain a better
# understanding of the data we are working with. This will allow me to under the data more and
# lay out the next steps in answering the mayor's questions.