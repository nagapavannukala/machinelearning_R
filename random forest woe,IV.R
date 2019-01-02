rm(list = ls())
setwd("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()

data <- read.csv("DEV_SAMPLE.csv",stringsAsFactors = TRUE)
str(data)
summary(data)

# outlier treatment
boxplot(data$Balance)(# THERE ARE OUTLIERS)
maxbal <- mean(data$Balance)+1.5*IQR(data$Balance)
maxbal
#[1] 429230.5
data$Balance <- ifelse(data$Balance > maxbal,maxbal,data$Balance)
boxplot(data$Balance)


#install.packages("devtools")
library(devtools)

#install_github("tomasgreif/riv","tomasgreif",force=TRUE)

library(woe)

iv <- iv.mult(data[,!names(data)%in% c("Cust_ID")],"Target",TRUE)
iv
iv.plot.summary(iv)


iv <- iv.mult(data,"Target",vars = data[c("Gender","Balance","Occupation","No_OF_CR_TXNS","AGE_BKT","SCR","")])


iv <- iv.mult(data,"Target",vars = c("Gender","Balance","Occupation","No_OF_CR_TXNS","AGE_BKT","SCR","Holding_Period"))


quantile(data$Balance, 
         c(0.01, 0.05, 0.1, 0.25, 0.50, 0.75, 0.90, 0.95, 0.99, 1))

  


boxplot(data$Balance) 


  