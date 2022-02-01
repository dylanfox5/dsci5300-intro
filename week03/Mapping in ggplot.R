#### Mapping in ggplot2

### install packages ggmap, maps, and mapproj

library(ggplot2)
library(ggmap)
library(maps)
library(mapproj)

### The map_data comand will provide a file with the latitude and 
### longitude of regions across the us by state.
us <- map_data("state")

### Make a blank simple map
dummyDF <- data.frame(state.name, stringsAsFactors = FALSE)
dummyDF$state <- tolower(dummyDF$state.name)

map.simple <- ggplot(dummyDF, aes(map_id = state))
map.simple <- map.simple + geom_map(map=us, fill="white", color="black")
map.simple <- map.simple + expand_limits(x=us$long, y= us$lat)
map.simple <- map.simple + coord_map() + ggtitle("Basic map of the continental USA")
map.simple

map.simple+geom_point(aes(x=-100, y=30))
map.simple+geom_point(aes(x=-93.9335, y=40.6202))


