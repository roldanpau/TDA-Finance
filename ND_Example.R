# Working directory is where this script is at.
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
source("TDA_Finance.R")

# Load required packages
library(quantmod)   # for getSymbols
library(TDA)        # for ripsDiag
library(PKNCA)      # for pk.calc.auc.all

#import an nd dimension time series as an xts object. 
#Here we use S&P 500 data from the specified dates
getSymbols("^GSPC", from="2016-01-01", to="2018-01-07", warnings = FALSE) 
data <- `GSPC`[,1:4]

#This calculates the norm of the data in one line.
#
#Implicitly, this is using the default values for parameters:
# - scaling is "log" which means that we will take the log of the data
# - returns = FALSE which means that we will NOT take log-returns 
#   of the price time series before processing it through TDA.
# - max_scale is defaulted to zero, which leads to estimating max_scale 
#   using the find_diam function.
# - K_max = 10.
# - window = 50.
#
#Thus, this is equivalent to:
# norm_data <- analyze_nd(data, scaling_method="log", returns = FALSE, 
# max_scale=0, K_max=10, window=50)
norm_data <- analyze_nd(data)

#Here we plot the norm
plot(norm_data, type = 'l')