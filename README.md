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

atl_Year <- atl_2 %>% group_by(`Report.Year`) %>% summarise(count = n())
colnames(atl_Year)[colnames(atl_Year) == "count"] <- "Crime_Count"

atl_Year %>% ggplot(aes(Report.Year, Crime_Count, group = 1)) + geom_point() + 
  geom_line() + ggtitle(expression("Total Crime by Year"), "") + 
  theme(plot.title = element_text(size = 20, color = "red", hjust = .50))
