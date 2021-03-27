
rm(list = ls())
graphics.off()

# require the packages
require(ggplot2)
require(MASS)
require(ggpubr)


# loading the data
fish <- read.csv("../data/fisheries.csv", stringsAsFactors = T)
str(fish)

# see the initial scatterplot
ggplot(fish, aes(x = MeanDepth, y = TotAbund)) +
  geom_point() +
  labs(x="Mean Depth (km)", y = "Total Abundance") +
  theme_classic()



