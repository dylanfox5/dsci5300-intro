####Classification
library(e1071)

credit <- read.csv("credit.csv")
str(credit)
dfcredit <- data.frame(credit)

#### Training and Testing Sets
set.seed(1379)
trainR <- sample(nrow(credit), 0.75*nrow(credit), replace=FALSE)

TrainSetR <- credit[trainR,]
TestSetR <-  credit[-trainR,]

### NB Classifier

table(TrainSetR$housing)
table(TestSetR$housing)

table(TrainSetR$class, TrainSetR$housing)
table(TrainSetR$class)

model.nb <- naiveBayes(as.factor(class)~ ., TrainSetR)
model.nb

predict(model.nb, TestSetR)

### Check Accuracy
table(predict(model.nb, TestSetR) == TestSetR$class)/length(TestSetR$class)

### NB Classifier Jobs

model.nb.job <- naiveBayes(as.factor(job) ~ ., TrainSetR)
model.nb.job

predict(model.nb.job, TestSetR)

### Check Accuracy
table(predict(model.nb.job, TestSetR) == TestSetR$job)/length(TestSetR$job)

############################################################################
#### Support Vector Machines
model.svm <- svm(as.factor(class) ~ ., data=TrainSetR, kernel="linear" )
model.svm
summary(model.svm)

predict(model.svm, TestSetR)
table(TestSetR$class == predict(model.svm, TestSetR))/length(TestSetR$class)

##### Cost function

model.svm.cost <- svm(as.factor(class) ~ ., data=TrainSetR, kernel="polynomial", 
                      cost=0.25 )
table(TestSetR$class == predict(model.svm.cost, TestSetR))/length(TestSetR$class)


#### Kernel Function

model.svm.radial <- svm(as.factor(class) ~ ., data=TrainSetR, kernel='radial' )
model.svm.radial
summary(model.svm.radial)

predict(model.svm.radial, TestSetR)
table(TestSetR$class == predict(model.svm.radial, TestSetR))/length(TestSetR$class)

#############################################################################
#### Nonparametric Classification
##### K Nearest Neighbors
library(kknn)

model.kknn<- kknn(as.factor(class) ~ ., TrainSetR, TestSetR, 
                  kernel="rectangular" )
model.kknn
summary(model.kknn)
fit <- fitted(model.kknn)
table(TestSetR$class, fit)


