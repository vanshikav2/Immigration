#### Preamble ####
# Purpose: Tests the cleaned file
# Author: Vanshika Vanshika
# Date: 4 April 2024
# Contact: vanshika.vanshika@gmail.com
# License: MIT


# packages
library(styler)

### style all the code

style_file("scripts/00-simulate_data.R")
style_file("scripts/01-data_cleaning.R")
style_file("scripts/02-test_data.R")
style_file("scripts/03-model.R")