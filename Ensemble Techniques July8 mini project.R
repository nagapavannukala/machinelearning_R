rm(list = ls())
setwd("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()

#Importing the dataset 
hr <- read.csv("HR_Employee_Attrition_Data.csv")
str(hr)

# Target Column is Attrition  Changing the "Yes"/"No" column into 1/0
hr$Attrition = as.character(hr$Attrition)
hr$Attrition[hr$Attrition == "Yes"] = 1
hr$Attrition[hr$Attrition == "No"] = 0
hr$Attrition = as.numeric(hr$Attrition)
str(hr)

#Splitting the Data into Train and Test
  
set.seed(9)

n <- nrow(hr)
shuffled_hr <- hr[sample(n), ]
train_indices <- 1:round(0.7 * n)
hr.dev <- shuffled_hr[train_indices, ]
test_indices <- (round(0.7 * n) + 1):n
hr.holdout <- shuffled_hr[test_indices, ]



dev<-  hr.dev
holdout <-  hr.holdout
library(gbm)
?gbm

set.seed(1212)
gbmFit <- gbm(
  formula           = Attrition~.,
  distribution      = "adaboost",
  data              = hr.dev ,
  n.trees           = 50, # number of trees or iterations
  cv.folds          = 10, # do 10-fold cross-validation
  shrinkage         = 1,  # shrinkage or learning rate
  bag.fraction      = 1 # OOB DATA WILL NOT BE THERE
)


## Print the gbm Fit summary
print(gbmFit)


# Get the Best No. of Iterations using cross-validation
best.iter <- gbm.perf(gbmFit,method="cv")
print(best.iter)

summary(gbmFit, n.trees = best.iter)

head(hr.dev)


hr.dev$predict.score <- predict( 
  gbmFit, newdata=hr.dev[,-2],
  n.trees = best.iter,type = "response")

View(hr.dev)
class(hr.dev$predict.score)


## deciling code
decile <- function(x){
  deciles <- vector(length=10)
  for (i in seq(0.1,1,.1)){
    deciles[i*10] <- quantile(x, i, na.rm=T)
  }
  return (
    ifelse(x<deciles[1], 1,
           ifelse(x<deciles[2], 2,
                  ifelse(x<deciles[3], 3,
                         ifelse(x<deciles[4], 4,
                                ifelse(x<deciles[5], 5,
                                       ifelse(x<deciles[6], 6,
                                              ifelse(x<deciles[7], 7,
                                                     ifelse(x<deciles[8], 8,
                                                            ifelse(x<deciles[9], 9, 10
                                                            ))))))))))
}


## deciling
hr.dev$deciles <- decile(hr.dev$predict.score)

library(data.table)

tmp_DT = data.table(hr.dev)


rank <- tmp_DT[, list(
  cnt = length(Attrition), 
  cnt_resp = sum(Attrition), 
  cnt_non_resp = sum(Attrition == 0)) , 
  by=deciles][order(-deciles)]

rank$rrate <- round(rank$cnt_resp * 100 / rank$cnt,2);
rank$cum_resp <- cumsum(rank$cnt_resp)
rank$cum_non_resp <- cumsum(rank$cnt_non_resp)
rank$cum_perct_resp <- round(rank$cum_resp * 100 / sum(rank$cnt_resp),2);
rank$cum_perct_non_resp <- round(rank$cum_non_resp * 100 / sum(rank$cnt_non_resp),2);
rank$ks <- abs(rank$cum_perct_resp - rank$cum_perct_non_resp);

View(rank)

library(ROCR)
pred <- prediction(hr.dev$predict.score, hr.dev$Attrition)
perf <- performance(pred, "tpr", "fpr")
plot(perf)
KS <- max(attr(perf, 'y.values')[[1]]-attr(perf, 'x.values')[[1]])
auc <- performance(pred,"auc"); 
auc <- as.numeric(auc@y.values)

library(MLmetrics)
gini = Gini(hr.dev$predict.score, hr.dev$Attrition)
# auc and concordance numbers are same.
auc
KS
gini


hr.holdout$predict.score <- 
  predict( gbmFit,newdata=hr.holdout[,-2],
           n.trees = best.iter, type = "response")
hr.holdout$deciles <- decile(hr.holdout$predict.score)

## Ranking code
##install.packages("data.table")
library(data.table)
tmp_DT = data.table(hr.holdout)
h_rank <- tmp_DT[, list(
  cnt = length(Attrition), 
  cnt_resp = sum(Attrition), 
  cnt_non_resp = sum(Attrition == 0)) , 
  by=deciles][order(-deciles)]
h_rank$rrate <- round(h_rank$cnt_resp * 100 / h_rank$cnt,2);
h_rank$cum_resp <- cumsum(h_rank$cnt_resp)
h_rank$cum_non_resp <- cumsum(h_rank$cnt_non_resp)
h_rank$cum_perct_resp <- round(h_rank$cum_resp * 100 / sum(h_rank$cnt_resp),2);
h_rank$cum_perct_non_resp <- round(h_rank$cum_non_resp * 100 / sum(h_rank$cnt_non_resp),2);
h_rank$ks <- abs(h_rank$cum_perct_resp - h_rank$cum_perct_non_resp);

View(h_rank)



pred <- prediction(hr.holdout$predict.score, hr.holdout$Attrition)
perf <- performance(pred, "tpr", "fpr")
plot(perf)
KS_h <- max(attr(perf, 'y.values')[[1]]-attr(perf, 'x.values')[[1]])
auc_h <- performance(pred,"auc"); 
auc_h <- as.numeric(auc_h@y.values)
gini_h = Gini(hr.holdout$predict.score, hr.holdout$Attrition)


auc_h
KS_h
gini_h

auc
KS
gini












#### We begin the GBM Model Tuning in this section ####

## Import the Data again. 
## Because of previous steps predict.score column got added
#hr.dev <- read.table("DEV_SAMPLE.csv", sep = ",", header = T,
#                       colClasses = c("Cust_ID"="character"))
#hr.holdout <- read.table("HOLDOUT_SAMPLE.csv", sep = ",", header = T,
 #                          colClasses = c("Cust_ID"="character"))

## Create Grid Search Dataframe
?expand.grid
hyper_grid <- expand.grid(
  shrinkage = c(0.3, 1),  ## You may try more shrinkage parameters
  interaction.depth = c(1, 3), ## You may try more interaction depth
  bag.fraction = c(.8, 1), ## You may try with different values
  n.minobsinnode = c(10), ## You may try different Min Obs combinations
  optimal_trees = NA,  # a parameter to capture iteration results
  valid_error = NA     # a parameter to capture iteration results
)

View(hyper_grid)


library(gbm) 
set.seed(1212) ## Set the seed to ensure reproducibility

start_time<-proc.time() ## Start Process Time
for(i in 1:nrow(hyper_grid)) { ## grid search
  gbm.tune <- gbm(
    formula = Attrition~.,
    distribution =  "adaboost",
    data =dev,
    n.trees = 50,
    interaction.depth = hyper_grid$interaction.depth[i],
    shrinkage = hyper_grid$shrinkage[i],
    n.minobsinnode = hyper_grid$n.minobsinnode[i],
    bag.fraction = hyper_grid$bag.fraction[i],# Since all these values are defined by us, we are giving the data here from the hypergrid where we created.
    train.fraction = .75,
    cv.folds  = 10
  )
  best.iter <- gbm.perf(gbm.tune,method="cv")
  hyper_grid$optimal_trees[i] <- best.iter 
  hyper_grid$valid_error[i] <- gbm.tune$valid.error[best.iter]
}
end_time<-proc.time() ## End Process Time
proc_time=end_time - start_time
proc_time ## Total Process Time


head(hyper_grid, 8)

opt_iter_rn <- which(
  hyper_grid$valid_error==min(hyper_grid$valid_error))

opt_iter_rn

hyper_grid[opt_iter_rn,]


gbmFit <- gbm(
  formula           = Attrition~.,
  distribution      = "adaboost",
  data              =  dev ,
  shrinkage = hyper_grid$shrinkage[opt_iter_rn],
  interaction.depth = hyper_grid$interaction.depth[opt_iter_rn],# Now we gave the optimal Interaction Depth we got from previous code.
  n.minobsinnode = hyper_grid$n.minobsinnode[opt_iter_rn] ,
  bag.fraction = hyper_grid$bag.fraction[opt_iter_rn] ,
  n.trees = hyper_grid$optimal_trees[opt_iter_rn],
  train.fraction = .75,
  cv.folds          = 10
);
print(gbmFit)



# check performance using  cross-validation
gbm.perf(gbmFit,method="cv")
# To get the relative variable importance
summary(gbmFit)




library(ModelPerformance)

dev$predict.score <- predict(gbmFit, newdata=dev, type = "response")


dev$decile = ModelPerformance::decile(dev$predict.score)
rank <- ModelPerformance::ROTable(dev, "Attrition", "predict.score")

View(rank)


holdout$predict.score <- predict( 
  gbmFit, newdata=holdout, type = "response")


holdout$decile = ModelPerformance::decile(holdout$predict.score)
rank <- ModelPerformance::ROTable(holdout, "Attrition", "predict.score")
View(rank)

?ROTable

ModelPerformance::concordance(holdout,"Attrition","predict.score")
auc ## Both auc and concordance numbers are approximately same











## RANDOM FOREST TECHNIQUE:
## Let us first set the working directory path
rm(list=ls())
setwd ("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()


## Building the model using Random Forest

## importing the data
hr <- read.csv("HR_Employee_Attrition_Data.csv")
str(hr)

# Target Column is Attrition  Changing the "Yes"/"No" column into 1/0
hr$Attrition = as.character(hr$Attrition)
hr$Attrition[hr$Attrition == "Yes"] = 1
hr$Attrition[hr$Attrition == "No"] = 0
hr$Attrition = as.numeric(hr$Attrition)
str(hr)

#Splitting the Data into Train and Test

set.seed(9)

n <- nrow(hr)
shuffled_hr <- hr[sample(n), ]
train_indices <- 1:round(0.7 * n)
hr.dev <- shuffled_hr[train_indices, ]
test_indices <- (round(0.7 * n) + 1):n
hr.holdout <- shuffled_hr[test_indices, ]



dev<-  hr.dev
holdout <-  hr.holdout
c(nrow(hr.dev), nrow(hr.holdout))

##install.packages("randomForest")
library(randomForest)
?randomForest
View(hr.dev)
## Calling syntax to build the Random Forest
RF <- randomForest(as.factor(Attrition) ~ ., data = hr.dev, 
                   ntree=501, mtry = 3, nodesize = 10,
                   importance=TRUE)


print(RF)

plot(RF, main="Random forest")
legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest RFDF.dev")


head(RF$err.rate)

## List the importance of the variables.
impVar <- round(randomForest::importance(RF), 2)
impVar[order(impVar[,3], decreasing=TRUE),]


?tuneRF
## Tuning Random Forest
tRF <- tuneRF(x = hr.dev[,-c(2)], 
              y=as.factor(hr.dev$Attrition),
              mtryStart = 3, 
              ntreeTry=101, 
              stepFactor = 1.5, 
              improve = 0.0001, 
              trace=TRUE, 
              plot = TRUE,
              doBest = TRUE,
              nodesize = 10, 
              importance=TRUE
)

tRF
tRF$importance


View(hr.dev)
## Scoring syntax
hr.dev$predict.class <- predict(tRF, hr.dev, type="class")
hr.dev$predict.score <- predict(tRF, hr.dev, type="prob")
head(hr.dev)
class(hr.dev$predict.score)

## deciling
## deciling code
decile <- function(x){
  deciles <- vector(length=10)
  for (i in seq(0.1,1,.1)){
    deciles[i*10] <- quantile(x, i, na.rm=T)
  }
  return (
    ifelse(x<deciles[1], 1,
           ifelse(x<deciles[2], 2,
                  ifelse(x<deciles[3], 3,
                         ifelse(x<deciles[4], 4,
                                ifelse(x<deciles[5], 5,
                                       ifelse(x<deciles[6], 6,
                                              ifelse(x<deciles[7], 7,
                                                     ifelse(x<deciles[8], 8,
                                                            ifelse(x<deciles[9], 9, 10
                                                            ))))))))))
}


hr.dev$deciles <- decile(hr.dev$predict.score[,2])


library(data.table)
tmp_DT = data.table(hr.dev)
rank <- tmp_DT[, list(
  cnt = length(Attrition), 
  cnt_resp = sum(Attrition), 
  cnt_non_resp = sum(Attrition == 0)) , 
  by=deciles][order(-deciles)]
rank$rrate <- round (rank$cnt_resp / rank$cnt,2);
rank$cum_resp <- cumsum(rank$cnt_resp)
rank$cum_non_resp <- cumsum(rank$cnt_non_resp)
rank$cum_rel_resp <- round(rank$cum_resp / sum(rank$cnt_resp),2);
rank$cum_rel_non_resp <- round(rank$cum_non_resp / sum(rank$cnt_non_resp),2);
rank$ks <- abs(rank$cum_rel_resp - rank$cum_rel_non_resp);


library(scales)
rank$rrate <- percent(rank$rrate)
rank$cum_rel_resp <- percent(rank$cum_rel_resp)
rank$cum_rel_non_resp <- percent(rank$cum_rel_non_resp)

View(rank)

sum(hr.dev$Attrition) / nrow(hr.dev)


library(ROCR)
pred <- prediction(hr.dev$predict.score[,2], hr.dev$Attrition)
perf <- performance(pred, "tpr", "fpr")
plot(perf)
KS <- max(attr(perf, 'y.values')[[1]]-attr(perf, 'x.values')[[1]])
KS

## Area Under Curve
auc <- performance(pred,"auc"); 
auc <- as.numeric(auc@y.values)
auc

## Gini Coefficient
#library(ineq)
install.packages("MLmetrics")
library(MLmetrics)
?MLmetrics
?Gini
gini = Gini(hr.dev$predict.score[,2], hr.dev$Attrition)
gini

## Classification Error
with(hr.dev, table(Attrition, predict.class))


## Scoring syntax
hr.holdout$predict.class <- predict(tRF, hr.holdout, type="class")
hr.holdout$predict.score <- predict(tRF, hr.holdout, type="prob")

hr.holdout$deciles <- decile(hr.holdout$predict.score[,2])

tmp_DT = data.table(hr.holdout)
h_rank <- tmp_DT[, list(
  cnt = length(Attrition), 
  cnt_resp = sum(Attrition), 
  cnt_non_resp = sum(Attrition == 0)) , 
  by=deciles][order(-deciles)]
h_rank$rrate <- round (h_rank$cnt_resp / h_rank$cnt,2);
h_rank$cum_resp <- cumsum(h_rank$cnt_resp)
h_rank$cum_non_resp <- cumsum(h_rank$cnt_non_resp)
h_rank$cum_rel_resp <- round(h_rank$cum_resp / sum(h_rank$cnt_resp),2);
h_rank$cum_rel_non_resp <- round(h_rank$cum_non_resp / sum(h_rank$cnt_non_resp),2);
h_rank$ks <- abs(h_rank$cum_rel_resp - h_rank$cum_rel_non_resp);


library(scales)
h_rank$rrate <- percent(h_rank$rrate)
h_rank$cum_rel_resp <- percent(h_rank$cum_rel_resp)
h_rank$cum_rel_non_resp <- percent(h_rank$cum_rel_non_resp)

View(h_rank)










