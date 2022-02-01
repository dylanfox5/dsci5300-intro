### intro to DS -- week 1 hw
df <- iris
df

### problem 6
str(df)
df[6,]
tail(df, 10)[1,]
sum(df$Petal.Length)

## a 
# there are 150 observations and 5 variables

## b
# the data types include num and Factor

## c
# the 6th observation can be found with the following command
df[6,]

## d
# the 10th observation from bottom can be found with the following command
tail(df, 10)[1,]

## e
# the sum of Petal.Length is 563.7

### problem 7
# the shortest Sepal.Width has a value of 2
# the longest Sepal.Width has a value of 4.4
max(df$Sepal.Width)
min(df$Sepal.Width)

### problem 8
# the IQR for Petal.Length is 3.5
quantile(df$Petal.Length, prob=c(.25, .5, .75))
5.10 - 1.60

### problem 9
# the following commands create a column called Petal.Area and insert it with the area
df$Petal.Area = df$Petal.Width * df$Petal.Length
df

### problem 10

## a
# the following commands create 4 vectors
names <- c('Dylan', 'David', 'Holly', 'Addie', 'Jax')
height <- c(72, 70, 67, 68, 69)
eye.color <- c('Green', 'Green', 'Hazel', 'Blue', 'Brown')
pets <- c(2, 1, 1, 3, 0)

## b
# the following commands create a dataframe
myPeople <- data.frame(names, height, eye.color, pets)
myPeople

## c
# the following commands finds the sum of pets and the range
sum(myPeople$pets)
range(myPeople$pets)

## d
# the following commands finds the mean & median of height
mean(myPeople$height)
median(myPeople$height)

## e
# the following command finds the number of levels of eye color
str(myPeople$eye.color)
