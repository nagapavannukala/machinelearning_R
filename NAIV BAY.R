library(e1071)

library(tm)


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





View(df_dtm_subset)

train = df_dtm_subset[1:3000,]
test = df_dtm_subset[3001:nrow(df_dtm_subset),]
model_naive <- naiveBayes(sentiment ~ ., data = train)
test$predict_sentiment = predict(model_naive , test%>%select(-sentiment))
table(test$predict_sentiment,test$sentiment)

library(caret)


confusionMatrix(test$predict_sentiment,test$sentiment)

#########################feature selection


top_words = words_freq %>%filter(! words  %in% c('@hotstartweets','app','hotstar','@hotstarhelps'))%>% arrange(-freq) %>% head(25)

df_dtm_subset = df_dtm[,top_words$words]
dim(df_dtm_subset)
df_dtm_subset$sentiment = hot$Sentiment_Manual

dim(df_dtm_subset)

#################################### CHecking once again

train = df_dtm_subset[1:3000,]
test = df_dtm_subset[3001:nrow(df_dtm_subset),]
model_naive <- naiveBayes(sentiment ~ ., data = train)
test$predict_sentiment = predict(model_naive , test%>%select(-sentiment))
table(test$predict_sentiment,test$sentiment)

library(caret)


confusionMatrix(test$predict_sentiment,test$sentiment)

##View(predict(model_naive , test%>%select(-sentiment), type="raw"))
 


            
## trending of sentiment


test$date = hot$Created_Date[3001:nrow(hot)]
head(hot$Created_Date)                     

library(ggplot2)
hot$Created_Date = as.Date(hot$Created_Date , format = '%m/%d/%Y')
hot %>% 
  group_by(Created_Date ,Sentiment_Manual ) %>%
  summarise(count=n()) %>%ggplot(aes(x=Created_Date , y = count , fill= Sentiment_Manual)) +geom_bar(stat = 'identity')


hot %>% 
  group_by(Created_Date ,Sentiment_Manual ) %>%
  summarise(count=n()) %>%ggplot(aes(x=Created_Date , y = count , group= Sentiment_Manual,color= Sentiment_Manual)) +geom_line(stat = 'identity')






## stat = identity should be given when we have calculated fields. if we have some categoricalcolumns , we need not give that as it defaultly counts the frequency and gives the graph.
## ggplot(hotstar,aes())

## here we , need to get count of each type of tweet on each day.






                     #
#----- Bi-gram Analysis (Two words together)
#install.packages("rJava")

install.packages("RWeka")
install.packages("rJava")
library(RWeka)
library(rJava)
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre-10.0.2')

BigramTokenizer = function(x) NGramTokenizer(x, Weka_control(min=2, max=2))
dtm_bigram = DocumentTermMatrix(docs, control = list(tokenize=BigramTokenizer))
df_dtm_bigram = as.data.frame(as.matrix(dtm_bigram))
colnames(df_dtm_bigram)[1:10]

x=colSums(df_dtm_bigram)
bigrams_words_freq = data.frame(words=labels(x), freq=x)
bigrams_words_freq %>%arrange(-freq) %>% head(10)

bigrams_negative = c()
bigrams_positive = c()

negative_words = c('poor','waste','bad','not','defective','disgusting','dont',
                   'untrusty','worst')

positive_words = c('good', 'awesome','worth','like','best','nice',
                   'amazing', 'fantastic')

for (bigram in bigrams_words_freq$words){
  words = unlist(strsplit(bigram,' ')) ## --- Using unlist to make it vector or flat file instead of list
  match_negatives = intersect(negative_words, words)
  match_positives = intersect(positive_words, words)
  if(length(match_negatives)>0){
    bigrams_negative = c(bigrams_negative, bigram)
  }
  if(length(match_positives)>0){
    bigrams_positive = c(bigrams_positive, bigram)
  }
}

length(bigrams_positive)

length(bigrams_negative)


x= colSums(df_dtm_bigram[,bigrams_negative])
bigrams_negative_freq = data.frame(words=labels(x), freq=x)
bigrams_negative_freq %>% arrange(-freq) %>% head(20)


###### Word Similarity
install.packages("lsa")
library(lsa)
View(df_dtm)
cosine(df_dtm [,''] , df_dtm [,'']) # similarity b/w book and kindle
cosine(as.vector(df_dtm[100,]) , as.vector(df_dtm [300,]))

words_similar = function(word , df_dtm){}

words_similar ('work' , df_dtm)




similar_words = function(word, df_dtm){
  result = data.frame(Word1 = character(), Word2 = character(), cosine_val = numeric())
  for (col in colnames(df_dtm)){
    if (word != col)
    {
      x = cosine(df_dtm[,col], df_dtm[,'episode'])
      temp = data.frame(word, col, x)
      result = rbind(result, temp)
    }
  }
  colnames(result) = c("Word", "COLUMNS", "COSINE_VAL")
  result %>% arrange(-COSINE_VAL) %>% head(25)
}

similar_words('episode', df_dtm)
                     