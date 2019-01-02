# Import Auto.xlsx #
library(car)
### Import German credit data
German_Credit = readxl::read_xlsx("D:/courses/DSE/Regression/BlrMay18/German Credit.xlsx", sheet = 'Sheet1')

with(German_Credit, plot(`Credit Amount`, Creditability, pch=19, col="darkblue", main="Scatterplot of Binary Y"))
with(German_Credit, hist(`Credit Amount`))

b <- seq(0, 80, 10)

with(German_Credit, hist(`Duration of Credit (month)`, breaks = b))

cutpoint <- c(0, 500, 1000,1500,2000, 2500, 5000, 7500, 10000, 15000, 20000)

Credit_cat <- cut(German_Credit$`Credit Amount`, cutpoint, right=T)
table(Credit_cat)
(Table1<-table(Credit_cat, German_Credit$Creditability))

(Table2 <- prop.table(Table1,1))
(Table3 <- cbind(Table2, table(Credit_cat)))

fit.logistic <- glm(German_Credit$Creditability~German_Credit$'Credit Amount')
summary.glm(fit.logistic)


fit.logistic <- glm(German_Credit$Creditability~German_Credit$'Credit Amount', family=binomial(link=logit))
summary.glm(fit.logistic)

fit2.logistic <- glm(German_Credit$Creditability~German_Credit$`Duration of Credit (month)`, family=binomial(link=logit))
summary.glm(fit2.logistic)

Duration_cat <- cut(German_Credit$`Duration of Credit (month)`, b, right=T)
table(Duration_cat)
(Table4<-table(Duration_cat, German_Credit$Creditability))
(Table5 <- prop.table(Table4,1))
(Table6 <- cbind(Table5, table(Duration_cat)))

fit2.logistic <- glm(German_Credit$Creditability~German_Credit$`Duration of Credit (month)`, family=binomial(link=logit))
summary.glm(fit2.logistic)

fit3.logistic <- glm(Creditability~., data=German_Credit, family=binomial(link=logit))
summary.glm(fit3.logistic)
