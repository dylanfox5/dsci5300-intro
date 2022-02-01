############## Vector Operations  ###########

a <- c(2,-1, 3)
a
# Multiplication by scalar 
b <- 3*a
b
#  Addition of vectors
c <- a+b
c
# SUbtraction
d <- a-b
d

# The Inner or Dot Product
sum(a*b)

# Length
sqrt(sum(a*a))

# Orthogonal Vectors
v1 <- c(1,1)
v2 <- c(-1,1)
sum(v1*v2)

############ Matrix Operations ########
A <- matrix(c(1,2,4,5,7,8), ncol=3)  # read in column-by-column
A

A2 <- matrix(c(1,2,4,5,7,8), ncol=3, byrow=TRUE)  # read in row-by-row
A2

#Extrating values from a Matrix
A[2,2]
A[1,]
A[,3]

#Transposing a Matrix
t(A)

#Adding and subtracting:  requires the same dimensions
B <-matrix(c(1,2,4,5,7,8), ncol=3, byrow=TRUE)
B2 <- matrix(c(3,-1,-3,4,2,2), ncol=3, byrow=TRUE)
B
B2
C <- B+B2
C
D <- B-B2
D

B2+ B  # Order of addition and subtraction does not matter

#### Scalar Multiplication
k=-2
E <- k*A
E

k<- -1
D2 <- A+k*B
D2

### Multiplication of a Matrix and Vector: Aa
# Columns of A must each rows of a

A %*% b

##### Multiplication Of two Matices
# Columns of A must each rows of B

A3 <- matrix(c(1,3,8,9,3,1), ncol=2)
A3
B3 <- matrix(c(3,4,-1,-1), ncol=2)
B3

A3 %*% B3

# The order of multiplication is important

B4 <- matrix(c(1,-5,1,3), ncol=2)
B3 %*% B4
B4 %*% B3

# Making a diagonal matrix and the identity matrix
diag(c(1,2,3))
diag(1,3)
diag(B4)

### Find the determinant of a matrix
det(B3)

#### Find the inverse of a matrix
W <- matrix(c(30, 31, 40, 41, 50, 51, 60, 61, 70), nrow=3, byrow=TRUE)
W1<-solve(W)  ### finds the inverse
W
W1


### Linear Equation Example

A <- matrix(c(1,2,3,4), ncol=2)
A
b <- c(7,10)
x <- solve(A) %*% b
x

### Calculating Eigenvlaues and Eigenvectors

A<-matrix(c(30,31,40,41,50,51,60,61,70),nrow = 3,byrow = TRUE)
e <- eigen(A)
e$values
e$vectors 

#### Least Squares
x <- c(1, 2, 3, 4, 5)
y <- c(3.70, 4.20, 4.90, 5.70, 6.00)
plot(x, y)

X <- matrix(c(1,1,1,1,1,1,2,3,4,5), ncol=2)

beta.hat <- solve(t(X) %*% X) %*% t(X) %*% y
beta.hat

lsfit(x, y)
plot(x, y)
abline(lsfit(1:5, y))

