library(car)
German_Credit = readxl::read_xlsx("German Credit.xlsx")
typeof(German_Credit)
plot(German_Credit$`Credit Amount`,Creditability)
cutpoint<-c(0, 500, 1000,1500,2000, 2500, 5000, 7500, 10000, 15000, 20000)
Credit_cat<-cut(German_Credit$`Credit Amount`, cutpoint, right=T)
table(Credit_cat)
(Table1<-table(Credit_cat, German_Credit$Creditability))

(Table2 <- prop.table(Table1,1))
(Table3 <- cbind(Table2,table(Credit_cat)))
?prop.table

(fit.logistic = glm(formula = German_Credit$Creditability~ German_Credit$"Credit Amount",
    family = binomial(link = logit)))
newdata = data.frame("Credit Amount" = 2000,"")

predProb = predict.glm(fit.logistic,newdata ,type = "response")
German_Credit =  as.data.frame(German_Credit)
German_Credit$predProb = predProb
probTh = 0.51
# predProb > probTh  CW =1
# predProb <= probTh  CW =0
German_Credit$predCW = rep(0,nrow(German_Credit))
German_Credit$predCW [German_Credit$predProb > probTh]=1
succssPct =sum(German_Credit$predCW == German_Credit$Creditability)/nrow(German_Credit)*100

probThA = seq(0.1,1,length.out = 25)
resultDf = data.frame()
 for(row_i in 1:probThA){
   probTh = probThA[row_i]
   German_Credit$predCW = rep(0,nrow(German_Credit))
   German_Credit$predCW [German_Credit$predProb > probTh]=1
   succssPct =sum(German_Credit$predCW == German_Credit$Creditability)/nrow(German_Credit)*100
   tempDf = data.frame(probTh,succssPct)
   if(nrow(resultDf)!=0){
     resultDf = rbind(resultDf,tempDf)
   }else{
     resultDf = tempDf
   }
    }
plot(resultDf$probTh , resultDf$succssPct,type = "l")
#
table(German_Credit$Creditability)





# OR
tempInfo = summary.glm(fit.logistic)
b1 = tempInfo$coefficients[2]
b0 = tempInfo$coefficients[1]
CAmount = 500000
numerator = exp(b0 + b1*CAmount)
dm = 1 + exp(b0 + b1*CAmount)
 numerator/dm
)
userPredict <- function(CAmount){
  numerator = exp(b0 + b1*CAmount)
  dm = 1 + exp(b0 + b1*CAmount)
  return(numerator/dm)
}
userPredict(10000

summary.glm(fit.logistic)



## DURATION TIME :

plot(Duration of Credit (month),Creditability)
cutpoint<-c(0,7,14,21,28,35,42,49,56,63,70,77)
Duration_cat<-cut(German_Credit$`Duration of Credit (month)`, cutpoint, right=T)
table(Duration_cat)
(Table1<-table(Duration_cat, German_Credit$Creditability))

(Table2 <- prop.table(Table1,1))
(Table3 <- cbind(Table2,table(Duration_cat)))

(fit.logistic = glm(formula = German_Credit$Creditability~ German_Credit$`Duration of Credit (month)`,
                    family = binomial(link = logit)))



tempInfo = summary.glm(fit.logistic)
b1 = tempInfo$coefficients[2]
b0 = tempInfo$coefficients[1]



userPredict <- function(Duration){
  numerator = exp(b0 + b1*Duration of Credit (month))
  dm = 1 + exp(b0 + b1*Duration of Credit (month))
  return(numerator/dm)
}
userPredict(30)