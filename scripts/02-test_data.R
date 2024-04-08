#### Preamble ####
# Purpose: Tests the cleaned file
# Author: Vanshika Vanshika
# Date: 4 April 2024
# Contact: vanshika.vanshika@gmail.com
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Test data ####
# Load the merged_dataset
merged_dataset <- read.csv("data/analysis_data/merged_data.csv")

# Define test cases
test_that("Testing merged_dataset", {
  
  # Check if merged_dataset is a data frame
  expect_is(merged_dataset, "data.frame", 
            info = "merged_dataset should be a data frame")
  
  # Check if all columns are present
  expected_columns <- c("Year", "Total_Unique_Persons", "GDP", "Per_Capita", 
                        "Annual_Change_GDP", "Revenue", "House_Price_Index", 
                        "Consumption", "Trade_Balance", "Exports", "Imports", 
                        "Unemployment_rate", "Annual_Change_unemployment", 
                        "Inflation_Rate", "Annual_Change_Inflation")
  expect_identical(colnames(merged_dataset), expected_columns,
                   info = "Columns names should match expected_columns")
  
  # Check if there are no missing values
  expect_false(any(is.na(merged_dataset)), 
               info = "There should be no missing values in merged_dataset")
  
  # Check if the Year column contains only integers
  expect_true(all(as.integer(merged_dataset$Year) == merged_dataset$Year),
              info = "Year column should contain only integers")
  
  # Check if GDP values are positive
  expect_true(all(merged_dataset$GDP >= 0),
              info = "GDP values should be non-negative")
  
  # Add more tests as needed
  
})