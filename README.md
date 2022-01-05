# Seasonal-ARIMA-Model-and-Forecasting-Monthly-CPI-in-China

Seasonal ARIMA Model and Forecasting Monthly CPI in China (using R)

# •	Overview
This is the term project I took in Time Series Analysis in my postgraduate studies at the University of Southern California in 2021 Fall.


# •	Background & Project Goal
The Consumer Price Index (CPI) forecast has received wide attention around the world due to its excellent reflection on the state of the economy. The reason we chose China as our study area is that China is the second-largest economy in the world, an important manufacturing country, and an important link in the global supply chain. Our project goal is to forecast the monthly CPI in China using data from 1995 to 2018.

# •	Data Sources
The monthly data from January 1995 to September 2021 are collected for our SARIMA model to predict China's CPI, and then to study the changes in China's macro price level. What we want most is CPI data with January 1995 as the base period, whose advantage is that it can more directly reflect the trend of China's macroeconomic growth.
However, there is no existing fixed-base CPI that can be selected without any preprocessing. Thus, we download the month-on-month data (last month=100), from the National Bureau of Statistics of China, and convert it into CPI with a fixed base (Jan 1995=100) with the following formula:  

CPI with a fixed base in this period = month-on-month CPI in this period * CPI with a fixed base in the last period. 

Then we have divided our data into training datasets from January 1995 to December 2018, where the last three months are the validation dataset and the testing datasets from January 2019 to September 2021. To be more specific, we regard the period of 2019 as the normal period and the period of 2020-2021 as the recession period, when COVID-19 happens.

# •	Methodology
i)	Seasonal ARIMA Model. 

ii)	Testing Stationery. 

iii)Model Identification and Estimation. 

iv)	Diagnostic Checking. 

v)	Model Forecasting and Accuracy Measures

vi)	Extension --- Time Series Split Cross-Validation for Robustness Check. 

# • Documents Explaination
Project.R: The code.

