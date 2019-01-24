# -----------------------------------
# Snippets - Datacamp Lessons
# -----------------------------------
# Data Import - read.delim
# libraries used
library("readr")
library("data.table") #for big table loads, fast
# -----------------------------------
# somethings not quite right here.... check data
# Import hotdogs.txt: hotdogs
hotdogs <- read.delim("E:/One Drive/OneDrive/data_mining/DataCamp examples/hotdogs.txt", header = FALSE)
summary(hotdogs)
hotdogs
# -----------------------------------
# Select the hot dog with the least calories: lily
lily <- hotdogs[which.min(hotdogs$calories), ]
lily
# Select the observation with the most sodium: tom
tom <- hotdogs[which.max(hotdogs$sodium), ]
tom

# -----------------------------------
# Column names
properties <- c("area", "temp", "size", "storage", "method",
             "texture", "flavor", "moistness")
# -----------------------------------
# Test on my files (that worked)
# Import potatoes.csv with fread(): potatoes
	potatoes <- fread("E:/One Drive/OneDrive/data_mining/DataCamp examples/potatoes.csv")
# example local file
potatoes <- read_csv("E:/One Drive/OneDrive/data_mining/DataCamp examples/potatoes.csv")
summary(potatoes )
potatoes 
# Plot texture (x) and moistness (y) of potatoes
plot(potatoes$texture,potatoes$moistness)
# -----------------------------------
# Import columns 6 and 8 of potatoes.csv: potatoes
potatoes <- fread("potatoes.csv", select = c(6,8))
# -----------------------------------
# Applies to variable
# fread("path/to/file.txt", drop = 2:4) 
# fread("path/to/file.txt", select = c(1, 5))
# fread("path/to/file.txt", drop = c("b", "c", "d")
# fread("path/to/file.txt", select = c("a", "e"))
# -----------------------------------
