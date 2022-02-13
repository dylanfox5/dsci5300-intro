### Simple Decision Tree: Regression
library(rpart)
autos <- read.csv("autos.csv")


fit <- rpart(price ~ highway.mpg + city.mpg + wheel.base, data = autos)
fit

par(mar=c(2 ,2, 2, 2))
plot(fit, uniform = TRUE)
text(fit, digits=6)

par(mar=c(1 ,1, 1, 1))
fit.prune = prune(fit,cp=0.1)
plot(fit.prune, uniform = TRUE)
text(fit.prune, digits=5)

par(mar=c(5.1, 4.1, 4.1, 2.1))
