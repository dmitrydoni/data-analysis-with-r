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
# First 10 elements
head(sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])[idx_p25:idx_p50_n2], 10)  # 80 80 80 ...
# Last 10 elements
tail(sort(cardio$ap_lo[cardio$ap_lo<200 & cardio$ap_lo>20])[idx_p25:idx_p50_n2], 10)  # 80 80 80 ...

# Prepare a cleansed dataset for analysis
# Use function filter(), %>% from package dplyr to get a dataset without outliers
cardio_tidy_set <- cardio %>% filter((ap_lo<200 & ap_lo>20) & (ap_hi<300 & ap_hi>40))
head(cardio_tidy_set, 3)
# Compare dimensions in raw and "tidy" (cleansed) datasets
dim(cardio)  # 70000 14
dim(cardio_tidy_set)  # 68781 14
nrow(cardio)  # 70000
nrow(cardio_tidy_set)  # 68781
ncol(cardio)  # 14
ncol(cardio_tidy_set)  # 14
# Compare mean and standard deviation in raw and "tidy" (cleansed) datasets
mean(cardio$ap_hi)  # 128.8
mean(cardio_tidy_set$ap_hi)  # 126.6
sd(cardio$ap_hi)  # 154.0
sd(cardio_tidy_set$ap_hi)  # 16.8

# Visualize the raw and cleansed datasets as histograms
# In the cleansed dataset, the distributions look more like normal
mypar(2,2)
hist(cardio$ap_hi, main="High Pressure", xlab = "aphi_cardio", ylab="Frequency")
hist(cardio_tidy_set$ap_hi, main="High Pressure (Cleansed)", xlab = "aphi_cardio_tidy", ylab="Frequency")
hist(cardio$ap_lo, main="Low Pressure", xlab = "aplo_cardio", ylab="Frequency")
hist(cardio_tidy_set$ap_lo, main="Low Pressure (Cleansed)", xlab = "aplo_cardio_tidy", ylab="Frequency")

# Visualize the cleansed dataset as Q-Q plot
mypar(1,2)
# Sample & theoretical quantiles for low pressure
qqnorm(cardio_tidy_set$ap_lo, main="Low Pressure (Cleansed)")
qqline(cardio_tidy_set$ap_lo, col="red", lwd=2)
# Sample & theoretical quantiles for high pressure
qqnorm(cardio_tidy_set$ap_hi, main="High Pressure (Cleansed)")
qqline(cardio_tidy_set$ap_hi, col="red", lwd=4)
abline(h=160, col="green")  # horizontal line shows where the quantiles go apart

# Compare the high and low pressure by gender (1 = F, 2 = M)
mypar(1,2)
# Split low pressure values by gender
groups_gender_lo <- split(cardio_tidy_set$ap_lo, cardio_tidy_set$gender)
str(groups_gender_lo)
boxplot(groups_gender_lo)  # low pressure is not different for men and women
title("Low Pressure")
# Split high pressure values by gender
groups_gender_hi <- split(cardio_tidy_set$ap_hi, cardio_tidy_set$gender)
str(groups_gender_hi)
boxplot(groups_gender_hi)  # high pressure is not different for men and women
title("High Pressure")

# Density plot for high pressure and low pressure
# Expected: normal distrubution with a single spike
plot(density(cardio_tidy_set$ap_lo), col=1, lwd=2, main="Low Pressure")
plot(density(cardio_tidy_set$ap_hi), col=3, lwd=2, main="High Pressure")
# In fact, the charts show skewed distributions with several spikes

# Figure out the reason why there are spikes
mypar(1,1)
plot(density(cardio_tidy_set$ap_lo), col="1", lwd=2, main="Low Pressure")
abline(v=70, col="red")  # spike at 70
abline(v=60, col="red")  # spike at 60
abline(v=80, col="red")  # spike at 80
sort_lo <- sort(cardio_tidy_set$ap_lo)
cut_1 <- sort_lo[sort_lo>65 & sort_lo<75]
tail(cut_1, 20)
# As seen, the spikes are the result of rounding to 60, 70, 80, etc.

# Normal distributions for low pressure and high pressure on one chart
plot(density(cardio_tidy_set$ap_lo, adjust = 20), col=1, lwd=2, main="Low & High Pressure")
lines(density(cardio_tidy_set$ap_hi, adjust = 20), col=3, lwd=2, lty=2)  # dashed line
legend("topright", c("ap_lo","ap_hi"), col=c(1,3), lty = c(1,2))

# Scatter plot to find correlation between
plot(cardio_tidy_set$ap_lo,
     cardio_tidy_set$ap_hi,
     col = 5,  # color
     main=paste("correlation = ",
                signif(
                  cor(cardio_tidy_set$ap_lo, cardio_tidy_set$ap_hi), # correlation
                  2
                )
     )
)

# Scatter plot with genders
plot(cardio_tidy_set$ap_hi,
     cardio_tidy_set$ap_lo,
     pch=22,  # ?point
     bg=as.numeric(factor(cardio_tidy_set$gender)),
     xlab = "Low Pressure",
     ylab= "High Pressure"
)
legend("bottomright",
       levels(factor(cardio_tidy_set$gender)),
       col=seq(along=levels(factor(cardio_tidy_set$gender))),
       pch=22,
       cex=1.1
)

# Scatter plot with other features
plot(cardio_tidy_set$weight,
     cardio_tidy_set$height,
     pch=21,
     bg= as.numeric(factor(cardio_tidy_set$gender)),
     xlab = "Weight",
     ylab= "Height")
legend("topright",
       levels(factor(cardio_tidy_set$gender)),
       col=seq(along=levels(factor(cardio_tidy_set$gender))),
       pch=19,
       cex=1.1)

# Scatter plot for other features
head(cardio_tidy_set)
miniset <- cardio_tidy_set[,3:5]
head(miniset)
nrow(miniset)  # 68781
plot(miniset, pch=21, bg=miniset$gender)
plot(miniset$gender, miniset$weight, pch=21, bg=miniset$gender)

# Bar plot
bp <- barplot(sort(cardio_tidy_set$gender),
              horiz = T,
              main = "Bar plot example")
text(bp, format(sort(cardio_tidy_set$gender)))
