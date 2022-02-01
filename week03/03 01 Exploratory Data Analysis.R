######################   R Commands   ######################

### Find working directory
getwd()


### Reading in a File
hurricanes <-read.csv("DataSetHurricanes.csv")

### File Invesigation

head(hurricanes)
tail(hurricanes)
str(hurricanes)

### Measures of Center
mean(hurricanes$DamageMillions)
median(hurricanes$Deaths)

### Measures of Spread
var(hurricanes$WindMPH)
sd(hurricanes$WindMPH)
range(hurricanes$WindMPH)
IQR(hurricanes$WindMPH)
max(hurricanes$WindMPH)
min(hurricanes$WindMPH)

### Number of Observations, n
length(hurricanes$Name)
nrow(hurricanes)
ncol(hurricanes)    # number of observations

### Summary, a lot in one command
summary(hurricanes)


#### Examining the contents of data file

# Transcription errors
survey <- read.csv("Survey.csv")
str(survey)
unique(survey$sex)
which(survey$sex == 'F')
survey$sex[which(survey$sex == 'F')]='Female'
unique(survey$sex)

# Missing data
is.na(survey$height)
mean(survey$height)
mean(survey$height, na.rm = TRUE)
any(is.na(survey))

# Dealing with missing data
data.observed <- na.omit(survey)  #harsh
str(data.observed)
# Imput data
survey$height[is.na(survey$height)] = mean(survey$height, na.rm = TRUE)
mean(survey$height)

length(hurricanes$Year)
mean(hurricanes$WindMPH)
max(hurricanes$Deaths)
sd(hurricanes$DamageMillions)

### Sorting on a Variable

hur2 <- hurricanes[order(hurricanes$Year), ]
head(hur2, 10)

hur2 <- hurricanes[order(-hurricanes$Year), ]
head(hur2, 10)

hur2 <- hurricanes[order(hurricanes$Year, -hurricanes$DamageMillions), ]
head(hur2, 10)

