########  Exploritory Data Analysis - Visualization   ##########

### Scatterplot
head(mtcars)
plot(mtcars$hp, mtcars$mpg, xlab= "Horsepower", ylab='Miles per Gallon', 
     main= "Miles per Gallon vs Horspower", xlim=c(0, 150), ylim=c(0, 20), 
     pch=1, col="dark red")


### Barplots and Pie Charts
MLB <- read.csv("MLBTeams.csv")

barplot(by(MLB$payroll, list(MLB$division, MLB$league), sum), col=2:4)
pie(by(as.numeric(MLB$payroll), MLB$league, sum), col = 2:3)

### Distributions
# Histogram
hist(mtcars$disp)
hist(mtcars$disp, breaks="sturges", main="Strurges")
hist(mtcars$disp, breaks="scott", main="Scott")
hist(mtcars$disp, breaks="fd", main="Freeman-Diaconis")
hist(mtcars$disp, breaks=10, main="50 Bins")

# Boxplots
boxplot(mtcars$hp)
max(mtcars$hp)
which(mtcars$hp == max(mtcars$hp))
print(mtcars[31,])

### Correlation of Variables
cor(mtcars$mpg, mtcars$hp)
cor(mtcars$cyl, mtcars$disp)
cor(mtcars)
pairs(mtcars, lower.panel = panel.smooth, 
      upper.panel = panel.cor)
