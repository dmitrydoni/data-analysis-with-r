# install.packages("cluster")
# install.packages("rio")
# install.packages("dplyr")
# install.packages("rafalib")

# Load installed packages
library(cluster)
library(rio)
library(dplyr)
library(rafalib)

# View data sets in package "cluster"
data()

# Get/set working directory
wd <- '/Users/ddoni/Projects/R_Project'
setwd(wd)
getwd()

# Load dataset using import() from rio
cardio <- import('../datasets/cardio_train.csv')
head(cardio)

# Get additional info about the dataset
dim(cardio)  # 70000  13
str(cardio)  # 70000 obs. of 13 variables...

# In the "age" column, the values are in days.
# We will add a new column which will contain values in years.
# Function mutate() is used to create, modify, and delete columns.
# Function trunc() is used to truncate the values to get integers.
cardio <- cardio %>% mutate(age_years=(trunc(age/365)))
head(cardio, 3)

# Research the pressure values: ap_hi and ap_lo.
# We assume that these variables are distributed normally.
mypar(1, 2)  # plot properties: 2 charts on 1 row
hist(cardio$ap_hi)  # not symmetrical shape (left skew)
hist(cardio$ap_lo)  # not symmetrical shape (left skew)
mean(cardio$ap_hi)  # 128.82
sd(cardio$ap_hi)  # 154.01 - it means that variance is high
