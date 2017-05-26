#tutorial used: https://rlbarter.github.io/superheat-examples/Word2Vec/

#function for computing the pairwise cosine similarity
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


library(knitr)
library(dplyr)
library(reshape2)
library(cluster)
library(ggplot2)

library(RTextTools)

library(tm)
# Extract the title from each article entry
##ncdata_problemdescr <- as.character(ncdata$`Problem descr`)
##ncdata_problemdescr <- ncdata$`Problem descr`
ncdata_problem <- ncdata[,'Problem descr']

# convert the headline titles to a tm corpus
ncdata_corp <- Corpus(VectorSource(ncdata_problem))

#use the TM package to remove punctuation, numbers, whitespace and stop words. Besides that, the content is transformed to lowercase.
ncdata_corp <- tm_map(ncdata_corp, content_transformer(tolower))
ncdata_corp <- tm_map(ncdata_corp, removePunctuation)
ncdata_corp <- tm_map(ncdata_corp, removeNumbers)
ncdata_corp <- tm_map(ncdata_corp, stripWhitespace)
ncdata_corp <- tm_map(ncdata_corp, removeWords, stopwords("english"))

#WORD FREQUENCY AND DOCUMENT TERM MATRIX TO SELECT MOST COMMON WORDS
#convert to a document term matrix
dtm <- DocumentTermMatrix(ncdata_corp)
#here the word counts per column (word) are calculated
freq <- colSums(as.matrix(dtm))   
freq.df <- data.frame(word = names(freq), count = freq) %>%
  arrange(desc(count))
#show 20 most frequent words
kable(head(freq.df, 20))

#only select the 1000 words which are most common
common.words <- names(sort(freq, decreasing = TRUE))[1:1000]

#CREATE MODEL USING ORIGINAL PLUGIN
#save problem descriptions in binary file
writeLines(as.character(ncdata_corp), con="ncdata_corp")

#library used: https://github.com/mukul13/rword2vec
model=word2vec(train_file = "ncdata_corp",output_file = "vec.bin",binary=1)

#CONVERT MODEL TO WORD MATRIX
bin_to_txt("vec.bin","vector.txt")
distance_matrix=as.data.frame(read.table("vector.txt",skip=1, stringsAsFactors = FALSE, fill = TRUE))
# fill = TRUE to prevent Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  :line 1 did not have 102 elements
class(distance_matrix[1,1])

#EDIT DISTANCE MATRIX
# the first column contains the words so we want to set the row names accordingly
rownames(distance_matrix) <- distance_matrix[,1]
# and then remove the first column
distance_matrix <- distance_matrix[,-1]

colnames(distance_matrix) <- c(1:101)

write.table(distance_matrix, "mydata.txt", sep="\t")

distance_matrix <- distance_matrix[1:100,]
distance_matrix <- distance_matrix[-c(4),]
distance_matrix <- distance_matrix[1:20,]
distance_matrix <- distance_matrix[forty.most.commmon.words, ]

forty.most.commmon.words <- common.words[1:40][common.words[1:40] %in% rownames(distance_matrix)]
length(forty.most.commmon.words)

cosine.similarity <- CosineSim(t(distance_matrix[,]))
head(cosine.similarity)
diag(cosine.similarity) <- NA

#only install when executing this script for the first time
#devtools::install_github("rlbarter/superheat")
library(superheat)
superheat(cosine.similarity, 
          
          # place dendrograms on columns and rows 
          row.dendrogram = T, 
          col.dendrogram = T,
          
          # make gridlines white for enhanced prettiness
          grid.hline.col = "white",
          grid.vline.col = "white",
          
          # rotate bottom label text
          bottom.label.text.angle = 90)


#_________________________________
# select the 40 most common words
forty.most.commmon.words <- common.words[1:40]
cosine.similarity <- CosineSim(t(data[forty.most.commmon.words, ]))

diag(cosine.similarity) <- NA

superheat(cosine.similarity, 
          
          # place dendrograms on columns and rows 
          row.dendrogram = T, 
          col.dendrogram = T,
          
          # make gridlines white for enhanced prettiness
          grid.hline.col = "white",
          grid.vline.col = "white",
          
          # rotate bottom label text
          bottom.label.text.angle = 90)


#full similarity matrix for creating word clouds
cosine.similarity.full <- CosineSim(t(common.words))



