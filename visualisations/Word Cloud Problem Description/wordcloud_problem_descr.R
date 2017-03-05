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

#Make all the words lower case
ncdata_corp <- tm_map(ncdata_corp, tolower)

#remove punctuation and stopwords
ncdata_corp <- tm_map(ncdata_corp, removePunctuation)
ncdata_corp <- tm_map(ncdata_corp, removeWords, stopwords('english'))

#stemming of words
#ncdata_corp < tm_map(ncdata_corp, stemDocument)

#remove words that are common in the problem description box, but are not of value
#examples: 2013, onecomm, call, cause et cetera

common_words <- c("2013", "number", "changed", "call", "onecomm", "2014", "issue",
                  "call", "cause", "number", "changed", "during", "jan", "feb", "mar", "apr",
                  "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec", "rootcause", 
                  "problem", "open", "can", "due", "one", "line", "used", "need", "following",
                  "needs", "will", "karl", "found")
remove <- data.frame(common_words)
ncdata_corp <- tm_map(ncdata_corp, removeWords, remove$common_words)

#plot wodcloud
ncdata_corp <- Corpus(VectorSource(ncdata_corp))
#plot wordcloud -> colors
pal <- brewer.pal(8,"Dark2")
#actual plotting of the wordcloud
wordcloud(ncdata_corp, min.freq=30, max.words=80, use.r.layout = TRUE,
          colors=pal, scale = c(6, 0.8, 1.8))