library(e1071)
library(stats)
library(ggplot2)
library(factoextra)
library(corrplot)
library(cluster)
library(dplyr)
library(rpart)

####################################################
## final project                                  ##
## - general statement regarding health of cityX  ## 
## - predict drastic illnesses                    ##
####################################################

df <- read.csv('/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/final-project/cityX.csv')

str(df)
summary(df)

# check for NAs
na_count <- sapply(df, function(y) sum(length(which(is.na(y)))))
na_count

# remove NAs => replace with mean
for (i in 1:ncol(df)) {
  df[is.na(df[,i]), i] <- mean(df[,i], na.rm = TRUE)
}

# check for NAs to make sure
sapply(df, function(y) sum(length(which(is.na(y)))))

# set seed
set.seed(12)

# test/train set
trainIDs <- sample(nrow(df), 0.7*nrow(df), replace=FALSE)
train <- df[trainIDs,]
test <-  df[-trainIDs,]

####################################################
## - general statement regarding health of cityX  ##
##  o KPIs?                                       ##
##  o viz?                                        ##
####################################################

## potential KPIs
# ACCESS2_CrudePrev | CHECKUP_CrudePrev | COREM_CrudePrev
# COREW_CrudePrev | DENTAL_CrudePrev | LPA_CrudePrev
# MHLTH_CrudePrev  (predict) | PHLTH_CruePrev (predict) | SLEEP_CrudePrev
##

## QUESTION: How do these variables correlate with our prediction variables?

par(mfrow=c(7,2))

cor(df$ACCESS2_CrudePrev, df$PHLTH_CrudePrev) # 0.824
cor(df$ACCESS2_CrudePrev, df$MHLTH_CrudePrev) # 0.870
plot(df$ACCESS2_CrudePrev, df$PHLTH_CrudePrev)
plot(df$ACCESS2_CrudePrev, df$MHLTH_CrudePrev)

cor(df$CHECKUP_CrudePrev, df$PHLTH_CrudePrev) # -0.005
cor(df$CHECKUP_CrudePrev, df$MHLTH_CrudePrev) # -0.537
plot(df$CHECKUP_CrudePrev, df$PHLTH_CrudePrev)
plot(df$CHECKUP_CrudePrev, df$MHLTH_CrudePrev)

cor(df$COREM_CrudePrev, df$PHLTH_CrudePrev) # -0.781
cor(df$COREM_CrudePrev, df$MHLTH_CrudePrev) # -0.911
plot(df$COREM_CrudePrev, df$PHLTH_CrudePrev)
plot(df$COREM_CrudePrev, df$MHLTH_CrudePrev)

cor(df$COREW_CrudePrev, df$PHLTH_CrudePrev) # -0.713
cor(df$COREW_CrudePrev, df$MHLTH_CrudePrev) # -0.830
plot(df$COREW_CrudePrev, df$PHLTH_CrudePrev)
plot(df$COREW_CrudePrev, df$MHLTH_CrudePrev)

cor(df$DENTAL_CrudePrev, df$PHLTH_CrudePrev) # -0.854
cor(df$DENTAL_CrudePrev, df$MHLTH_CrudePrev) # -0.944
plot(df$DENTAL_CrudePrev, df$PHLTH_CrudePrev)
plot(df$DENTAL_CrudePrev, df$MHLTH_CrudePrev)

cor(df$LPA_CrudePrev, df$PHLTH_CrudePrev) # 0.946
cor(df$LPA_CrudePrev, df$MHLTH_CrudePrev) # 0.877
plot(df$LPA_CrudePrev, df$PHLTH_CrudePrev)
plot(df$LPA_CrudePrev, df$MHLTH_CrudePrev)

cor(df$SLEEP_CrudePrev, df$PHLTH_CrudePrev) # 0.776
cor(df$SLEEP_CrudePrev, df$MHLTH_CrudePrev) # 0.814
plot(df$SLEEP_CrudePrev, df$PHLTH_CrudePrev)
plot(df$SLEEP_CrudePrev, df$MHLTH_CrudePrev)

