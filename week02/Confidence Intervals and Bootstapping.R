### Confidence Intervals and Bootstrapping 
### Lecture 02.05


#### The Population Standard Deviation is known

Annual.Salary <- c(44617, 7066, 17594, 2726, 1178, 18898, 5033, 37151, 4514, 4000)

######From the formula for the NORMAL at 90% Confidence
alpha <- 0.1
Area <- alpha/2
z1 <- qnorm(Area)
z2 <- qnorm(1-Area)

smean <- mean(Annual.Salary)
sigma <- 15000
MOE <- z2*sigma/(sqrt(length(Annual.Salary)))

# Lower Bound
LB <- smean-MOE
LB

# Upper Bound
UB <- smean + MOE
UB

### When the charateristics of the population are unknown

lizard <- c(6.2, 6.6, 7.1, 7.4, 7.6, 7.9, 8, 8.3, 8.4, 8.5, 8.6,
            + 8.8, 8.8, 9.1, 9.2, 9.4, 9.4, 9.7, 9.9, 10.2, 10.4, 10.8,
            + 11.3, 11.9)

t.test(lizard)  # Assumes a 95% confidence interval is required

t.test(lizard, conf.level = 0.9)

hist(lizard)
hist(Annual.Salary)

#### Bootstrap

bstrap <- c()
for (i in 1:1000){
    bstrap <- c(bstrap, mean(sample(Annual.Salary, 10, replace=TRUE)))
}

hist(bstrap, breaks=20)
#bstrap
quantile(bstrap, 0.05)
quantile(bstrap, 0.95)
