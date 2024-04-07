#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(readxl)

#### Clean data ####
inflation <- read_csv("data/raw_data/canada-inflation-rate-cpi.csv", skip = 16)
home <- read_csv("data/raw_data/home_ownership.csv", skip = 1)
house_price <- read_csv("data/raw_data/housing_price_index.csv", skip = 9)
income <- read_csv("data/raw_data/income_houses.csv")
rent <- read_csv("data/raw_data/rentintoronto.csv")
visa_province <- read_excel("data/raw_data/study_province.xlsx")

# billion of US dollars
gdp <- read_csv("data/raw_data/canada-gdp-gross-domestic-product.csv", skip = 16)

colnames(gdp) <- c("Year", "GDP", "Per_Capita", "Annual_Change_GDP")

# Convert Year column to character type
gdp$Year <- as.character(gdp$Year)

# Extract only the first four characters from the Year column
# Create a new row to add
new_row <- c(2023, 2145.40)  # Replace your_value with the value you want to add for 2023

# Add the new row to the end of the dataset
gdp <- rbind(gdp, new_row)
gdp$Year <- substr(gdp$Year, 1, 4)
gdp$GDP <- gdp$GDP * 1356850000
gdp$GDP <- gdp$GDP/1000000
print(tail(gdp, n = 10))

# x1000
revenue <- read_csv("data/raw_data/total_revenue.csv", skip =10)
row_index <- 2  # For example, to include only the 5th row
revenue <- revenue[row_index, , drop = FALSE]
# Clean the revenue dataset
revenue <- revenue %>%
  # Remove commas and convert to numeric for all columns except the first one
  mutate(across(-1, ~as.numeric(gsub(",", "", .)))) %>%
  # Rename the first column
  rename(Types_of_revenues = `Types of revenues`) %>%
  # Convert horizontal to vertical and include only the second year
  pivot_longer(cols = -Types_of_revenues, names_to = "Year", values_to = "Value") %>%
  # Extract only the second year from the "Year" column
  mutate(Year = gsub(".* / ", "", Year))

revenue$Value <- revenue$Value * 1000
revenue$Value <- revenue$Value / 1000000
# Assuming 'dataset' is your dataset and 'column_index' is the index of the column you want to delete
revenue <- revenue[, -1]
colnames(revenue) <- c("Year", "Revenue")





house_price_index <- read_csv("data/raw_data/housing_price_index_canada.csv", skip = 9)
row_index <- 2  # For example, to include only the 5th row
house_price_index <- house_price_index[row_index, , drop = FALSE]
# Clean the revenue dataset
house_price_index <- house_price_index %>%
  # Remove commas and convert to numeric for all columns except the first one
  mutate(across(-1, ~as.numeric(gsub(",", "", .)))) %>%
  # Rename the first column
  #rename(Types_of_revenues = `Types of revenues`) %>%
  # Convert horizontal to vertical and include only the second year
  pivot_longer(cols = `New housing price indexes`, names_to = "Year", values_to = "Value") %>%
  # Extract only the second year from the "Year" column
  mutate(Year = gsub(".* / ", "", Year))

# Transpose the dataset
house_price_index <- as.data.frame(t(house_price_index))

write.csv(house_price_index, "data/analysis_data/house_price_index.csv")
house_price_index <- read_csv("data/analysis_data/house_price_index.csv")
# Rename columns
colnames(house_price_index) <- c("Year", "House_Price_Index")

# Keep only December values in the "Year" column
house_price_index <- house_price_index[grep("December", house_price_index$Year), ]

# Extract only the years from the "Year" column
house_price_index$Year <- gsub("(\\D+)(\\d+).*", "\\2", house_price_index$Year)

# Remove the last two rows
house_price_index <- head(house_price_index, -2)








unemployment <- read_csv("data/raw_data/canada-unemployment-rate.csv", skip = 16)
colnames(unemployment) <- c("Year", "Unemployment_rate", "Annual_Change_unemployment")
# Convert Year column to character type
unemployment$Year <- as.character(unemployment$Year)

# Extract only the first four characters from the Year column
unemployment$Year <- substr(unemployment$Year, 1, 4)
unemployment <- unemployment[, -4]
unemployment




# millions
consumption <- read_csv("data/raw_data/consumption.csv", skip = 9)
row_index <- 2  # For example, to include only the 5th row
consumption <- consumption[row_index, , drop = FALSE]
# Method 2: Using indexing
consumption <- consumption[, !(names(consumption) == "Estimates")]
# Clean the revenue dataset
consumption <- consumption %>%
  # Remove commas and convert to numeric for all columns except the first one
  mutate(across(-1, ~as.numeric(gsub(",", "", .)))) %>%
  # Rename the first column
  # Convert horizontal to vertical and include only the second year
  pivot_longer(cols = `Consumption category`, names_to = "Year", values_to = "Value") %>%
  # Extract only the second year from the "Year" column
  mutate(Year = gsub(".* / ", "", Year))

