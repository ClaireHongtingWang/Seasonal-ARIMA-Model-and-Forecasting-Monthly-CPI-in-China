rm(list = ls())
install.packages("xlsx")
install.packages("readxl")


library("pracma")
library("tseries")
library("aTSA")
library('forecast')
library(dplyr)
library(tidyr)
library("readxl")
library(readr)

filename <- read.table('~/Desktop/ECON 515 Project/filename.txt', header = T)
setwd("~/Desktop/ECON 515 Project/original_data")
getwd()
list.files(full.names = TRUE, recursive = TRUE)
arimaresult <- list()
arimacoef <- list()
armacoef <- list()
LB_result_all <- data.frame()
model_forecast_all <- data.frame()
auto_forecast_all <- data.frame()
filename_all <- data.frame()
adf_result <- list()
adf_all <- list()


i <- 1
for(i in 65){
  
  #Load data#
  CPI <- read.csv(paste0(filename$x[i],'.csv'))
  cpi <- ts(CPI$CPI_adjusted, start=c(1995,1), frequency = 12)
  
  dscpi <- diff(cpi, lag = 12, differences = 1)
  dfcpi <- diff(dscpi, lag = 1, differences = 1)
  
  
  adf <- adf.test(dfcpi)
  adf_result <- list(adf_result,adf)
  
  cat('\n\n\n\n')
  
  ##choose ARIMA model
  armasearch <- function(x){
    armacoef <- data.frame()
    ###Try different range of p, q, P, Q
    for (p in 0:6){
      for (q in 0:6){
        for(P in 0:2){
          for(Q in 0:2){
            try({x.arma = arima(x, order=c(p,1,q), seasonal=list(order=c(P,1,Q),period=12))
            armacoef <- rbind(armacoef, c(p,q,P,Q,x.arma$aic))},silent = TRUE)
          }
        }
      }
    }
    colnames(armacoef) <- c("p","q","P","Q","AIC")
    pos <- which (armacoef$AIC==min(armacoef$AIC))
    p = armacoef$p[pos]
    q = armacoef$q[pos]
    P = armacoef$P[pos]
    Q = armacoef$Q[pos]
    para = list(p,q,P,Q)
    return (para)
  }
  
  
  
  
  result <- armasearch(cpi)
  n <- length(cpi)
  p <- result[[1]]
  q <- result[[2]]
  P <- result[[3]]
  Q <- result[[4]]
  
  #store result of ARIMA
  arimadfcpi <- Arima(cpi, order = c(p,1,q),seasonal=list(order=c(P,1,Q), period=12))
  arimaresult <- list(arimaresult,arimadfcpi)
  arimacoef <- list(arimacoef,arimadfcpi$coef)
  LB_result <- Box.test(arimadfcpi$residuals, lag = min(2*12,n/5),type = c("Ljung-Box"), fitdf = p + q)
  LB_result_df <- data.frame(LB_result$p.value)
  LB_result_all <- rbind(LB_result_all,LB_result_df)
  
  
  filename_all <- rbind(filename_all, filename[i,])
  
  
  ###Compare quarterly and yearly updates
  model_forecast = forecast(arimadfcpi,h = 3,level = 95)
  model_forecast_df <- data.frame(model_forecast)
  model_forecast_all = rbind(model_forecast_all,model_forecast_df)
  forecast <- ts(model_forecast_all$Point.Forecast, start=c(2020,3),end = c(2021,9),frequency = 12)
  actual <- CPI$CPI_adjusted[62:68]
  actual <-  ts(actual, start=c(2004,12), frequency = 12)
  
  plot(forecast)
  points(actual,pch = 1,col = 'red')
  
  auto_model <- auto.arima(cpi)
  auto_forecast <- forecast(auto_model,  h = 3,level = 95)
  auto_forecast_df <- data.frame(auto_forecast)
  auto_forecast_all = rbind(auto_forecast_all,auto_forecast_df)
  
  cat('finish forecast for ',filename$x[i], '\n', sep = '')
  cat('\n\n\n\n')
  
}

write.csv(model_forecast_all,"~/Desktop/ECON 515 Project/p, q = 6/recession model_forecast_all.csv", row.names = TRUE)

model_forecast
write.csv(model_forecast,'yearly.csv')
getwd()

# Quarterly and yearly comparison in Normal
Normal_QY_Actual <- ts(data = Normal_quar_year$Actual, start = c(2019,1), frequency = 12)
Normal_QY_quarterly <- ts(data = Normal_quar_year$Quarterly, start = c(2019,1), frequency = 12)
Normal_QY_yearly <- ts(data = Normal_quar_year$Yearly, start = c(2019,1), frequency = 12)
plot(Normal_QY_Actual, ylim=c(163,175), main = 'Quarterly_yearly comparison in Normal', 
     sub = 'MSE Querterly = 0.88 vs MSE yearly = 5.17')
points(Normal_QY_quarterly, pch = 1, col = 'blue')
points(Normal_QY_yearly, pch = 2, col = 'red')
legend("top", legend=c("Quarterly","Yearly"), col=c("blue","red"), 
       pch=c(1,2), ncol=2, cex=1, bty="n", x.intersp=0.4)

# Quarterly and yearly comparison in Recession
Recession_QY_Actual <- ts(data = Recession_quar_year$Actual, start = c(2019,1), frequency = 12)
Recession_QY_quarterly <- ts(data = Recession_quar_year$Quarterly, start = c(2019,1), frequency = 12)
Recession_QY_yearly <- ts(data = Recession_quar_year$Yearly, start = c(2019,1), frequency = 12)
plot(Recession_QY_Actual, ylim = c(168,175), main = 'Quarterly_yearly comparsion in Recession',
     sub = 'MSE Quarterly = 1.73 vs MSE yearly = 4.71')
points(Recession_QY_quarterly, pch = 1, col = 'blue')
points(Recession_QY_yearly, pch = 2, col = 'red')
legend("topright", legend=c("Quarterly","Yearly"), col=c("blue","red"), 
       pch=c(1,2), ncol=2, cex=1, x.intersp=0.2, text.width = 0.06)
