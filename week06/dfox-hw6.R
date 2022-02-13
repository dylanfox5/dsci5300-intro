### intro to DS -- week 6 hw
library(ggplot2)
library(UsingR)
library(dplyr)

## problem 1
df <- mtcars
lm <- lm(formula = wt ~ hp + cyl + disp, data = df)

hp <- c(110, 170, 175)
cyl <- c(4, 8, 6)
disp <- c(108, 400, 145)
newdf <- data.frame(hp, cyl, disp)
newdf
# run line below for answer
predict(lm, newdata = newdf, interval= "confidence")

## problem 2

# Even if we know the exact values of the betas, there will still be some variance in the 
# predicted value. This is because of how the prediction is calculated. Each parameter,
# or variable, introduces a degree of variance. Even if we know the exact betas, these
# other parameters are introducing variance that we have to account for.

## problem 3
dbinom(12, 15, 0.58) * 100 # there is a 4.88% chance that 12 out of the 15 arrive on time

## problem 4
binom.test(9, 20, p=0.5, alternative=c("two.sided")) # p-value: 0.8238

## problem 5
sliders <- 15
curves <- 31
fast <- 40
total <- sliders + curves + fast
pNCurves <- (sliders+fast)/total
pCurves <- (curves)/total
oddsOfCurves <- pCurves/pNCurves
oddsOfCurves*100
# the odds are 31 to 55 (31:55) or 56.36%
pSliders <- sliders/total
pSliders*100
# probablity of slider next is 17.44%

## problem 6
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"
data <- read.csv(url, header=FALSE)
set.seed(61)
colnames(data) <- c(
  "age",
  "sex",# 0 = female, 1 = male
  "cp", # chest pain
  # 1 = typical angina,
  # 2 = atypical angina,
  # 3 = non-anginal pain,
  # 4 = asymptomatic
  "trestbps", # resting blood pressure (in mm Hg)
  "chol", # serum cholestoral in mg/dl
  "fbs",  # fasting blood sugar if less than 120 mg/dl, 1 = TRUE, 0 = FALSE
  "restecg", # resting electrocardiographic results
  # 1 = normal
  # 2 = having ST-T wave abnormality
  # 3 = showing probable or definite left ventricular hypertrophy
  "thalach", # maximum heart rate achieved
  "exang",   # exercise induced angina, 1 = yes, 0 = no
  "oldpeak", # ST depression induced by exercise relative to rest
  "slope", # the slope of the peak exercise ST segment
  # 1 = upsloping
  # 2 = flat
  # 3 = downsloping
  "ca", # number of major vessels (0-3) colored by fluoroscopy
  "thal", # this is short of thalium heart scan
  # 3 = normal (no cold spots)
  # 6 = fixed defect (cold spots during rest and exercise)
  # 7 = reversible defect (when cold spots only appear during exercise)
  "hd" # (the predicted attribute) - diagnosis of heart disease
  # 0 if less than or equal to 50% diameter narrowing
  # 1 if greater than 50% diameter narrowing
)
data[data == "?"] <- NA

data[data$sex == 0,]$sex <- "F"
data[data$sex == 1,]$sex <- "M"
data$sex <- as.factor(data$sex)
data$cp <- as.factor(data$cp)
data$fbs <- as.factor(data$fbs)
data$restecg <- as.factor(data$restecg)
data$exang <- as.factor(data$exang)
data$slope <- as.factor(data$slope)

data$ca <- as.integer(data$ca)
data$ca <- as.factor(data$ca)

data$thal <- as.integer(data$thal)
data$thal <- as.factor(data$thal)

data$hd <- ifelse(test=data$hd == 0, yes="Healthy", no="Unhealthy")
data$hd <- as.factor(data$hd)

nrow(data[is.na(data$ca) | is.na(data$thal),])
data[is.na(data$ca) | is.na(data$thal),]

nrow(data)
data <- data[!(is.na(data$ca) | is.na(data$thal)),]
nrow(data)

ids <- sample(nrow(data), 0.70*nrow(data), replace=FALSE)
train <- data[ids,]
test <-  data[-ids,]

# a
str(data)
log.train <- glm(hd ~ ., data=train, family="binomial")
summary(log.train) # AIC = 165.5

# b
pH <- predict(log.train, test, type = 'response')
labelsH <- ifelse(pH> 0.5, 'Unhealthy', 'Healthy')

table(labelsH == test$hd)/length(test$hd) # 83.33% accurate

log.train1 <- glm(hd ~ sex, data=train, family="binomial")
summary(log.train1) # AIC = 274.23

pH <- predict(log.train1, test, type = 'response')
labelsH <- ifelse(pH> 0.5, 'Unhealthy', 'Healthy')

table(labelsH == test$hd)/length(test$hd) # 62.22% accurate

## problem 7
df <- mtcars
log <- glm(vs ~ hp, data=df, family="binomial")
summary(log)

# a
# Looking at a summary of our model, we see that horsepower has a beta of -0.06856. 
# This leads us to believe that horsepower has a negative impact on engine configuration,
# but it is a very small impact. Due to how small the beta is, we must question whether
# it is statistically significant or not.

# b & c
df$vs <- ifelse(test=df$vs == 0, yes="V-Shaped", no="Straight")
df$vs <- as.factor(df$vs)

xtabs(~ vs + hp, data=df)

predicted.data <- data.frame(
  probability.of.vs=log$fitted.values,
  hp=df$hp)
ggplot(data=predicted.data, aes(x=hp, y=probability.of.vs)) +
  geom_point(aes(color=hp), size=5) +
  xlab("hp") +
  ylab("Predicted probability of getting vs")

xtabs(~ probability.of.vs + hp, data=predicted.data)

## problem 8
1 - pchisq((log$null.deviance - log$deviance), df=1)
# the betas from problem 7 are statistically significant. The above command will 
# compute the p-value for our logistic model. It returns a value of 2.01098e-07
# which is less than 0.05. Therefore, our betas are significant.

## problem 9
library(rpart)
df <- read.csv('/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week06/Titanic.csv')
df$PClass <- as.factor(df$PClass)
df$Sex <- as.factor(df$Sex)
str(df)

fit <- rpart(Survived ~ PClass + Sex, data=df)
fit

par(mar=c(2 ,2, 2, 2))
plot(fit, uniform = TRUE)
text(fit, digits=6)

par(mar=c(1 ,1, 1, 1))
fit.prune = prune(fit,cp=0.1)
plot(fit.prune, uniform = TRUE)
text(fit.prune, digits=5)

# After completing this decision tree, it makes a lot of sense when we compare it 
# with what we know about the Titanic. Most men did not survive; women and children
# were prioritized. In addition, it was more likely for passengers of a higher class
# to survive, rather than a lower class. Combining these two notions, we know that
# women and children of higher classes were the most likely to survive. Our plot illustrates
# that. If you're a male, your chances of survival drop drastically from the start. The women
# of higher classes are more likely to survive. 
