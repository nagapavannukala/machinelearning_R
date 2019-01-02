rm(list = ls())
setwd("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()


#install.packages ("tm")##(y/n -> n)
library(tm)
#install.packages("wordcloud")
library(wordcloud)
tweets <- read.csv("C:/Users/nagapavan/Desktop/great lakes/R/classroom/narendramodi_tweets.csv")


dim(tweets)
docs = as.character(tweets$text)

str(tweets)
str(docs)
## create a corpus 
docs = VCorpus(VectorSource(docs))
docs

## clean the dataset{1.consists of transforming to upper/lower case
##                   2. removing special characters, numbers when we do not neeed
##                   3.Stop word removal: we can remove commonly used words (the, and,was,is, are,...
##                    white space removal,etc.,  )}

## the above mentioned are not standard transformations. we need to use them based on our necessity.
docs =  tm_map(docs,content_transformer(tolower)) # tm_map is a common function used to trransform many things.
## the above code trnsforms the data to lowercase.

inspect(docs[[1]])

docs =  tm_map(docs,stripWhitespace) 

dtm = DocumentTermMatrix(docs)

## Document Term Matrix
dtm = DocumentTermMatrix(docs)
dim(dtm)
## View(as.matrix(dtm))

df_dtm = as.data.frame(as.matrix(dtm))
View(df_dtm)
