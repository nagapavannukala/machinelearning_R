# Function: evaluation metrics
## True positives (TP) - Correctly idd as success
## True negatives (TN) - Correctly idd as failure
## False positives (FP) - success incorrectly idd as failure
## False negatives (FN) - failure incorrectly idd as success
## Precision - 
P = TP/(TP+FP) how many idd actually success/failure
## Recall - 
R = TP/(TP+FN) how many of the successes correctly idd
## F-score - F = (2 * P * R)/(P + R) harm mean of precision and recall
prf <- function(predAct){
  ## predAct is two col dataframe of pred,act
  preds = predAct[,1]
  trues = predAct[,2]
  xTab <- table(preds, trues)
  clss <- as.character(sort(unique(preds)))
  r <- matrix(NA, ncol = 7, nrow = 1, 
              dimnames = list(c(),c('Acc',
                                    paste("P",clss[1],sep='_'), 
                                    paste("R",clss[1],sep='_'), 
                                    paste("F",clss[1],sep='_'), 
                                    paste("P",clss[2],sep='_'), 
                                    paste("R",clss[2],sep='_'), 
                                    paste("F",clss[2],sep='_'))))
  r[1,1] <- sum(xTab[1,1],xTab[2,2])/sum(xTab) # Accuracy
  r[1,2] <- xTab[1,1]/sum(xTab[,1]) # Miss Precision
  r[1,3] <- xTab[1,1]/sum(xTab[1,]) # Miss Recall
  r[1,4] <- (2*r[1,2]*r[1,3])/sum(r[1,2],r[1,3]) # Miss F
  r[1,5] <- xTab[2,2]/sum(xTab[,2]) # Hit Precision
  r[1,6] <- xTab[2,2]/sum(xTab[2,]) # Hit Recall
  r[1,7] <- (2*r[1,5]*r[1,6])/sum(r[1,5],r[1,6]) # Hit F
  r}