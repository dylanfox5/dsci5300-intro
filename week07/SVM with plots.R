library(e1071)
library(dplyr)

df <- mtcars %>%
    select(mpg, hp, wt)
Eco <- ifelse(df$mpg > 22.75, "Economy", "Consuming") 
color <- ifelse(df$mpg > 22.75, "green", "red")
plot(df$hp, df$wt, col=color)

df2 <- data.frame(as.factor(Eco), df$wt, df$hp)
colnames(df2) <- c("Eco", "wt", "hp")
s <- svm(Eco ~ wt + hp, 
         data=df2, kernel = "polynomial")
summary(s)
s$index
df2[s$index,]
plot(s, data = df2)

df2 <- data.frame(as.factor(Eco), df$wt, df$hp)
s <- svm(as.factor.Eco. ~ df.wt + df.hp, data=df2, kernel = "sigmod")
summary(s)
plot(s, data = df2)


#### Support Vector Machines
model.svm <- svm(as.factor(class) ~ ., data=TrainSetR, kernel="linear" )
model.svm
summary(model.svm)
plot(model.svm, TrainSetR)
print(model.svm)
predict(model.svm, TestSetR)
table(TestSetR$class == predict(model.svm, TestSetR))/length(TestSetR$class)

##### Cost function

model.svm.cost <- svm(as.factor(class) ~ ., data=TrainSetR, kernel="linear", 
                      cost=0.25 )
table(TestSetR$class == predict(model.svm.cost, TestSetR))/length(TestSetR$class)