# Transpose the dataset
consumption <- as.data.frame(t(consumption))
consumption
write.csv(consumption, "data/analysis_data/consumption.csv")
consumption <- read_csv("data/analysis_data/consumption.csv")
# Rename columns
colnames(consumption) <- c("Year", "Consumption")
# Remove the last two rows
consumption <- head(consumption, -2)





#in millions
ex_and_imp <- read_csv("data/raw_data/exports.csv", skip = 1)
colnames(ex_and_imp) <- c("Year", "Trade_Balance", "Exports", "Imports")
# Remove the last two rows
ex_and_imp <- head(ex_and_imp, -2)




immigrants <- read_excel("data/raw_data/EN_ODP-TR-Study-IS_CITZ_sign_date.xlsx", skip = 4)
row_index <- 219  # For example, to include only the 5th row
immigrants <- immigrants[row_index, , drop = FALSE]
# Transpose the data
immigrants <- t(immigrants)

# Extract the year from column names
year <- as.numeric(gsub("^([0-9]+),.*", "\\1", colnames(immigrants)))


# Create a data frame
data <- data.frame(
  Year = 2000:2022,
  Total_Unique_Persons = c(122665, 145950, 158125, 164480, 168590, 170440, 172340, 179110, 184140, 204005, 
                           225295, 248470, 274700, 301545, 330110, 352330, 410570, 490775, 567065, 638280, 
                           528190, 621565, 807260)
)

# Save as CSV
write.csv(data, "data/analysis_data/total_unique_persons.csv", row.names = FALSE)


# Assign column names to the data frame
colnames(inflation) <- c("Year", "Inflation_Rate", "Annual_Change_Inflation")
# Convert Year column to character type
inflation$Year <- as.character(inflation$Year)

# Extract only the first four characters from the Year column
inflation$Year <- substr(inflation$Year, 1, 4)
inflation <- inflation[, -4]



colnames(home) <- c("Year", "Homeownership Rate (%)")
home <- home[-nrow(home), ]
home <- home[-nrow(home), ]

row_index <- 13  # For example, to include only the 5th row
house_price <- house_price[row_index, , drop = FALSE]





### Connect them all ( MERGED DATA)
# Set scipen option to disable scientific notation
options(scipen = 999)
# Merge datasets based on the 'Year' column
merged_data <- Reduce(function(x, y) merge(x, y, by = "Year", all = TRUE), 
                      list(data, gdp, revenue, house_price_index, consumption, ex_and_imp, unemployment, inflation))

# Replace NA values with 0
merged_data[is.na(merged_data)] <- 0

# Filter rows with years above 2000
merged_data <- merged_data %>%
  filter(Year >= 2000)

# these data for 2023 is derived from different sources
merged_data$Total_Unique_Persons[merged_data$Year == 2023] <- 1040985
merged_data$House_Price_Index[merged_data$Year == 2022] <- 125.5
merged_data$House_Price_Index[merged_data$Year == 2023] <- 124.4
merged_data$Per_Capita[merged_data$Year == 2023] <- 55366.49
merged_data$Annual_Change_GDP[merged_data$Year == 2023] <- 1.5
merged_data$Revenue[merged_data$Year == 2023] <- 15151.575
merged_data$Imports[merged_data$Year == 2023] <- 64235.20	
merged_data$Exports[merged_data$Year == 2023] <- 63372.40
merged_data$Trade_Balance[merged_data$Year == 2023] <- -862.80
merged_data$Unemployment_rate[merged_data$Year == 2023] <- 5.4
merged_data$Annual_Change_unemployment[merged_data$Year == 2023] <- 0.191
merged_data$Inflation_Rate[merged_data$Year == 2023] <- 3.62
merged_data$Annual_Change_Inflation[merged_data$Year == 2023] <- -3.1828

merged_data
# Save merged dataset
write.csv(merged_data, "data/analysis_data/merged_data.csv", row.names = FALSE)


#### Save data ####
write_csv(inflation, "data/analysis_data/inflation.csv")
#write_csv(home, "data/analysis_data/home.csv")
#write.csv(house_price, "data/analysis_data/house_prices.csv")
write.csv(gdp, "data/analysis_data/gdp.csv")
write.csv(revenue, "data/analysis_data/revenue.csv")
write.csv(house_price_index, "data/analysis_data/house_price_index.csv")
write.csv(unemployment, "data/analysis_data/unemployment.csv")
write.csv(consumption, "data/analysis_data/consumption.csv")
write.csv(ex_and_imp, "data/analysis_data/ex_and_imp.csv")

