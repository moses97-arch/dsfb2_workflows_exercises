library(tidyverse)

vect_1 <- c(1:360)
vect_2 <- LETTERS
vect_3 <- 2 * pi / vect_1
vect_4 <- 2^(1:20)
vect_5 <- list(c("Hello"), c("World"), log10(1:100))
str(vect_5)
list_12 <- list(vect_1, vect_2, vect_3, vect_4,vect_5)

list_12[[4]][10]
list_12[[5]][[3]][99]
