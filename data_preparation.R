# install.packages("cluster")
library(cluster)  # load installed package
data()  # view data sets in package ‘cluster’
?votes.repub  # view the description of the data set

head(votes.repub, 5)  # show the first 5 rows (if omited, 6 rows by default)
tail(votes.repub)  # show the last 6 rows (default)
str(votes.repub)  # structure of the data set (50 observations, 31 variables)
dim(votes.repub)  # dimensions (50 rows, 31 columns)
votes.repub[1:5, 1:4]  # only specific rows (1 through 5) and columns (1 through 4)

colMeans(votes.repub, na.rm = TRUE)  # column means, remove NA
rowMeans(votes.repub)  # row means

votes.repub[, 30] # column 30 has no missing values
repub30_mean <- mean(votes.repub[, 30])
repub30_mean  # 62.7

if(mean(votes.repub[, 30]) > 60){
  print("Republicans got more than 60% votes")
}else{
  print("Republicans got less than 60% votes")
}

votes.repub[, 7] # column 7 has missing values
repub7_mean <- mean(votes.repub[, 7])
repub7_mean  # NA
repub7_mean_na <- mean(votes.repub[, 7], na.rm = TRUE)
repub7_mean_na  # 47.9

if(mean(votes.repub[, 7], na.rm = TRUE) > 60){
  print("Republicans got more than 60% votes")
}else{
  print("Republicans got less than 60% votes")
}

x<-c(3, 0, 0, 0, 1, 0)
x
?ifelse # conditional element selection
ifelse(x!=0, "Yes", "No")  # "Yes" "No"  "No"  "No"  "Yes" "No"

ifelse(colMeans(votes.repub, na.rm = TRUE)>60,
       "Republicans got more than 60% votes",
       "Republicans got less than 60% votes")

getwd()  # get working directory

dat<-read.csv("datn.csv")
head(dat)
dim(dat)
str(dat)

dat$d.date

unique(dat$ball)  # unique balls
unique(dat$price)  # unique prices

datn<-dat[,-1]  # remove column X
datn
head(datn, 5)

# install.packages("lubridate")
library(lubridate)  # load installed package

class(datn$d.date)  # "character"
datn$d.date

dayn<-ymd(datn$d.date)
class(dayn)  # "Date"
dayn

year(dayn)  # 2018

# What was the total price of balls sold on the 1st of January?
datn$price[day(ymd(datn$d.date))==1]  # all orders on Jan 1: 90 90 90 390 ...
sum(datn$price[day(ymd(datn$d.date))==1])  # total: 6250

f.1<-function(d){
  sum(datn$price[day(ymd(datn$d.date))==d])
}

f.1(1)  # 6250

f.2<-function(d){
  t<-sum(datn$price[day(ymd(datn$d.date))==d])
  return(t)
}

f.2(1)  # 6250

# Functions capply(), tapply()

search()  # list packages (R searches in this order)

# Monte Carlo simulation

# install.packages("dplyr")
library(dplyr)  # load installed package

# pipe operator
iris %>% dim  # 150   5
iris %>% filter(Species=="versicolor")

a<-c(1,2,3)
b<-c(0,0,0)

nm<-paste0(seq(1,3), "_", "row")
nm  # "1_row" "2_row" "3_row"

# Data frames
df.1<-data.frame(a, b, row.names = nm)
df.1

# CSV files
write.csv(df.1, file = "november.csv")

df<-read.csv("november.csv")
class(df)  # "data.frame"
df

head(read.csv("cardio_train.csv"))
head(read.csv2("cardio_train.csv"))

