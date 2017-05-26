#only execute commands below if you have not installed the specific packages before
#install.packages("devtools")
#solve bug: Installation failed: Problem with the SSL CA cert (path? access rights?)
#install.packages("httr")
#library(devtools)
#install_github("mukul13/rword2vec")
#install.packages("tm")

library(rword2vec)
ls("package:rword2vec")

#credits to worldcloud_problem_descr.R from Abdel
library(tm)


#ncdata_problem <- ncdata[1:100,'Problem descr']
ncdata_problem <- ncdata[,'Problem descr']

ncdata_corp <- Corpus(VectorSource(ncdata_problem))
inspect(ncdata_corp)

#save problem descriptions in binary file
writeLines(as.character(ncdata_corp), con="ncdata_corp")

#library used: https://github.com/mukul13/rword2vec
model=word2vec(train_file = "ncdata_corp",output_file = "vec.bin",binary=1)

#CONVERT MODEL TO WORD MATRIX
bin_to_txt("vec.bin","vector.txt")
distance_matrix=as.data.frame(read.table("vector.txt",skip=1, fill = TRUE)) # fill = TRUE to prevent Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  :line 1 did not have 102 elements


distance_matrix <- na.omit(distance_matrix)
write.table(distance_matrix, "mydata2.txt", sep="\t")


distance_matrix[1:5,1:2]
head(distance_matrix)



#________________________

#CALCULATE DISTANCE FOR ONE WORD
dist=distance(file_name = "vec.bin",search_word = "ROOTCAUSE",num = 20)
dist

##WORD COUNT
vocab_count(file_name="ncdata_corp",vocab_file="vocab.txt",min_count = 20)
d=read.table("vocab.txt")
head(d)

##CONVERT WORDS TO PHRASES
word2phrase(train_file = "ncdata_corp",output_file = "vec1.txt")
### use this new text file to give word vectors
modelPhrase=word2vec(train_file = "vec1.txt",output_file = "vec2.bin",binary=1)
bin_to_txt("vec2.bin","vector2.txt")
