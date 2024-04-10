#### Preamble ####
# Purpose: Models the cleaned file
# Author: Vanshika Vanshika
# Date: 4 April 2024
# Contact: vanshika.vanshika@gmail.com
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####

# MODEL 1
# Load the dataset
dataset <- read.csv("data/analysis_data/merged_data.csv") # Replace "your_dataset.csv" with the path to your dataset

# Remove predictors with high VIF values
dataset <- subset(dataset, select = -c(Per_Capita, Trade_Balance, Imports, Annual_Change_unemployment, `Annual_Change_Inflation`))

# Fit a Bayesian generalized linear model to predict GDP
gdp_model <- stan_glm(
  GDP ~ Total_Unique_Persons + Annual_Change_GDP + Revenue +
    House_Price_Index + Consumption + Exports +
    Unemployment_rate + `Inflation_Rate`,
  data = dataset,
  family = gaussian()
)

# Summary of the model
summary(gdp_model)

# Assess model diagnostics (optional)
plot(gdp_model)


new_data <- data.frame(
  Total_Unique_Persons = 360000, # Cap on Total_Unique_Persons
  Annual_Change_GDP = 1.5000,
  Revenue = 13971.575,
  House_Price_Index = 124.4,
  Consumption = 63372.4,
  Exports = 779216,
  Unemployment_rate = 5.400,
  Inflation_Rate = 3.6200 # Adjusted variable name without line continuation
)

predicted_gdp <- predict(gdp_model, newdata = new_data)
print(predicted_gdp)


# #### Save model ####
saveRDS(
  gdp_model,
  file = "models/gdp_model.rds"
)



# MODEL 2
dataset <- read.csv("data/analysis_data/merged_data.csv") # Replace "your_dataset.csv" with the path to your dataset

# Remove predictors with high VIF values
dataset <- subset(dataset, select = -c(Per_Capita, Trade_Balance, Imports, Annual_Change_unemployment, `Annual_Change_Inflation`))

# Fit a Bayesian generalized linear model to predict GDP
model <- stan_glm(
  Inflation_Rate ~ Total_Unique_Persons + GDP + Annual_Change_GDP + Revenue +
    House_Price_Index + Consumption + Exports +
    Unemployment_rate,
  data = dataset,
  family = gaussian()
)

# Summary of the model
summary(model)

# Assess model diagnostics (optional)
plot(model)


new_data <- data.frame(
  Total_Unique_Persons = 360000, # Cap on Total_Unique_Persons
  GDP = 2910986,
  Annual_Change_GDP = 1.5000,
  Revenue = 13971.575,
  House_Price_Index = 124.4,
  Consumption = 63372.4,
  Exports = 779216,
  Unemployment_rate = 5.400
)

predicted_inflation <- predict(model, newdata = new_data)
print(predicted_inflation)
# #### Save model ####
saveRDS(
  model,
  file = "models/inflation_model.rds"
)





# # MODEL 3
# dataset <- read.csv("data/analysis_data/merged_data.csv")  # Replace "your_dataset.csv" with the path to your dataset
#
# # Remove predictors with high VIF values
# dataset <- subset(dataset, select = -c( Per_Capita ,Trade_Balance, Imports,Annual_Change_unemployment, `Annual_Change_Inflation`))
#
# # Fit a Bayesian generalized linear model to predict GDP
# model <- stan_glm( House_Price_Index ~ Total_Unique_Persons + GDP + Annual_Change_GDP + Revenue +
#                     Consumption  + Exports  +
#                     Unemployment_rate, Inflation_Rate,
#                   data = dataset,
#                   family = gaussian())
#
# # Summary of the model
# summary(model)
#
# # Assess model diagnostics (optional)
# plot(model)
#
#
# new_data <- data.frame(
#   Total_Unique_Persons = 360000, # Cap on Total_Unique_Persons
#   GDP = 2910986,
#   Annual_Change_GDP = 1.5000,
#   Revenue = 13971.575,
#   Consumption = 63372.4,
#   Exports = 779216,
#   Unemployment_rate = 5.400,
#   Inflation_Rate = 6.185203
# )
#
# predicted_inflation <- predict(model, newdata = new_data)
# print(predicted_inflation)
# # #### Save model ####
# saveRDS(
#   model,
#   file = "models/inflation_model.rds"
# )
