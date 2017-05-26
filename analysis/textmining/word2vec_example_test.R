library(knitr)
library(dplyr)
library(reshape2)
library(cluster)
library(ggplot2)

library(RTextTools)
# The NYTimes dataset can be extracted from the RTextTools package
data(NYTimes)
# view the first 6 rows
kable(head(NYTimes, 3))

library(tm)
# Extract the title from each article entry
nyt.headlines <- as.character(NYTimes$Title)
# convert the headline titles to a tm corpus
nyt.corpus <- Corpus(VectorSource(nyt.headlines))

# convert to lowercase
nyt.corpus <- tm_map(nyt.corpus, content_transformer(tolower))
# remove punctuation
nyt.corpus <- tm_map(nyt.corpus, removePunctuation)
# remove numebrs
nyt.corpus <- tm_map(nyt.corpus, removeNumbers)
# remove whitespace
nyt.corpus <- tm_map(nyt.corpus, stripWhitespace)
# remove stop words
nyt.corpus <- tm_map(nyt.corpus, removeWords, stopwords("english"))

# convert to a dtm
dtm <- DocumentTermMatrix(nyt.corpus)
# calculate the word counts
freq <- colSums(as.matrix(dtm))   
freq.df <- data.frame(word = names(freq), count = freq) %>%
  arrange(desc(count))
# view the 10 most frequent words
kable(head(freq.df, 10))

# obtain the 1000 most common words in the New York Times headlines
common.words <- names(sort(freq, decreasing = TRUE))[1:1000]

# identify the 40 most common words from the NY Times headlines that are also in the Google News corpus
forty.most.commmon.words <- common.words[1:40]
length(forty.most.commmon.words)
## [1] 35

CosineFun <- function(x, y){
  # calculate the cosine similarity between two vectors: x and y
  c <- sum(x*y) / (sqrt(sum(x * x)) * sqrt(sum(y * y)))
  return(c)
}

CosineSim <- function(X) {
  # calculate the pairwise cosine similarity between columns of the matrix X.
  # initialize similarity matrix
  m <- matrix(NA, 
              nrow = ncol(X),
              ncol = ncol(X),
              dimnames = list(colnames(X), colnames(X)))
  cos <- as.data.frame(m)
  
  # calculate the pairwise cosine similarity
  for(i in 1:ncol(X)) {
    for(j in i:ncol(X)) {
      co_rate_1 <- X[which(X[, i] & X[, j]), i]
      co_rate_2 <- X[which(X[, i] & X[, j]), j]  
      cos[i, j] <- CosineFun(co_rate_1, co_rate_2)
      # fill in the opposite diagonal entry
      cos[j, i] <- cos[i, j]        
    }
  }
  return(cos)
}

# calculate the cosine similarity between the forty most common words
cosine.similarity <- CosineSim(t(GoogleNews.common[forty.most.commmon.words, ]))








