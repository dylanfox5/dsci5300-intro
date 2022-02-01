### Making a Word Cloud from a Text File ###

### install packages tm and wordcloud

library(tm)
library(wordcloud)

sbaFile <- "sba.txt"
sba <- scan(sbaFile, character(0), sep = "\n")
head(sba, 3)

sbaFile <- "sba.txt"
sba <- readLines(sbaFile)
head(sba, 3)

### Converting the text file 
words.vec <- VectorSource(sba)
words.corpus <- Corpus(words.vec)
words.corpus <- tm_map(words.corpus, content_transformer(tolower))
words.corpus <- tm_map(words.corpus, removePunctuation)
words.corpus <- tm_map(words.corpus, removeNumbers)
words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))
tdm <- TermDocumentMatrix(words.corpus)
tdm
inspect(tdm)

### Counting the words
m <- as.matrix(tdm)
wordCounts <- rowSums(m)
wordCounts <- sort(wordCounts, decreasing = TRUE)
head(wordCounts)

### Preparing the word cloud visualization
cloudFrame <- data.frame(word=names(wordCounts), freq=wordCounts)
wordcloud(cloudFrame$word, cloudFrame$freq)
wordcloud(names(wordCounts), wordCounts, min.freq=2, max.words=50, rot.per=0.35, colors=brewer.pal(8, "Dark2"))
