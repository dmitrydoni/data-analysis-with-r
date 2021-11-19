# Hello, World
print("Hello, R!")

# Manual
? print # or: help(print)

# Get/set working directory
wd <- '/Users/ddoni/Projects/R_Project'
setwd(wd)
current_wd <- getwd()
cat(sprintf("Current working directory: %s\n", current_wd))
rm(wd, current_wd) # delete objects

# Variables
vec_0 <- c(1, 2, 3, 4) # vector
vec_0
rm(vec_0)

# Simple math
(10 ^ 3) / sqrt(4) + 1
2 ** 4 == 2 ^ 4 # TRUE

# Sequences
seq_1 <- 1:20
seq_1[1:5] # items from 1 to 5
seq_2 <- 10:5
seq_2
seq_3 <- seq(2,14, by=2) # even numbers from 2 to 14
seq_3
seq_4 <- seq(1,10, length.out = 5) # 5 elements only
seq_4
rm(seq_1, seq_2, seq_3, seq_4)

# Math functions
log2(8) == 3 # TRUE
log2(8) == log(8, base = 2) # TRUE

exp(1)
log(exp(1)) # 1

factorial(4) == 1 * 2 * 3 * 4 # TRUE

# Working with vectors
vec_1 <- c(0, 1, 2, 3)
vec_1[1] # indexes start with 1
vec_2 <- rep(6, 3) # replicate '6' 3 times
vec_2
print("error on vec_1 + vec_2 because vectors must have the same size)")
vec_1 / 2


rm(vec_1, vec_2)

