### intro to DS -- week 4 hw
library(ggplot2)
library(scatterplot3d)
library(MASS)

## problem 1
# After reading the article about Kobe Bryant, I am not 100% sure if he should've shared the
# ball more. While the article points out that the Lakers win when Kobe shoots less,
# Kobe is most likely shooting more when the Lakers are losing BECAUSE the Lakers are losing.
# Therefore, this changes what we know.

# If the Lakers are losing, the team probably wants Kobe to shoot. He's a good player.
# But, he's only one player. Meaning that if the Lakers are losing and Kobe starts to shoot
# more, there's still a good chance that the Lakers will lose and Kobe's attempted shots
# will increase (thus, his miss % too). 

# Overall, I believe I lean towards the side of Kobe should've shared the ball a bit more.
# The data shows that there are more efficient shooters on the team. If you couple that
# with Kobe's ability to clutch games, some of those Ls could turn into Ws. Therefore,
# Kobe's attempt % would slightly decrease and the point differential would increase.  

## problem 2
df <- read.csv("/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week05/BBall3pts.csv")
df

lm <- lm(formula = df$Percent3pMade ~ df$Percent3pAttempted)
lm
summary(lm)
plot(df$Percent3pAttempted, df$Percent3pMade)
abline(lm)
# After conducting a linear fit of the data, I believe that we could conduct a more accurate model.
# This is because the does not appear to be linear. After plotting the data and the linear model together,
# there are quite a few data points that would not be reflected by the model. There may be a few outliers.
# I believe that more data is needed to concretely define a good model for this study. This would allow us
# to be more confident in our approach.

## problem 3
df <- read.csv("/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week05/Proddata.csv")
df

str(df)
lm1 <- lm(formula = df$RunTime ~ df$RunSize)
lm1
summary(lm1)
plot(df$RunSize, df$RunTime)
abline(lm1)

ggplot(df, aes(x=RunSize, y=RunTime))+
  geom_point() +
  geom_smooth(method=lm)

ggplot(df, aes(x=fitted(lm1), y=residuals(lm1)))+
  geom_point() +
  geom_hline(yintercept = 0, linetype="dashed")

# After some analysis, this relationship seems pretty close to being linear. As the RunSize increases,
# the RunTime will increase as well, and vice versa. We can be fairly confident in our model when
# we visualize the scatter plot and line of best fit. One way to decrease the mean production time 
# for a given run would be to lower the RunSize. If lowering the RunSize isn't an option, we must
# look at other variables that aren't available to us currently.

## problem 4
df <- read.csv("/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week05/autos.csv")
str(df)
lm <- lm(formula = df$price ~ df$stroke + df$compression.ratio + df$height + df$length)
summary(lm)
confint(lm, level=0.95)

# To complete this multivariable regression, I chose to use the variables stroke, compression ratio, height, and length.
# I chose these variables from the start because I felt that they would have the most impact on car price
# out of all the possible numeric dimensions. After completing this analysis, I see that compression ratio has
# a t value closest to 0 out of all the variables. This leads me to believe that compression ratio and car price
# are relatively similar. Therefore, compression ratio should have the largest impact on car price out of the 4
# possible options. 

## problem 5
df <- read.csv("/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week05/autos.csv")

# a
lm <- lm(formula = df$curb.weight ~ df$length)
plot(df$length, df$curb.weight)
abline(lm)
summary(lm)

# b
plot(df$curb.weight ~ log(df$length))
loglm <- lm(df$curb.weight ~ log(df$length))
ggplot(df, aes(x=length, y=curb.weight)) +
  geom_point() +
  geom_line(aes(y=loglm$fitted.values), col="blue")
summary(loglm)

# c
loess <- loess(curb.weight ~ length, data = df)
summary(loess)

ggplot(df, aes(x=length, y=curb.weight)) +
  geom_point() +
  geom_smooth()

