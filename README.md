Atlanta Georgia Crime from 2009 to 2019
================
By Shivion Morgan

## Introduction

I decided to analyze the open data about Atlanta Georgia. Atlanta is one
of most popular city in the country. I want to know how many crime was
reported and what are the crime being reported.

RStudio is an integrated development environment for doing practical,
real world data analysis in R. It is an open\_source tools to analyze
and manipulate data. My goal is to explore and learn the wide range of
opportunities with RStudio.

## About the dataset

The original data set can be found on the [Atlanta police
department](https://www.atlantapd.org/i-want-to/crime-data-downloads)

## packages and libraries

-   I created a vector of the packages to load: pkgs &lt;-
    c(“tidyverse”, “ggplot2”, “lubridate”, “janitor”)

-   Install the vector of packages: install.packages(pkgs)

-   To load the installed packages in one go, I uses the lapply function
    to run the library: lapply(pkgs, library, character.only = TRUE)

-   I also use other library(dplyr, tidyr, just to name a few) see code
    for more detail.

## Import the data

-   read\_csv reads the .csv data and return a data frame:
    library(readr) atl\_crime &lt;-
    read\_csv(“./Atl\_crime\_data\_2009\_2019.csv”)

-   I view the data to to see what I am working with and also to see if
    everything was successful loaded. view(atl\_crime) in the console.

## Data pre\_process

### First look

-   I want to see the size and the structure of the data, I use
    str(atl\_crime)

    -   342,914 rows or observations
    -   19 columns or variables

-   when I was viewing the data I notice some blank and NA rows and
    columns

## Processing the data

### Dealing with missing data

-   I change all the blank cell to NA, so I can do one step cleaning of
    the missing data, I used: atl\[atl-crime == " "\] &lt;- NA

-   I remove a few columns as well because that data us not needed in
    this analysis (example: Apartment Office prefix and Apartment
    Number, just to name a few) I do this with: atl &lt;- atl\[ ,
    !names(atl\_1) %in% c(“Apartment Office Prefix”, “Apartment
    Number”)\]

-   I remove all the Na with the na.omit() function.

## Analysis the data

After cleaning the data I make a copy of the data set and rename it
“atl”.

### Types of Crimes

-   I want to know how many types of crimes are there in Atlanta: atl
    %&gt;% group\_by(`UCR Literal`) %&gt;% summarise(count = n())

-   I plot the different types of crimes.

![](Type%20of%20Crime%20plot.png)

Larceny from a vehicle and larceny non vehicle is the most commit crime.

### Crime over Time

-   I want to see the crime trend reported from 2009 to 2019.

![](Total%20Crime%20by%20Year%20plot.png)

By looking at the trend, it seemed that the number of crime reported
have been decreasing since 2009.

-   I want to see which month have the most crime.

![](Total%20Crime%20by%20Month%20plot.png)

Crimes happen the most in July, August, whereas February and March have
the lest amount of crime.

### Crime in each Neighborhood

-   I want to know the top 10 crime neighborhood.

![](Top%20plot.png)

Downtown and Midtown have the most crime reported.

## Conclusion

By using RStudio, I analyzed and visualized the open date of Atlanta
crime report. This integrated development environment is a powerful tool
in data analysis and it’s a good way to start my data analysis career.

The data taught me overall crime in Atlanta have been going down since
2009, the most crime happen when the temperature is getting warmer, most
crime happen in the Downtown neighborhood then in any other
neighborhood.

Thanks for reading this! check out my Githud for the full code.

Shivion
