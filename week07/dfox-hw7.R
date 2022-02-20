### intro to DS -- week 7 hw
library(e1071)
library(stats)
library(ggplot2)
library(factoextra)
library(corrplot)
library(cluster)

## problem 1
df <- iris

set.seed(1500)
trainIDs <- sample(nrow(df), 0.7*nrow(df), replace=FALSE)
train <- df[trainIDs,]
test <-  df[-trainIDs,]

# A
model.nb <- naiveBayes(Species ~ Sepal.Length + Sepal.Width, train)
model.nb
table(predict(model.nb, test) == test$Species)/length(test$Species)

# FALSE      TRUE 
# 0.1777778 0.8222222 

# B
model.nb1 <- naiveBayes(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, train)
model.nb1
table(predict(model.nb1, test) == test$Species)/length(test$Species)

# FALSE       TRUE 
# 0.04444444 0.95555556

## problem 2
svm.linear <- svm(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, train, kernel='linear')
svm.linear
summary(svm.linear)

table(test$Species == predict(svm.linear, test))/length(test$Species)

# FALSE       TRUE 
# 0.08888889 0.91111111 
# The SVM linear model is just slightly less accurate than the NB model we used in part B in question 1. 

## problem 3
svm.poly <- svm(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, train, kernel='polynomial')
svm.poly
summary(svm.poly)

table(test$Species == predict(svm.poly, test))/length(test$Species)

# FALSE      TRUE 
# 0.1555556 0.8444444

svm.radial <- svm(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, train, kernel='radial')
svm.radial
summary(svm.radial)

table(test$Species == predict(svm.radial, test))/length(test$Species)

# FALSE       TRUE 
# 0.08888889 0.91111111 
# The polynomial SVM dropped in accuracy and is most similar to the very first NB method in part A question 1.
# The radial SVM was similar to the linear SVM and NB model in part B in question 1.

## problem 4
df <- scale(iris[,-5])
set.seed(1200)

km <- kmeans(df, 3, nstart = 25)

fviz_cluster(km, data=df)
# Dim1 = 73%
# Dim2 = 22.9%

fviz_cluster(km, data = df,
             palette=c("red", "blue", "black", "darkgreen"),
             ellipse.type = "euclid",
             star.plot = T,
             repel = T,
             ggtheme = theme())
# Dim1 = 73%
# Dim2 = 22.9%

## problem 5

km2 <- kmeans(df, 2, nstart = 25) # 62.9%
km3 <- kmeans(df, 3, nstart = 25) # 76.7%
km4 <- kmeans(df, 4, nstart = 25) # 81.0%
# This is interesting. Our model k=4 has the highest percentage, but the dataset
# has only 3 classifications for Species. The algorithm must believe that 
# clustering as 4 is most optimal.

## problem 6
df <- mtcars
res.agnes <- agnes(x=df, stand = TRUE, 
                   metric = "euclidean", method="ward")

res.diana <- diana(x=df, stand = TRUE, 
                   metric = "euclidean")

fviz_dend(res.agnes, cex=0.6, k=4)
fviz_dend(res.diana, cex=0.6, k=4)

# The major differences between these two dendrograms is the size of each 
# cluster. For example, the AGNES model puts a smaller amount of the cars in 
# cluster 1 than the DIANA model does. The same is true for cluster 4 for each
# model. The DIANA model cluster 4 is much smaller in size than it is in the 
# AGNES model.

# problem 7

# The cars most similar to the Mercedes 450 SL are the Mercedes 450SLC or the 
# Mercedes 450SE. If you're looking to switch from the Mercedes to a different
# brand, you should look at the Dodge Challenger, Pontiac Firebird, or the 
# AMC Javelin.