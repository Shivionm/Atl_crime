# Atl_crime

library(readr)
library(tidyr)
library(lubridate)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(janitor)

atl_1 <- read_csv("Projects/R/Copy _Atl_crime_data_2009_2019.csv")
str(atl_1)
