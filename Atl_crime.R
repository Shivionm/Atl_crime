install.packages('tidyverse')
library(readr)
library(tidyr)
library(lubridate)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(janitor)

atl<- read_csv("./Atl_crime_data_2009_2019.csv")
str(atl)
atl[atl == " "] <- NA
atl<- atl[ , !names(atl) %in% 
                              c("Apartment Office Prefix", "Apartment Number",
                                "Occur Date", "Occur Time")]
atl<- atl [ , !names(atl) %in% c("Location", "NPU", "UCR #", "IBR Code",
                                        "Possible Date", "Possible Time")]
atl <- na.omit(atl)
atl$'Report Date' <- mdy(atl$'Report Date')
atl$`Report Date_1` = atl$`Report Date`
atl_1 <- atl %>% separate("Report Date_1", c("Report.Year", "Report.Month",
                                               "Report.Day"), "-")

atl_UCR <- atl_1 %>% group_by(`UCR Literal`) %>% summarise(count = n())
colnames(atl_UCR)[colnames(atl_UCR) == "count"] <- "Number_of_UCR"
colnames(atl_UCR)[colnames(atl_UCR) == "UCR Literal"] <- "UCR"

atl_Year <- atl_1 %>% group_by(`Report.Year`) %>% summarise(count = n())
colnames(atl_Year)[colnames(atl_Year) == "count"] <- "Crime_Count"

atl_Neighborhood <- atl_1 %>% group_by(`Neighborhood`) %>% summarise(count = n())
colnames(atl_Neighborhood)[colnames(atl_Neighborhood) == "count"] <- 
  "Crime_in_Neighborhood"

atl_Month <- atl_1 %>% group_by(`Report.Month`) %>% summarise(count = n())
colnames(atl_Month)[colnames(atl_Month) == "count"] <- "Number_of_Crime"

atl_2 <- atl_1
atl %>% group_by(`UCR Literal`) %>% summarise(count = n())

atl_UCR %>% ggplot(aes(Number_of_UCR, UCR)) + geom_point() + 
  ggtitle(expression("Types of Crimes"), "") + 
  theme(plot.title = element_text(size = 20, color = "red", hjust = .50))

atl %>% group_by(Report.Year) %>% summarise(count = n())

atl_Year %>% ggplot(aes(Report.Year, Crime_Count, group = 1)) + geom_point() + 
  geom_line() + ggtitle(expression("Total Crime by Year"), "") + 
  theme(plot.title = element_text(size = 20, color = "red", hjust = .50))

atl_Month %>% ggplot(aes(x = Report.Month, y = Number_of_Crime)) + geom_col(aes(fill = Number_of_Crime)) + 
  coord_flip() + ggtitle(expression("Total Crime by Month"), "") + 
  theme(plot.title = element_text(size = 20, color = "red", hjust = .50))

top_n(atl_Neighborhood, n = 10, Crime_in_Neighborhood ) %>% 
  ggplot(aes(Neighborhood,Crime_in_Neighborhood)) + geom_point() + 
  coord_flip() + 
  ggtitle("The top 10 \n Neighborhood with the most crime") + 
  theme(plot.title = element_text(size = 20, color = "red", hjust = .50))
