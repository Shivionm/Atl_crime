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
atl_1[atl_1 == " "] <- NA
atl_1 <- atl_1[ , !names(atl_1) %in% 
                              c("Apartment Office Prefix", "Apartment Number",
                                "Occur Date", "Occur Time")]
atl_1 <- atl_1 [ , !names(atl_1) %in% c("Location", "NPU", "UCR #", "IBR Code",
                                        "Possible Date", "Possible Time")]
atl_1 <- na.omit(atl_1)

atl_1$'Report Date' <- mdy(atl_1$'Report Date')
atl_1$`Report Date_1` = atl_1$`Report Date`
atl_2 <- atl_1 %>% separate("Report Date_1", c("Report.Year", "Report.Month",
                                               "Report.Day"), "-")

atl_Neighborhood <- atl_2 %>% group_by(`Neighborhood`) %>% summarise(count = n())
colnames(atl_Neighborhood)[colnames(atl_Neighborhood) == "count"] <- 
  "Crime_in_Neighborhood"

top_n(atl_Neighborhood, n = 10, Crime_in_Neighborhood ) %>% 
  ggplot(aes(Neighborhood,Crime_in_Neighborhood)) + geom_point() + 
  coord_flip() + 
  ggtitle("The top 10 \n Neighborhood with the most crime") + 
  theme(plot.title = element_text(size = 20, color = "red", hjust = .50))