mean(df$ACCESS2_CrudePrev)
mean(df$CHECKUP_CrudePrev)
mean(df$COREM_CrudePrev)
mean(df$COREW_CrudePrev)
mean(df$DENTAL_CrudePrev)
mean(df$LPA_CrudePrev)
mean(df$SLEEP_CrudePrev)

# The aforementioned variables show a strong relationship between the percentage of people
# that have been diagnosed with poor Physical / Mental Health. This allows us to use these
# variables to showcase an insight into the overall health of CityX, beyond the two variables
# that depict Physical / Mental Health.


## Will be looking into CANCER_CrudePrev // CHD_CrudePrev // KIDNEY_CrudePrev // COPD_CrudePrev
## CANCER_CrudePrev ~ HIGHCHOL_CrudePrev
## CHD_CrudePrev ~ OBESITY_CrudePrev
## KIDNEY_CrudePrev ~ BPHIGH_CrudePrev
## COPD_CrudePrev ~ CSMOKING_CrudePrev

# single variable linear model
cancer.lin <- lm(CANCER_CrudePrev ~ HIGHCHOL_CrudePrev, data=df)
cancer.lin
plot(df$HIGHCHOL_CrudePrev, df$CANCER_CrudePrev)
abline(cancer.lin)
cor(df$HIGHCHOL_CrudePrev, df$CANCER_CrudePrev)

chd.lin <- lm(CHD_CrudePrev ~ OBESITY_CrudePrev, data=df)
chd.lin
plot(df$OBESITY_CrudePrev, df$CHD_CrudePrev)
abline(chd.lin)
cor(df$CHD_CrudePrev, df$OBESITY_CrudePrev)

kidney.lin <- lm(KIDNEY_CrudePrev ~ BPHIGH_CrudePrev, data=df)
kidney.lin
plot(df$BPHIGH_CrudePrev, df$KIDNEY_CrudePrev)
abline(kidney.lin)
cor(df$BPHIGH_CrudePrev, df$KIDNEY_CrudePrev)

copd.lin <- lm(COPD_CrudePrev ~ CSMOKING_CrudePrev, data=df)
copd.lin
plot(df$CSMOKING_CrudePrev, df$COPD_CrudePrev)
abline(copd.lin)
cor(df$COPD_CrudePrev, df$CSMOKING_CrudePrev)

# multivariable linear model
chd.multi <- lm(CHD_CrudePrev ~ OBESITY_CrudePrev + HIGHCHOL_CrudePrev +
                  BPHIGH_CrudePrev + LPA_CrudePrev, data=df)
chd.multi

chd.multi.p <- predict(chd.multi, df)
chd.multi.b <- df$CHD_CrudePrev
chd.multi.q <- data.frame(cbind(chd.multi.b, chd.multi.p)) 
chd.multi.diff <- (chd.multi.q$chd.multi.b-chd.multi.q$chd.multi.p)/chd.multi.q$chd.multi.b*100
hist(chd.multi.diff, breaks=30)
chd.multi.diff

predicted <- predict(chd.multi, df)
actual <- df[["CHD_CrudePrev"]]
mean((predicted - actual)^2)

# classification DT
fit <- rpart(CHD_CrudePrev ~ OBESITY_CrudePrev + HIGHCHOL_CrudePrev +
               BPHIGH_CrudePrev + LPA_CrudePrev, data=df)
fit

par(mar=c(2 ,2, 2, 2))
plot(fit, uniform = TRUE)
text(fit, digits=6)

# nonparametric model (LOESS)
loess.model <- loess(CHD_CrudePrev ~ OBESITY_CrudePrev + HIGHCHOL_CrudePrev +
                       BPHIGH_CrudePrev + LPA_CrudePrev, data=train)

loess.p <- predict(loess.model, test)
loess.b <- test$CHD_CrudePrev
loess.q <- data.frame(cbind(loess.b, loess.p)) 
loess.diff <- (loess.q$loess.b-loess.q$loess.p)/loess.q$loess.b*100
hist(loess.diff, breaks=30)

predicted <- predict(loess.model, df)
actual <- df[["CHD_CrudePrev"]]
mean((predicted - actual)^2)