# After running a linear, log-linear, and a loess model for this dataset, we can say that the loess model appears
# to be the best fit. Each residual standard error for the models were close, but loess has the smallest value.
# I believe this is because a loess model is weighted by the values closest to one another. This means that data 
# points farther away have less of an effect on the model. In turn, this gives us a line of best fit with a lower
# residual standard error.

## problem 6
df <- Boston
str(Boston)

# a
plot(df$age, df$crim)

# The plot of the data is very skewed to the positive side. The crime values are very small across most of the age values.
# Once age reaches 70-100, we start to see higher crime values

# b
ggplot(Boston, aes(x=age, y=log(crim))) + 
  geom_point() +
  geom_smooth(method=lm, se=FALSE)

linfit <- lm(log(crim) ~ age, data = Boston)
summary(linfit)

ggplot(Boston, aes(x=age, y=log(crim))) +
  geom_point() +
  geom_line(aes(y=linfit$fitted.values), col="blue")

age2 <- Boston$age^2

polyfit2 <- lm(log(crim) ~ age+age2, data=Boston)
summary(polyfit2)

ggplot(Boston, aes(x=age, y=log(crim))) +
  geom_point() +
  geom_line(aes(y=polyfit2$fitted.values), col="blue")

# After plotting and reading about what the variables mean, this data makes sense. As Age increases, crime increases as well.
# This is telling us that crime is more prevalent in older units/parts of town. When we compare this with what we know,
# this is makes sense.

## problem 7
df <- Boston

set.seed(59)
TrainIDs <- sample(nrow(df), 0.65*nrow(df), replace=FALSE)

train <- df[TrainIDs,]
test <-  df[-TrainIDs,]

model <- lm(medv ~ rm + crim + tax + age, data=train)
p <- predict(model, test)
b <- test$medv
q <- data.frame(cbind(b, p)) 
diff <- (q$b-q$p)/q$b*100
hist(diff, breaks=20)

# After training and testing a multivariable linear model on the Boston data, we can see
# that our models is mostly errors in the range of -25% to 25%. Our histogram shows this 
# is where the bulk of our data sits. At a first glance, this doesn't seem too terribly
# awful. In a real life situation, this would give us a decent starting point to start
# building better models going forward. We are able to derive that there is some 
# importance in the variables we used (rooms, crime, tax, age). We can use this information
# to build better models and lower that range of error.

## problem 8
df <- read.csv("/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/final-project/cityx.csv")
str(df)

set.seed(60)
trainIDs <- sample(nrow(df), 0.65*nrow(df), replace=FALSE)

train <- df[TrainIDs,]
test <-  df[-TrainIDs,]

reg.model <- lm(CANCER_CrudePrev ~ ACCESS2_CrudePrev + CHECKUP_CrudePrev + PHLTH_CrudePrev, data=train)

reg.p <- predict(reg.model, test)
reg.b <- test$CANCER_CrudePrev
reg.q <- data.frame(cbind(reg.b, reg.p)) 
diff <- (reg.q$reg.b-reg.q$reg.p)/reg.q$reg.b*100
hist(diff, breaks=20)

loess.model <- loess(CANCER_CrudePrev ~ ACCESS2_CrudePrev + CHECKUP_CrudePrev + PHLTH_CrudePrev, data=train)

loess.p <- predict(loess.model, test)
loess.b <- test$CANCER_CrudePrev
loess.q <- data.frame(cbind(loess.b, loess.p)) 
loess.diff <- (loess.q$loess.b-loess.q$loess.p)/loess.q$loess.b*100
hist(loess.diff, breaks=30)

# I decided to run a multivariable linear regression and a nonparametric model. The multivariable
# linear regression model provided okay results. Since we are working with a more complex
# dataset, it provided only okay results. Most of our data was off somewhere between -10% and
# 10%. While this isn't horrible, we can do better. In addition, this model provided quite a few
# observations that were off by a rather large margin.
#
# The nonparametric model provided a bit cleaner results. We still have some observations
# that resulted in a rather large margin of error, but most of our data was closer to 
# the 0 mark. After plotting the histogram, we can see that more of our observations were
# a bit more accurate. This leads me to believe that using this model may be better
# going forward. 