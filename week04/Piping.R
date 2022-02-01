### Piping to subset and add informatonto a file: %>%
library(dplyr)
df <- mtcars
str(df)

df1 <- df %>% 
    filter(mpg >= 20)

str(df1)

df2 <- df1 %>% 
    select(mpg, cyl, hp, wt)

str(df2)


df3 <- df %>%
    filter(cyl == 4) %>%
    select(mpg, wt, hp)
df3

df3 %>% summarise(median = median(mpg), variance = var(mpg))
arrange(df3, mpg)

df3 %>%
    mutate (ratio = wt/hp)

df %>% group_by(cyl) %>%
    summarise(mean = mean(wt), sum = sum(hp), n = n())

names(df)<-gsub("vs", "EngineShape", names(df))
df
