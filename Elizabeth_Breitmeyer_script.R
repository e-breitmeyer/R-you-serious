### Module 1 Project

library(ggplot2)
library(tidyverse)

# ALWAYS SET THE WORKING DIRECTORY!
setwd("/Users/elizabethbreitmeyer/Desktop/Experimental Methods in Organismal Bio/R-you-serious")

# DAT VARIABLE CONTAINING SCALES DATASET
dat <- read.csv("scales.csv")

# DIMENSIONS OF THE DATASET
dim(dat)
# 1842 rows and 4 columns
head(dat)
# columns named “N”, “quadrant”, “species”, and “specimen”
  # N is force in Newtons took needle to puncture scale
  # quadrant is where on body scale was UL, UR, LL, LR
  # species is species scale came from
  # specimen is from which specimen the scales came from

# REPORTING THE CLASS OF EACH COLUMN IN THE DATA SET
sapply(dat,class)
# N is numeric; quadrant, species, and specimen are character

# NUMBER OF SCALES PUNCTURED FOR EACH SPECIES
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

# HOW MANY SPECIMENS FOR EACH SPECIES?
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

  # Loop When You Can
  # for each value i in species we passed dat through a filter where species==i, plotted a boxplot using ggplot where x is quadrant and y is the puncture force
  # for each species, this is saved to p and we printed p > 6 separate plots

# PRODUCING PDF OF FIGURES FOR EACH SPECIES
pdf("species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")

  # wrapping function pdf() prints graphic output to a file, named species_quadrant.pdf
  # any plot printed with p() after pdf() and before dev.off() saves the plots in the named file
  # list.files() command with pattern=".pdf" confirms that a PDF file was saved to the working directory
