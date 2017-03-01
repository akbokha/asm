# Only execute the commented statements if you have not installed these packages before
# install.packages("tm")
# install.packages("SnowballC")
# install.packages("wordcloud")

library(tm)
library(SnowballC)
library(wordcloud)

ncdata_corp <- Corpus(VectorSource(ncdata$`Problem descr`))
# convert corpus to plain text document
ncdata_corp <- tm_map(ncdata_corp, PlainTextDocument)

#remove punctuation and stopwords
ncdata_corp <- tm_map(ncdata_corp, removePunctuation)
ncdata_corp <- tm_map(ncdata_corp, removeWords, stopwords('english'))

#stemming of words
#ncdata_corp < tm_map(ncdata_corp, stemDocument)

ncdata_corp <- Corpus(VectorSource(ncdata_corp))
#plot wodcloud
wordcloud(ncdata_corp, min.freq=30, max.words=50, random.order=TRUE, ordered.colors = TRUE, use.r.layout = TRUE)