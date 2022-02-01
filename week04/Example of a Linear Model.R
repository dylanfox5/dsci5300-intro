### Example of a Linear Model ###

# Fleet Vehicle oil changes
Oilchange <- c(3, 5, 2, 3, 1, 4, 6, 4, 3, 2, 0, 10, 7, 8)
Repaircost <- c(300, 300, 500, 400, 700, 420, 100, 290, 475, 620, 600, 0, 200, 50)

oil <- data.frame(Oilchange, Repaircost)
View(oil)

model <- lm(formula = Repaircost ~ Oilchange, data=oil)
model
summary(model)

plot(oil$Oilchange, oil$Repaircost)
abline(model)

ggplot(oil, aes(x=Oilchange, y=Repaircost)) +
    geom_point()+
    stat_smooth(method='lm', col="red")