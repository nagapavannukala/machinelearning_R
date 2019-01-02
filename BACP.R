# Saving data in time series format #
?ts
USGDP <- ts(US_GDP[,2], start=c(1929,1),end = c(1992,1) ,frequency=1) 
USGDP <- ts(US_GDP[,2], start=c(1929,1),frequency=1)# frequency =1 for yearly interval
plot(USGDP)
##  in the data, 1980 is missing so when we specify the end as 1992, due to 1 missing datapoint,
# it allocates the last datapoint (1992) = 0 {Since, ts converts ordinary dataset into timeseries
# with frequency =1}
Shoe <- ts(Shoe_Sales[,3], start=c(2011,1), frequency=12)
plot(Shoe)
# Here data starts from 2011 January. So we keep (2011,1)indicating January as '1'.frequency as 12
# shows  that the months are considered.

Income <- ts(Quarterly_Income[,3], start=c(2000,4), frequency=4)
plot(Income)
# Now we imported a data in which the time interval is quarterly. SO the frequency = 4
Champagne <- ts(Champagne[,2], start=c(1964, 1), frequency=12)
plot(Champagne)
# In the above data, the year and month are specified in the 1st column.So,the data is in 2nd column
# and frequency is in terms of months i.e., frequency =12
AirPax <- ts(AirPassenger[,2], start=c(1949, 1), frequency=12)
plot(AirPax)
# It's same as that of the previous data

# Plot for seasonality
monthplot(Champagne)
monthplot(AirPax)
monthplot(Income)

# monthplot is not only used to determine the seasonality of months but also the seasonality 
# of other seasonal factors.Since, we mentioned the frequency before , it accordingly gives 
# average of the seasonal components of all years considered (for example, champagne plot gives 
# the average of each month i.e., average of all januaries of years considered. )

## For better deduction, keep both plots in a window,and try to explain the relationship.
par(mfrow=c(1,2))
plot(Champagne)
monthplot(Champagne)
plot(AirPax)
monthplot(AirPax)
plot(Income)
monthplot(Income)


# Import Bond_yield data#
# Convert to a timeseries object explicitly stating start and end points and frequency

BY <- ts(Bond_Yield[,-1],start = c(1900,1),end = c(1970,1),frequency = 1)
plot(BY)
# Moving Average with different periods.
# install.packages(forecast)
library(forecast)
BY3 <- ma(BY,order= 3)
BY5 <-ma(BY,order= 5)
BY9 <- ma(BY,order= 9)
BY15 <-ma(BY,order= 15)
BY19 <- ma(BY,order= 19)
BY41 <- ma(BY,order= 41)
BY51 <- ma(BY,order= 51)
par(mfrow=c(1,1))
?ts.plot
ts.plot(BY,BY3,BY9,BY19,BY5,BY15,BY41,BY51,lty=c(1:8),col= c('black','red','dark blue','forest green','green','yellow','orange','magenta'))


?stl
# TS decomposition 
IncDec<-stl(Income[,1], s.window='p') #constant seasonality
plot(IncDec) # the right sid erectangle determines the scale.The smaller the rectangle,the more is 
# the range / interval of the value.

IncDec

IncDec7<-stl(Income[,1], s.window=7) #seasonality changes
plot(IncDec7)
IncDec7


ch7<- stl(Champagne[,1], s.window=7, robust=T) # seasonality changes
plot(ch7,main = "7")
ch7


ch5<- stl(Champagne[,1], s.window=5, robust=T)
plot(ch5,main="5")
ch5



ch2<- stl(Champagne[,1], s.window=2, robust=T)
plot(ch2,main="2")
ch2


DeseasonRevenue <- (IncDec7$time.series[,2]+IncDec7$time.series[,3])
ts.plot(DeseasonRevenue, Income, col=c("red", "blue"), main="Comparison of Revenue and Deseasonalized Revenue")

# From the original series, if we remove the seasonality value(i.e., only considering Trend +irregularity)
# In the same way, the sum of Seasonality ad Irregularity(i.e., removing the Trend from the original series-> Detrending revenue.)

# stl function is developed for additive time series not multiplicative.So,we used logarithmic here.


# Analysis of a multiplicative series
logAirPax <- log(AirPax[,1])
logAirPaxDec <- stl(logAirPax, s.window="p")
logAirPaxDec$time.series[1:12,1]
AirPaxSeason <- exp(logAirPaxDec$time.series[1:12,1])
plot(AirPaxSeason, type="l")
plot(logAirPaxDec)
# Here we used log because it converts multiplication into addition i.e., 
# x= abc -> logx = loga +lobg +logc

