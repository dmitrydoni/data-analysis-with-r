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
print("error on vec_1 + vec_2 because vectors must have the same size")
vec_1 / 2
rm(vec_1, vec_2)

# Distributions
set.seed(42)

# Normal distribution
rnorm(n=50, mean=0, sd=1)

# Poisson distribution
rpois(100, 10)

# Binomial distribution, 100 experiments (10 events each), 50% probability
rbinom(100, 10, 0.5)

# More operations with vectors
rep(c(0, 2), time=2) # repeat vector twice: 0 2 0 2
rep(c(0, 2), each=2) # repeat each element twice: 0 0 2 2

# Text vectors
letters
LETTERS

# Strings concatenation
paste(letters, set="_", seq(1, 26))

# Date functions
ISOdate(2021, 11, 1:30)
format(ISOdate(2021, 11, 1:30),"%d") # "%a", "%A", etc.

# Tables
d <- c(rep("a", 1), rep("b", 2), rep("c", 3))
sample(d)
table_d <- table(d)
table_d

# Math functions
r <- seq(10, 1)
r
sum(r)
mean(r)

# Logical operators
1==1
6>7 | 9>8 # OR
6>7 & 9>8 # AND

# Public datasets
data(package = .packages(all.available = TRUE))
# install.packages("cluster")
library(cluster)
animals
is.na(animals) # NA values will be marked TRUE
head(animals, 5) # first 5 records
animals$fly # select one column

# Building datasets
weight <- c(78, 66, 75, 87, 59)
height <- c(178, 166, 175, 187, 159)
sex <- c(rep("F", 3), rep("M", 2))

df_1 <- data.frame(weight, height, sex, stringsAsFactors = F) # strings
str(df_1) # structure
df_1

df_2 <- data.frame(weight, height, sex, stringsAsFactors = T) # sex is factor
str(df_2) # structure
df_2

unique(sex)
factor(sex)
levels(factor(sex))

# Building matrices

# Sequence from 1 to 20
m <- 1:20
m
class(m)
dim(m) # NULL because it is a vector

z <- c(10, 2)
z

dim(m) <- z  # m will be a matrix with dimensions specified in z
m
class(m) # m is now a matrix

# Another way to create a matrix
y <- 1:50
y
mtx <- matrix(y, 10, 5) # 10 rows, 5 columns
mtx

names_m = LETTERS[1:10]
names_m

# Set names for rows
rownames(mtx, do.NULL = T, prefix = "row")
rownames(mtx) <- names_m
mtx

# Set names for columns
colnames(mtx, do.NULL = T, prefix = "col")
colnames(mtx) <- paste0("day", set="_", 1:5)
mtx
mtx[, 2] # only the second column
mtx[3, ] # only the third row
