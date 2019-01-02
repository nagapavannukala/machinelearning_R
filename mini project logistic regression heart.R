data = read.csv("Heart.csv", stringsAsFactors = FALSE)

head(data)

summary(data)

data = data[-1]



data[!complete.cases(data),]  # --------------- Shows rows with null values.

data_na = na.omit(data)
head(data_na)

data_na[!complete.cases(data_na),]

summary(data_na)

data_na$AHD[data_na$AHD == "Yes"] = 1
data_na$AHD[data_na$AHD == "No"] = 0

attach(data_na)

AHD = as.integer(AHD)
Sex = factor(Sex)
ChestPain = factor(ChestPain)
Fbs = factor(Fbs)
RestECG = factor(RestECG)
ExAng = factor(ExAng)
Slope = factor(Slope)
Ca = factor(Ca)
Thal = factor(Thal)




f = glm(AHD ~ ., data=data_na[1:13], family = 'binomial')

summary.glm(f)

predprob = predict(f,data_na[1:13],type='response')

temp = as.data.frame(data_na)

temp$predprob = predprob



probTh = 0.5

temp$predCW = rep(0,nrow(temp))

temp$predCW[temp$predprob > probTh] = 1

succssPct = sum(temp$predCW == temp$AHD)/nrow(temp)*100

temp$predCW = as.integer(temp$predCW)

## -------- library(caret) for confusion matrix
library(caret)

ConfMat = confusionMatrix(table(temp$AHD, temp$predCW),mode = "prec_recall")
ConfMat



probTHA = seq(0.1, 1, length.out = 25)

resultDf = data.frame()
for(row_i in 1:length(probTHA)){
  
  probTh = probTHA[row_i]
  temp$predCW = rep(0,nrow(temp))
  temp$predCW[temp$predprob > probTh] = 1
  succPct = sum(temp$predCW == temp$AHD)/nrow(temp)*100
  tempDf = data.frame(probTh,succPct)
  if(nrow(resultDf) != 0){
    resultDf = rbind(resultDf,tempDf)
  }else{
    resultDf = tempDf
  }
}

plot(resultDf$probTh, resultDf$succPct, type = 'l')

table(temp$AHD)




