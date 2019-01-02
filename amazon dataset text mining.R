rm(list = ls())
setwd("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()


#install.packages ("tm")##(y/n -> n)
library(tm)
#install.packages("wordcloud")
library(wordcloud)
ar <- read.csv("C:/Users/nagapavan/Desktop/great lakes/R/classroom/amazon_reviews_11.csv")


dim(ar)






regex_func = function(x){
  return (gsub('[^a-z0-9 $]','',x))
}

custom_stopwords = c()
common_stopwords = stopwords()
all_stop_words = c(custom_stopwords,common_stopwords)
docs = as.character(ar$reviewText)
docs = VCorpus(VectorSource((docs)))
docs = tm_map(docs , content_transformer(tolower))
docs = tm_map(docs , content_transformer(regex_func))
docs = tm_map(docs,removeWords , all_stop_words)
docs = tm_map(docs , stripWhitespace)
inspect(docs[[1]])

custom_stopwords = c('ive')
common_stopwords = stopwords()
all_stop_words = c(custom_stopwords,common_stopwords)
docs = tm_map(docs,removeWords , all_stop_words)


stopwords()


dtm = DocumentTermMatrix(docs)
df_dtm = as.data.frame(as.matrix(dtm))
dim(df_dtm)
x = colSums(df_dtm)
words_freq = data.frame(words = labels(x), freq =x)
words_freq %>% arrange(-freq) %>% head(80)


##words_freq %>% filter(! words %in% all_stop_words) %>% arrange(-freq) %>% head(50) ##

# %in%  -> to check the existence of an element in a list or dataframe
# %>% filter() to filter out  the existing words in () bracket # 
docs_length = rowSums(df_dtm)
View(docs_length)



library(wordcloud)
## wordclouds 
wordcloud(words_freq$words, words_freq$freq , min.freq = 45 ,random.order = F, random.color = T, colors = brewer.pal(name = 'Spectral',8) )

## Sentiment Analysis
##install.packages("RSentiment")
library(RSentiment)

calculate_score(c('i hate apple','i love terrorists','This is a sentence'))
calculate_sentiment(c('i hate apple','i love terrorists','This is a sentence'))
## in sentiment analysis , we need not create corpus for unsupervised.
## in supervised , we have to create corpus ....
ar$sentiment = calculate_sentiment(ar$reviewText)



####### SUPERVISED SENTIMENT ANALYSIS ################


hot<- read.csv("C:/Users/nagapavan/Desktop/great lakes/R/classroom/hotstar.allreviews_Sentiments.csv")
View(hot)

dim(hot)
str(hot)






regex_func = function(x){
  return (gsub('[^a-z0-9 $]','',x))
}

custom_stopwords = c()
common_stopwords = stopwords()
all_stop_words = c(custom_stopwords,common_stopwords)
docs = as.character(hot$Reviews)
docs = VCorpus(VectorSource((docs)))
docs = tm_map(docs , content_transformer(tolower))
docs = tm_map(docs , content_transformer(regex_func))
docs = tm_map(docs,removeWords , all_stop_words)
docs = tm_map(docs , stripWhitespace)
inspect(docs[[1]])


dtm = DocumentTermMatrix(docs)
df_dtm = as.data.frame(as.matrix(dtm))
dim(df_dtm)
x = colSums(df_dtm)
library(dplyr)
words_freq = data.frame(words = labels(x), freq =x)
words_freq %>% arrange(-freq) %>% head(25)





library(wordcloud)
## wordclouds 
wordcloud(words_freq$words, words_freq$freq , min.freq = 45 ,random.order = F, random.color = T, colors = brewer.pal(name = 'Spectral',8) )

top_words = words_freq %>% arrange(-freq) %>% head(25)

df_dtm_subset = df_dtm[,top_words$words]
dim(df_dtm_subset)

top_words$words
top_words$freq

df_dtm_subset$sentiment = hot$Sentiment_Manual # (It has all the documents.but 25 columns)

dim(df_dtm_subset)


## RANDOM FOREST
set.seed(123)
s <- sample(c(1:5053), size = 3500)
RFDF.dev <- df_dtm_subset[s,]
RFDF.holdout<- df_dtm_subset[-s,] 

c(nrow(RFDF.dev), nrow(RFDF.holdout))



##install.packages("randomForest")
library(randomForest)
?randomForest
View(RFDF.dev)
## Calling syntax to build the Random Forest
RF <- randomForest(RFDF.dev$sentiment ~ ., data = RFDF.dev[,-26], 
                   ntree=501, mtry = 3, nodesize = 10,
                   importance=TRUE)




print(RF)

plot(RF, main="Random forest")
legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest RFDF.dev")


RF$err.rate



## List the importance of the variables.
impVar <- round(randomForest::importance(RF), 2)
impVar[order(impVar[,3], decreasing=TRUE),]


?tuneRF
## Tuning Random Forest
tRF <- tuneRF(x = RFDF.dev[,-c(26)], 
              y=as.factor(RFDF.dev$sentiment),
              mtryStart = 3, 
              ntreeTry=101, 
              stepFactor = 1.5, 
              improve = 0.0001, 
              trace=TRUE, 
              plot = TRUE,
              doBest = TRUE,
              nodesize = 100, 
              importance=TRUE
)

tRF
tRF$importance


View(RFDF.dev)
## Scoring syntax
RFDF.dev$predict.class <- predict(tRF, RFDF.dev, type="class")
RFDF.dev$predict.score <- predict(tRF, RFDF.dev, type="prob")
head(RFDF.dev)
class(RFDF.dev$predict.score)


library(caret)
confusionMatrix(RFDF.dev$sentiment,RFDF.dev$predict.class)



## Scoring syntax
RFDF.holdout$predict.class <- predict(tRF, RFDF.holdout, type="class")
RFDF.holdout$predict.score <- predict(tRF, RFDF.holdout, type="prob")




library(caret)
confusionMatrix(RFDF.holdout$sentiment,RFDF.holdout$predict.class)


