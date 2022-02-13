##### Regression 
library(ggplot2)
library(scatterplot3d)
library(MASS)
Aptitude <- c(45, 81, 65, 87, 68, 91, 77, 61, 55, 66, 82, 93, 76, 83, 61, 74)
Performance <- c(56, 74, 56, 81, 75, 84, 68, 52, 57, 82, 73, 90, 67, 78, 70, 66)
mean(Aptitude)

Consultants <- data.frame(Aptitude, Performance)
str(Consultants)
plot(Consultants, main = "Employee Performance as a Function of Aptitude")

#### Linear Statitistical Model  #####
Con.reg <- lm(Performance~Aptitude, data = Consultants)
summary(Con.reg)
abline(Con.reg)  #  Adding the best fit line

confint(Con.reg, level=0.90)  ### CI's at 90
confint(Con.reg, level=0.95)  ### CI's at 95

predict(Con.reg, data.frame(Aptitude=c(85, 62)))

ggplot(Consultants, aes(x=Aptitude, y=Performance))+
    geom_point() +
    geom_smooth(method=lm)


ggplot(Con.reg, aes(x=fitted(Con.reg), y=residuals(Con.reg)))+
    geom_point() +
    geom_hline(yintercept = 0, linetype="dashed")

####### Mutlivariable Regression

Personality <- c(9, 15, 11, 15, 14, 19, 12, 10, 9, 14, 15, 14, 16, 18, 15, 12)
Consultants["Personality"]=Personality
head(Consultants)

splot <- scatterplot3d(Consultants$Performance ~ Consultants$Aptitude 
                       + Consultants$Personality, type="h", pch=19)

Con.multreg <- lm(Performance~Aptitude + Personality, data = Consultants)
summary(Con.multreg)

splot$plane3d(Con.multreg, lty="dashed", col="Blue")

confint(Con.multreg, level=0.90)
confint(Con.multreg, level=0.95)

ggplot(Con.multreg, aes(x=fitted(Con.multreg), y=residuals(Con.multreg)))+
    geom_point() +
    geom_hline(yintercept = 0, linetype="dashed")


predict(Con.multreg, data.frame(Aptitude= c(85, 62), Personality=c(14, 17)))

##### Removing the Intercept

Con.multreg1 <- lm(Performance~Aptitude + Personality-1, data = Consultants)
summary(Con.multreg1)
splot <- scatterplot3d(Consultants$Performance ~ Consultants$Aptitude 
                       + Consultants$Personality, type="h", pch=19)
splot$plane3d(Con.multreg1, lty="dashed", col="Red")

predict(Con.multreg1, data.frame(Aptitude= c(85, 62), Personality=c(14, 17)))
confint(Con.multreg1, level=0.90)
confint(Con.multreg1, level=0.95)

ggplot(Con.multreg1, aes(x=fitted(Con.multreg1), y=residuals(Con.multreg1)))+
    geom_point() +
    geom_hline(yintercept = 0, linetype="dashed")


#### Regression with Categorical Variables #############

autos <- read.csv("autos.csv")
str(autos)
head(autos)
unique(autos$make)
model.cat <- lm(autos$price ~ autos$make)
coef(model.cat)

model1.cat <- lm(autos$price ~ autos$make-1)
coef(model1.cat)




##### Multivariable regression quantitative autos.csv

Fullmod <- lm(price ~ length + engine.size + horsepower + city.mpg, 
              data=autos)
coef(Fullmod)

FullmodwI <- lm(price ~ length + engine.size + horsepower + city.mpg - 1, 
                data=autos)
coef(FullmodwI)


################  Transforming Data
##### Log - Linear Fit ######

### Is a linear fit approriate?
plot(Cars93$Horsepower, Cars93$MPG.highway)

### Make a linear model
model <- lm(MPG.highway ~ Horsepower, data = Cars93)

#### Assertain the Coefficents (the betas)
coef(model)

### Visually Check the Fit
abline(model, col="red")

### Without an intercept: The intecept is set to 0.
model1 <- lm(MPG.highway ~ Horsepower-1, data = Cars93)
coef(model1)
abline(model1, col="blue")
predictdata <- data.frame(Horsepower = c(100,125,150,175,200))
predict(model, predictdata, interval = "confidence")

##Transforming data to log-linear form
plot(Cars93$MPG.highway ~ log(Cars93$Horsepower))
model.loghpmpg <- lm(MPG.highway ~ log(Horsepower), data=Cars93)
coef(model.loghpmpg)

ggplot(Cars93, aes(x=Horsepower, y=MPG.highway)) +
    geom_point() +
    geom_line(aes(y=model.loghpmpg$fitted.values), col="blue") +
    geom_line(aes(y=model$fitted.values), col="red")

###### A polynomial fit
ggplot(Boston, aes(x=rm, y=medv)) + 
    geom_point() +
    geom_smooth(method=lm, se=FALSE)

linfit <- lm(medv ~ rm, data = Boston)
summary(linfit)

rm2 <- Boston$rm^2

polyfit2 <- lm(medv ~ rm+rm2, data=Boston)
summary(polyfit2)

ggplot(Boston, aes(x=rm, y=medv)) +
    geom_point() +
    geom_line(aes(y=polyfit2$fitted.values), col="blue")

rm3 <- Boston$rm^3
polyfit3 <- lm(medv ~ rm+rm2+rm3, data=Boston)
summary(polyfit3)

ggplot(Boston, aes(x=rm, y=medv)) +
    geom_point() +
    geom_line(aes(y=polyfit3$fitted.values), col="green")


### Nonparametric Approach

modelLOESS <- loess(MPG.highway ~ Horsepower, data = Cars93)
summary(modelLOESS)

ggplot(Cars93, aes(x=Horsepower, y=MPG.highway)) +
    geom_point() +
    geom_smooth()


############# Train/Test 
a <- lm(Cars93$Width ~ Cars93$Wheelbase)
summary(a)

set.seed(1379)
TrainIDs <- sample(nrow(Cars93), 0.70*nrow(Cars93), replace=FALSE)

Train <- Cars93[TrainIDs,]
Test <-  Cars93[-TrainIDs,]

modTT <- lm(Width~Wheelbase, data=Train)
predict(modTT, Test)
p <- predict(modTT, Test)
b <- Test$Width
q <- data.frame(cbind(b, p)) 
diff <- (q$b-q$p)/q$b*100
hist(diff)

