#### Clustering

## K-Means

library(stats)
library(ggplot2)
library(factoextra)
library(corrplot)
library(cluster)

head(USArrests)
str(USArrests)
summary(USArrests)
any(is.na(USArrests))


df <- scale(USArrests)
head(df)

fviz_nbclust(USArrests, kmeans, method="wss") + geom_vline(xintercept =4, linetype= 5, col= "darkred")
### K-Means with k=4

### Output of Kmeans

km.res <- kmeans(df, 3, nstart = 25)
km.res

#### Including Clusters in USArrests

df_member <- cbind(USArrests, cluster = km.res$cluster)
head(df_member)

fviz_cluster(km.res, data=USArrests)

fviz_cluster(km.res, data = USArrests,
             palette=c("red", "blue", "black", "darkgreen"),
             ellipse.type = "euclid",
             star.plot = T,
             repel = T,
             ggtheme = theme())

aggregate(USArrests, by=list(cluster=df_member$cluster), mean)


#########################################################################
### Heirarchical Clustering

res.agnes <- agnes(x=USArrests, stand = TRUE, 
                   metric = "euclidean", method="ward")

res.diana <- diana(x=USArrests, stand = TRUE, 
                   metric = "euclidean")

fviz_dend(res.agnes, cex=0.6, k=4)
fviz_dend(res.diana, cex=0.6, k=4)