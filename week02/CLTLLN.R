### Examination of the Central Limit Theerom and the Law of Large Numbers

# Sample a 6 sided iid die and plot distribution
die.rolls <- sample(x=1:6, size=100000, replace=TRUE)
hist(die.rolls, main = "6 Sided iid Dice", xlab= "Die Value")
mean(die.rolls)

# Collect 
CLT <- replicate(n=10000, mean(sample(x=1:6, size=100000, replace=TRUE)))
hist(CLT, breaks=50)
mean(CLT)
sd(CLT)
meanCLT<- mean(CLT)
sdCLT <- sd(CLT)

curve(((10/sqrt(2*3.14*sdCLT^2))*exp(-0.5*(x-meanCLT)^2/sdCLT^2)), from=3.48, to =3.52,
                  col="blue", add=TRUE)



#### Exercises
# 1.  Vary the number of die rolls (size = ) and plot the histogram for each.
#     Start with a small number like 20 and then add a zero (so 200 would be next) and
#     examine how the distribution takes on its true form as the number of samples
#     gets larger.

# 2.  Similarly to 1, changes the number of replicates (n = ) in the CLT calculations 
#     starting with a small number like 20 then add a zero (so 200 would be next) and
#     examine how the distribution of means takes on its true form of the Normal Distribution.

# 3.  Run the same analysis for a 4 sided die (x = 1:4) and convince yourself of the CLT and LLN.
#     Before your run the curve command in line 16, adjust the from = and to = values to 
#     be consistent with those on the histogram If the resources of your system permit, 
#     try a larger die, maybe 8 or 10 sided, but be prepared for this to take some time.

