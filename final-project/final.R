library(e1071)
library(stats)
library(ggplot2)
library(factoextra)
library(corrplot)
library(cluster)
library(dplyr)

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

cor(df$ACCESS2_CrudePrev, df$PHLTH_CrudePrev) # 0.824
cor(df$ACCESS2_CrudePrev, df$MHLTH_CrudePrev) # 0.870

cor(df$CHECKUP_CrudePrev, df$PHLTH_CrudePrev) # -0.005
cor(df$CHECKUP_CrudePrev, df$MHLTH_CrudePrev) # -0.537

cor(df$COREM_CrudePrev, df$PHLTH_CrudePrev) # -0.781
cor(df$COREM_CrudePrev, df$MHLTH_CrudePrev) # -0.911

cor(df$COREW_CrudePrev, df$PHLTH_CrudePrev) # -0.713
cor(df$COREW_CrudePrev, df$MHLTH_CrudePrev) # -0.830

cor(df$DENTAL_CrudePrev, df$PHLTH_CrudePrev) # -0.854
cor(df$DENTAL_CrudePrev, df$MHLTH_CrudePrev) # -0.944

cor(df$LPA_CrudePrev, df$PHLTH_CrudePrev) # 0.946
cor(df$LPA_CrudePrev, df$MHLTH_CrudePrev) # 0.877

cor(df$SLEEP_CrudePrev, df$PHLTH_CrudePrev) # 0.776
cor(df$SLEEP_CrudePrev, df$MHLTH_CrudePrev) # 0.814
