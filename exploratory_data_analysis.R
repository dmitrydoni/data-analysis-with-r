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

# Descriptive statistics
mean(cardio$ap_lo)  # 96.63
sd(cardio$ap_lo)  # 188.47 - it means that variance is high
mean(cardio$ap_hi)  # 128.82
sd(cardio$ap_hi)  # 154.01 - it means that variance is high

# Visualize as boxplots
box_lo <- boxplot(cardio$ap_lo)  # there are outliers
box_hi <- boxplot(cardio$ap_hi)  # there are outliers

# Visualize as boxplots (filter out the outliers)
box_lo <- boxplot(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])
title("Low Pressure")
box_hi <- boxplot(cardio$ap_hi[cardio$ap_hi<300 & cardio$ap_hi>40])
title("High Pressure")

# Find other outliers
min(cardio$ap_hi)  # -150
cardio$ap_hi[cardio$ap_hi<0]  # -100 -115 -100 -140 -120 -150 -120

# Percentiles: median (50%), 1st quartile (25%), 3rd quartile (75%)
median(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])  # 80
quantile(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20], 0.25)  # 25%, 80
quantile(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20], 0.75)  # 75%, 90

# Calculate the 1st quartile (25%) manually
# Sort all values
sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])
# Count the values
cnt <- length(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])
cnt  # 68994
# 25 percent of values
cnt_p25 <- cnt * 0.25
cnt_p25  # 17248.5
# Index of 25th percentile
idx_p25 <- trunc(cnt_p25) + 1  # truncate the fractional part and add 1
idx_p25  # 17249
# Sort all values and get the value of the element with the index
p25 <- sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])[idx_p25]
p25  # 80

# Calculate the median (50%) manually
idx_p50_n1 <- cnt/2
idx_p50_n1  # 34497
idx_p50_n2 <- cnt/2 + 1
idx_p50_n2  # 34498
sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])[c(idx_p50_n1, idx_p50_n2)]  # 80 80
# First 10
head(sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])[idx_p25:idx_p50_n2], 10)  # 80 80 80 ...
# Last 10
tail(sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])[idx_p25:idx_p50_n2], 10)  # 80 80 80 ...
