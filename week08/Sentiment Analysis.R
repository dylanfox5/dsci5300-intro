##### Sentiment Analysis    #####
pos <- "positive-words.txt"
neg <- "negative-words.txt"

p <- scan(pos, character(0), sep="\n")
n <- scan(neg, character(0), sep="\n")

head(p, 10)
head(p, 35)
p <- p[-1:-29]
n <- n[-1:-30]
head(n, 10)
head(p, 10)

#### From the SBA speech we used for the Word Cloud
totalWords <- sum(wordCounts)
words <- names(wordCounts)

##### Positive Words
matched <- match(words, p, nomatch=0)
head(matched, 20)
p[1533]
words[18]


mCounts <- wordCounts[which(matched !=0)]
length(mCounts)
mWords <- names(mCounts)
nPos <- sum(mCounts)
nPos

#### Negative Words
matched <- match(words, n, nomatch=0)
nCounts <- wordCounts[which(matched !=0)]
nNeg <- sum(nCounts)
nNeg
length(nCounts)

#### Percent Positive and Negative Words

totalWords <- length(words)
ratioPos <- nPos/totalWords
ratioNeg <- nNeg/totalWords
ratioPos
ratioNeg
