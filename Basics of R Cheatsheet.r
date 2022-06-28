## Basics of R, Cheatsheet


# Use ctrl+enter to run a line of this script
# Or write into the console below

# Installing Packages
# You only need to do this once per machine
install.packages("tidyverse")


# Loading packages so you can use them
# You need to do this every time you launch R
library(tidyverse)


# Basic operations
5 + 5 # Addition
5 * 5 # Multiplication

# Assigning variables

x <- 5*5
print(x)


# Loading data
ff <- readRDS('data/fruitfly.rds')


## Note - you can see them in the panel on the right! This environment panel keeps track of all your variables

# Accessing parts of variables can be done using the $ sign, to access columns in data frames, keys in dictionaries, and so on

ff$thorax


# Loops
# If you want to do something multiple times, or do something to a list of different variables, one way is to use a loop
# rather than simply writing out each line of code

for (i in 1:5){
  print(i)
  
  
}

