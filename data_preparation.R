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
