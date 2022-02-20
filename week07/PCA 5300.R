#### What goes on in PCA

# use a simple two dimensional dataset to illustrate PCA
x <- c(2.5, 0.5, 2.2, 1.9, 3.1, 2.3, 2, 1, 1.5, 1.1)
y <- c(2.4, 0.7, 2.9, 2.2, 3.0, 2.7, 1.6, 1.1, 1.6, 0.9)

plot(x, y, pch = 19)

### Center on the Means
mean(x)
mean(y)

x1 <- x - mean(x)
x1
summary(x1)
y1 <- y - mean(y)
y1
summary(y1)

plot(x1, y1, pch = 19)

#### We need the covariance

cov(x1, y1)
cov(x1, x1)
cov(y1, y1)

m <- matrix(c(cov(x1, x1), cov(x1, y1), cov(y1, x1),cov(y1, y1)),
            nrow=2,
            ncol=2,
            byrow=TRUE,
            dimnames=list(c("x","y"),c("x","y")))
m

#### Determining Eigenvectors and Eigenvalues
e <- eigen(m)
e


#### The largest value is the principle component

pc1 <- x1 * e$vectors[1,1] + y1 * e$vectors[2,1]
pc1
pc2 <- x1 * e$vectors[1,2] + y1 * e$vectors[2,2]
pc2

data.frame(PC1 = pc1, PC2 = pc2)
plot(pc1, pc2, pch = 19)


#### Using the prcomp()
data <- data.frame(x,y)
data.pca <- prcomp(data)
data.pca


names(data.pca)
data.pca$x
head(data.pca)
plot(data.pca$x[,1], data.pca$x[,2], pch = 19)


###### mtcars data set

mtcars.pca <- prcomp(mtcars[, c(1:7, 10, 11)], center =TRUE, scale=TRUE)
summary(mtcars.pca)
str(mtcars.pca)

library(ggbiplot)

ggbiplot(mtcars.pca)
round(mtcars.pca$rotation, 3)

ggbiplot(mtcars.pca, labels = rownames(mtcars))
