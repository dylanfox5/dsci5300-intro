### intro to DS -- week 3 hw

df <- read.csv('/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week03/census.csv')
df1 <- read.csv('/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week03/nst-est2016-alldata (2).csv')

### problem 1
head(df)
str(df)
summary(df)
unique(df$LSAD)

### problem 2
is.na(df)
any(is.na(df))
na_count <- sapply(df, function(y) sum(length(which(is.na(y)))))
na_count

mean(df$CENSUS2010POP) # 239,150.9
median(df$CENSUS2010POP) # 62,544
sd(df$CENSUS2010POP) # 785,448.7

hist(df$CENSUS2010POP, breaks=50)

### problem 3
sortAsc <- df[order(df$CENSUS2010POP), ]
head(sortAsc, 3)
tail(sortAsc, 3)

### problem 4
barplot(df1$POPESTIMATE2016, names.arg=df1$NAME, las=2)

### problem 5
hist(df1$RBIRTH2016, breaks=30, main='Birth Rate in 2016', xlab='Number of Births')

### problem 6
boxplot(df1$RBIRTH2016, main='Birth Rate in 2016', ylab='Number of Births')
sortBirthRate <- df1[order(df1$RBIRTH2016), ]
tail(sortBirthRate, 1)

### problem 7
cor(df1[,22:28], df1[29:35])
pairs(df1[,22:28], df1[29:35])

### problem 8
library(ggplot2)
library(reshape2)

df1.long <- melt(df1, id="NAME", measure=c("RBIRTH2011", "RBIRTH2013", "RBIRTH2016"))
plot <- ggplot(df1.long, aes(NAME, value, color=variable, group=1))
label_object <- labs(title = "Birth Rate in US", 
                     subtitle = "2011, 2013, 2016", 
                     x = 'Name', y= "Birth Rate", 
                     caption = "Source = Trust Me")
theme_object <- theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1))
plot  + geom_point() + label_object + theme_object

### problem 9
library(ggmap)
library(maps)
library(mapproj)

us <- map_data("state")

df2 <- data.frame(df1$NAME, df1$POPESTIMATE2016)[6:56,]
names(df2)[names(df2) == "df1.NAME"] <- "state"
names(df2)[names(df2) == "df1.POPESTIMATE2016"] <- "pop"
df2$pop <- as.numeric(df2$pop)
df2$state <- tolower(as.character(df2$state))
df2 <- df2[-c(9),]


map.simple <- ggplot(df2, aes(map_id=state, fill=pop))
map.simple <- map.simple + geom_map(map=us, color="black")
map.simple <- map.simple + expand_limits(x=us$long, y= us$lat)
map.simple <- map.simple + coord_map() + ggtitle("Estimated Population in 2016") + xlab("longitude") + ylab("latitude")
map.simple

### problem 10
library(tm)
library(wordcloud)

txtFile <- "/Users/dylanfox/OneDrive - Graceland University/Graduate Work/dsci5300-intro/week03/highrises-overview.txt"
txt <- scan(txtFile, character(0), sep = "\n")
head(txt, 3)

words.vec <- VectorSource(txt)
words.corpus <- Corpus(words.vec)
words.corpus <- tm_map(words.corpus, content_transformer(tolower))
words.corpus <- tm_map(words.corpus, removePunctuation)
words.corpus <- tm_map(words.corpus, removeNumbers)
words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))
tdm <- TermDocumentMatrix(words.corpus)
tdm
inspect(tdm)

m <- as.matrix(tdm)
wordCounts <- rowSums(m)
wordCounts <- sort(wordCounts, decreasing = TRUE)
head(wordCounts)

cloudFrame <- data.frame(word=names(wordCounts), freq=wordCounts)
wordcloud(cloudFrame$word, cloudFrame$freq)
wordcloud(names(wordCounts), wordCounts, min.freq=2, max.words=50, rot.per=0.35, colors=brewer.pal(8, "Dark2"))