##################################
# Final Project PID Code
# Author: Zoe Haskell-Craig
# Last Modified: Mar 5th 2023
# Date Created: Mar 5th 2023
##################################

# This is the code to generate a unique ID for each person in the TAS dataset:
# See FAQ#9 for info: https://psidonline.isr.umich.edu/Guide/FAQ.aspx

#   The combination of the 1968 ID and the person number uniquely identify each individual.
# 
# To identify an individual across waves use the 1968 ID and Person Number (Summary Variables ER30001 and ER30002). Though you can combine them uniquely in many ways we find that many researchers use the following method:
#   
#   (ER30001 * 1000) + ER30002
# 
# 
# (1968 ID multiplied by 1000) plus Person Number

library(readr)
library(tidyverse)
library(haven)
# load data
data <- read_dta("/Users/elenauttaro/Desktop/longitudinal analysis/final proj/finalproj_2023.dta")

# generate PID
data <- data %>% 
  mutate(PID = (ER30001 * 1000) + ER30002) %>%
  relocate(PID) #putting at beginning of dataset

#checking for duplicates by PID
sum(duplicated(data$PID)) #should return 0

View(data)

