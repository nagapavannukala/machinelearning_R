## Author: Rajesh Jakhotia
## Company Name: K2 Analytics Finishing School Pvt. Ltd
## Email : ar.jakhotia@k2analytics.co.in
## Website : k2analytics.co.in

rm(list = ls())
setwd ("C:/Users/nagapavan/Desktop/great lakes/R/classroom")
getwd()


## Let us import the data that we need to perform the Market Basket Analysis
?getwd
?read.table
RTxn <- read.table("Market_Basket_Analysis.csv", sep = ",", header = T)
nrow(RTxn)

View(RTxn)

str(RTxn)
RTxn$Invoice_No <- as.factor(RTxn$Invoice_No)


nlevels(RTxn$SKU_Code)
nlevels(RTxn$Item_Desc)

levels(RTxn$Item_Desc) -> list()



## Aggregating the Invoices at Transaction Level
## We want one row per transaction. 
## The one row should have details of all the products purchased in that transaction
?split
Agg.RTxn <- split(RTxn$Item_Desc,RTxn$Invoice_No)
class(Agg.RTxn)
Agg.RTxn

## To see specific row number transaction
Agg.RTxn[1]


##install.packages("arules")
library(arules)

Agg.RTxn_DD <- list()
for (i in 1:length(Agg.RTxn)) {
  Agg.RTxn_DD[[i]] <- as.character(Agg.RTxn[[i]][!duplicated(Agg.RTxn[[i]])])
}
  
Txns <- as(Agg.RTxn_DD,"transactions")
Txns
summary(Txns)

inspect(Txns[10])


## Let us see the support
freq <- itemFrequency(Txns)
class(freq)
freq <- freq[order(-freq)]

freq["Bread"]

barplot( freq[1:20] )

?itemFrequencyPlot
itemFrequencyPlot(Txns, support = 0.10)
itemFrequencyPlot(Txns, topN = 10)


##install.packages("arulesViz")
library("arulesViz")
?apriori
arules1 <- apriori(data = Txns)
summary(arules1)

## See the Association Rules
inspect(arules1)

inspect(sort(arules1, by = "lift") )


arules2 <- apriori(data = Txns, 
            parameter = list(support = 0.05, confidence = 0.5, maxlen = 2 )
            )

summary(arules2)
##inspect(arules2)
inspect(sort(arules2, by = "lift")[1:30] )



#Scatter plot of rules:
library("RColorBrewer")
plot(arules2,control=list(
      col=brewer.pal(11,"Spectral")),
      main="Association Rules Plot"
     )
#freq["Dahi"]# support
#unique(RTxn$Invoice_No)

#totinvoices <- nlevels(RTxn$Invoice_No)
 #Dahi <- counT(Rtxn [ "Dahi"])



#Rules with high lift typically have low support.


## Plot Interactivee Graphs
subrules2 <- head(sort(arules2, by="support"), 20)
plot(subrules2, method="grouped" , interactive=TRUE )

#Plot graph-based visualisation:
plot(subrules2, method="graph",control=list(type="items",main=""))
inspect(subrules2)

plot(subrules2, method="grouped" , interactive=TRUE )

rules_df <- as(arules2,"data.frame")
rules_df$lhs_support <- rules_df$support / rules_df$confidence;
rules_df$rhs_support <- rules_df$confidence / rules_df$lift;
View(rules_df)
write.table(rules_df, file = "mba_output.csv", sep = "," , append = F, row.names = F)
unlink("mba_output.csv")





arules3 <- apriori(data = Txns, 
                   parameter = list(support = 0.05, confidence = 0.5, maxlen = 3 )
)

summary(arules3)
##inspect(arules2)
inspect(sort(arules3, by = "lift")[1:30] )

unique_count(RTxn$Item_Desc)
