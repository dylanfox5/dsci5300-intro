## Working with models
library(ggplot2)
library(gapminder)

P <- ggplot(data=gapminder, mapping=aes(x=log(gdpPercap), y=lifeExp))
P + geom_point(alpha=0.1) +
    geom_smooth(color="tomato", fill="tomato", method=MASS::rlm)+
    geom_smooth(color = "steelblue", fill="steelblue", method="lm")

P + geom_point(alpha=0.1) +
    geom_smooth(color="tomato", method="lm", size = 1.2, 
                formula = y~ splines::bs(x,3), se=FALSE)

P + geom_point(alpha=0.1) +
    geom_quantile(color="tomato", size = 1.2, method="rqss",  
                lambda=1, quantiles =c(0.20, 0.5, 0.85))


####
model.colors <- RColorBrewer::brewer.pal(3, "Set1")
model.colors
####
p0 <- ggplot(data=gapminder, mapping=aes(x=log(gdpPercap), y=lifeExp))

p1 <- p0 + geom_point(alpha=0.2) +
    geom_smooth(method='lm', aes(color="OLS", fill="OLS")) + 
    geom_smooth(method='lm', formula = y ~ splines::bs(x, df=3), 
                aes(color="Cubic Spline", fill="Cubic Spline")) +
    geom_smooth(method="loess", aes(color = "LOESS", fill="LOESS"))

p1 + scale_color_manual(name="Models", values = model.colors) +
    scale_fill_manual(name="Models", values= model.colors)  +
    theme(legend.position = "top")

    
    
    