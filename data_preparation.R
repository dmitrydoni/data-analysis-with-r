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