#or 
plot(decompose(AirPax,type = "multiplicative")) # 'm' means multiplicative (which we got to know through the increase in 
# the variance of seasonality)  {stl works better than decompose function.}


# Dividing a time series into train and test
IncomeTrain <- window(Income, start=c(2000,4), end=c(2012,4), frequency=4)
IncomeTest <- window(Income, start=c(2013,1), frequency=4)

# Model fit and forecast
IncTrn7<-stl(IncomeTrain, s.window=7)
fcst.Inc.stl <- forecast(IncTrn7, method="rwdrift", h=5)

Vec<- cbind(IncomeTest,fcst.Inc.stl$mean)
ts.plot(Vec, col=c("blue", "red"), main="Quarterly Income: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE

# Exponential smooting
#install.packages("fpp2")
Library(fpp2)
?ses # h- number of periods for forecasting.
fcoil <- ses(oil, h=3)
fcoil # Lo80 & Hi80 gives the 80% confidence interval values. 
plot(oil)
plot(fcoil)
names(fcoil)
fcoil$model

#Simple exponential smoothing 

#Call:
 # ses(y = oil, h = 3) 

#Smoothing parameters:
 # alpha = 0.9999 

#Initial states:
 # l = 110.8832 

#sigma:  49.0507

#AIC     AICc      BIC 
#576.1569 576.6903 581.8324 
fcoil$mean # gives the forecasted values including year.
fcoil$level # confidence levels
fcoil$fitted # gives the forecasted data after weighting(one step forecasts), generally it is the next observation in the original data.
fcoil$method # simple or optimal exponential smoothing.
fcoil$x  #  x is the original value.
fcoil$series # the data considered
fcoil$residuals
plot(fcoil$residuals) # the residual or the difference between the forecast and the original


# Seasonality is included.Champagne dataset is taken.

library(readxl)
Champagne <- read_excel("Champagne.xlsx")
View(Champagne)
Champagne <- ts(Champagne[,2], start=c(1964, 1), frequency=12)
new <- hw(Champagne,h=24) # In case of Seasonality ,  we should give 'h' atleast 1 total seasonal counts(i.e., 1 year.here h is the month)
plot(new)
new$model

# when we actually forecast develop a test and train data and develop a model.

# Now let's try with multiplicative seasonality.


library(readxl)
AirPassenger <- read_excel("AirPassenger.xlsx")
View(AirPassenger)
# Here test data we can  keep 24 months



AirPax <- ts(AirPassenger[,2], start=c(1949, 1), frequency=12)


AirPax1 <- window(AirPax, start=c(1949,1), end=c(1958,12))
AirPaxHO <- window(AirPax, start=c(1959,1), end=c(1960,12))

AirPax.fc <- hw(AirPax1,seasonal = "m",h=24)

plot(AirPax.fc)
AirPax.fc$model
AirPax.fc$mean

#alpha = 0.3477 
#beta  = 2e-04 
#gamma = 0.6519 

Vec<- cbind(AirPaxHO,AirPax.fc$mean)
ts.plot(Vec, col=c("blue", "red"), main="Quarterly Income: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE   #0.07314531


# to get better combination that gives least MAPE

AirPax.fc <- hw(AirPax1,seasonal = "m",alpha =0.03,beta = 0.002,gamma = 0.001,h=24)

Vec<- cbind(AirPaxHO,AirPax.fc$mean)
ts.plot(Vec, col=c("blue", "red"), main="Quarterly Income: Actual vs Forecast")
MAPE <- mean(abs(Vec[,1]-Vec[,2])/Vec[,1])
MAPE   #0.03314312


## For final predicting we need to use the total data as train and give the alpha,beta,gamma 
# which were ideal upon observing.

AirPax.fclast <- hw(AirPax,seasonal = "m",alpha =0.03,beta = 0.002,gamma = 0.001,h=12)
# Now we used that model to predict 1961's data
plot(AirPax.fclast)
AirPax.fclast$mean





Champ1 <- window(Champagne, start=c(1964,1), end=c(1970,12))
ChampHO <- window(Champagne, start=c(1971,1), end=c(1972,9))

Champ.fc <- hw(Champ1, h=21)

Champ1.stl <- stl(Champ1, s.window = 5)
fcst.Champ1.stl <- forecast(Champ1.stl, method="rwdrift", h=21)

# Stationarity & ARIMA
BASF <- ts(GermanMonthlyAverageStockPrice[,9], start=c(1981,1), frequency=12)
library(tseries)
adf.test(BASF) 

acf(BASF, lag = 50)

BASF.arima.fit <- arima(BASF, c(1, 1, 0))
BASF.arima.fit

Box.test(BASF.arima.fit$residuals, lag=30, type="Ljung-Box")

plot(forecast(BASF.arima.fit, h=6))

