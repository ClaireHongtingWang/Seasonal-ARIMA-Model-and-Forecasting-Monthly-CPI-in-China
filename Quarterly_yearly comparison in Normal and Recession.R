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