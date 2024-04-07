#### Preamble ####
# Purpose: Simulates the data of gdp and inflation of a country
# Author: Vanshika Vanshika
# Date: 4 April 2024
# Contact: vanshika.vanshika@gmail.com
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# Set seed for reproducibility
set.seed(185)

# Number of observations
num_observations <- 25

# Simulate Total_Unique_Persons data
total_unique_persons <- sample(50000:1000000, num_observations, replace = TRUE)

# Simulate GDP data
gdp_mean <- 2500000
gdp_std <- 500000
gdp <- rnorm(num_observations, mean = gdp_mean, sd = gdp_std)

# Simulate Per_Capita data
per_capita_mean <- 50000
per_capita_std <- 10000
per_capita <- rnorm(num_observations, mean = per_capita_mean, sd = per_capita_std)

# Simulate Inflation_Rate data
inflation_rate_mean <- 2.5
inflation_rate_std <- 0.5
inflation_rate <- rnorm(num_observations, mean = inflation_rate_mean, sd = inflation_rate_std)

# Simulate Unemployment_rate data
unemployment_rate_mean <- 7
unemployment_rate_std <- 2
unemployment_rate <- rnorm(num_observations, mean = unemployment_rate_mean, sd = unemployment_rate_std)

# Simulate House_Price_Index data
house_price_index_mean <- 100
house_price_index_std <- 10
house_price_index <- rnorm(num_observations, mean = house_price_index_mean, sd = house_price_index_std)

# Simulate Exports data
exports_mean <- 500000
exports_std <- 100000
exports <- rnorm(num_observations, mean = exports_mean, sd = exports_std)

# Create a data frame to store the simulated data
simulated_data <- data.frame(
  Total_Unique_Persons = total_unique_persons,
  GDP = gdp,
  Per_Capita = per_capita,
  Inflation_Rate = inflation_rate,
  Unemployment_rate = unemployment_rate,
  House_Price_Index = house_price_index,
  Exports = exports
)

# Display the first few rows of the simulated data
head(simulated_data)

# Create a scatter plot of Total_Unique_Persons against GDP
plot(simulated_data$Total_Unique_Persons, simulated_data$GDP, 
     xlab = "Total Unique Persons", ylab = "GDP", 
     main = "Scatter plot of Total Unique Persons vs GDP",
     col = "blue", pch = 16)


# Create a scatter plot of Total_Unique_Persons against GDP
plot(simulated_data$GDP, simulated_data$inflation, 
     xlab = "GDP", ylab = "Inflation", 
     main = "Scatter plot of Total Unique Persons vs GDP",
     col = "blue", pch = 16)


