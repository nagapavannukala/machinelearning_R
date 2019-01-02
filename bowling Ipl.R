## Author: Rajesh Jakhotia
## Company Name: K2 Analytics Finishing School Pvt. Ltd
## Email : ar.jakhotia@k2analytics.co.in
## Website : k2analytics.co.in

## Let us find the clusters in given Retail Customer Spends data
## Hierarchical Clustering

## Let us first set the working directory path and import the data
par(mfrow=c(1,1))
setwd ("D:/K2Analytics/datafile")
getwd()

ib<- read.csv("IPLBowling.csv", header=TRUE)
View(ib)

ir <- 1/ib$Runs
ia <- 1/ib$Ave
ie <- 1/ib$Econ
is <- 1/ib$SR
ib<-cbind(ib,ir,ia,ie,is)
View(ib)
 ib<-ib[,-c(2,4,5,7,8,9,10,11)]
 View(ib)
 
#{
 
 ib$is <- as.character(ib$is)
 ib$is[ib$is == "Inf"] <- "0"
 ib$ia <- as.character(ib$ia)
 ib$ia[ib$ia == "Inf"] <- "0"
 View(ib)
 
ib <- ib[ib$ia != "Inf",]
View(ib)
}

ib$is <- as.numeric(ib$is)
ib$ia <- as.numeric(ib$ia)

?dist  ## to get help on distance function
d.euc <- dist(x=ib[,2:7], method = "euclidean") 
d.euc

## we will use the hclust function to build the cluster
?hclust  ## to get help on hclust function

clus1 <- hclust(d.euc, method = "average")
plot(clus1, labels = as.character(ib[,1]))

## scale function standardizes the values
scaled.ib <- scale(ib[,2:7])
head(scaled.ib, 10)

d.euc <- dist(x=scaled.ib, method = "euclidean") 
d.euc

clus2 <- hclust(d.euc, method = "average")
plot(clus2, labels = as.character(ib[,1]))
rect.hclust(clus2, k=3, border="red")
clus2$height

View(ib)
## profiling the clusters
ib$Clusters <- cutree(clus2, k=3)
aggr = aggregate(ib[,-c(1)],list(ib$Clusters),mean)
clus.profile <- data.frame( Cluster=aggr[,1],
                            Freq=as.vector(table(ib$Clusters)),
                            aggr[,-1])
## aggregating based on continuous variables considering the mean

View(clus.profile)








## K Means Clustering


KRCDF <- read.csv("IPLBAT.csv", header=TRUE)
## scale function standardizes the values
scaled.ib <- scale(KRCDF[3:11])

##KRCDF <- read.csv("datafiles/KBD.csv", header=TRUE)
##scaled.RCDF <- scale(KRCDF[,2:3])
View(scaled.ib)
class(scaled.ib)
## code taken from the R-statistics blog
## http://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/

## Identifying the optimal number of clusters form WSS

wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var)) # sum of variances of columns(var-variances)
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

wssplot(scaled.ib, nc=5)

## Identifying the optimal number of clusters
##install.packages("NbClust")

library(NbClust)
?NbClust

set.seed(1234)
nc <- NbClust(KRCDF[,c(-1,-13,-14)], min.nc=2, max.nc=4, method="kmeans")
table(nc$Best.n[1,])

barplot(table(nc$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters Chosen by 26 Criteria")


?kmeans
kmeans.clus = kmeans(x=scaled.ib, centers = 3, nstart = 25)
kmeans.clus

tmp <- as.data.frame(scaled.ib)
tmp$Clusters <- kmeans.clus$cluster
View(tmp)
## plotting the clusters
##install.packages("fpc")
library(fpc)
plotcluster(scaled.ib, kmeans.clus$cluster)

# More complex
library(cluster)
?clusplot
clusplot(scaled.ib, kmeans.clus$cluster, 
         color=TRUE, shade=TRUE, labels=2, lines=1)

## profiling the clusters
KRCDF$Clusters <- kmeans.clus$cluster
View(KRCDF)
aggr = aggregate(KRCDF[,-c(1,13,14)],list(KRCDF$Clusters),mean)
clus.profile <- data.frame( Cluster=aggr[,1],
                            Freq=as.vector(table(KRCDF$Clusters)),
                            aggr[,-1])

View(clus.profile)

