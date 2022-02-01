### intro to DS -- week 2 hw

### problem 4
df <- state.area
str(df)

mean(df) # 72367.98
median(df) # 56222
max(df) # 589757
min(df) # 1214
range(df) # 1214 589757
sd(df) # 88278.01

library(e1071)
hist(df)
skewness(df) # 4.192424
kurtosis(df) # 21.1694

### problem 5
bstrap <- c()
for (i in 1:1000){
  bstrap <- c(bstrap, mean(sample(state.area, 10, replace=TRUE)))
}

hist(bstrap, breaks=20)
quantile(bstrap, 0.05)
quantile(bstrap, 0.95)
quantile(bstrap, 0.10) # 45009.64
quantile(bstrap, 0.90) # 111223


### problem 6
gpa <- c(2.01, 3.96, 1.92, 2.71, 3.03, 3.15, 3.22, 3.17, 3.99, 2.63, 2.51, 2.63)

t.test(gpa)  # Assumes a 95% confidence interval is required

# t.test(lizard, conf.level = 0.9)

hist(gpa)

### problem 8
ath1 <- c(9.79, 10.11, 9.99, 10.08, 10.22)
ath2 <- c(9.61, 10.31, 10.02, 10.38, 9.81)

t.test(ath1, ath2, var.equal = TRUE, alternative = "two.sided", mu=0)

### problem 10
die.rolls <- sample(x=1:5, size=10000, replace=TRUE)
hist(die.rolls, main = "5 Sided iid Dice", xlab= "Die Value")
mean(die.rolls)

skewness(die.rolls) # -0.022
kurtosis(die.rolls) # -1.286