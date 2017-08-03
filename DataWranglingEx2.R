library(dplyr)
library(tidyr)

# Save the data set as a CSV file called titanic_original.csv and load it in RStudio into a data frame.
library(readr)
titanic_original <- read_csv("C:/Users/esh18/Desktop/titanic_original.csv")

# Find the missing values in the Embarked column and replace them with S. 
titanic_original %>% mutate(embarked = if_else(is.na(embarked), 'S', embarked))
titanic_original %>% select(embarked) %>% unique()

# Calculate the mean of the Age column and use that value to populate the missing values
titanic_original %>% mutate(age = if_else(is.na(age), mean(age, na.rm = TRUE), age))
# Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean
# I would still pick mean as the best way to figure out this problem. You could use median, but mean would give a more accurate assessment of the passangers' ages.

#  Fill these empty slots in the bBoat column with a dummy value e.g. the string 'None' or 'NA'
any(is.na(titanic_original$cabin))
any(titanic_original$cabin=="", na.rm = TRUE)

# Does it make sense to fill missing cabin numbers with a value?
  # No, since we don't have that information. 
# What does a missing value here mean?
  # 1) There was no assigned cabin. 2) There is no record of the cabin number.
# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
library(tibble)
add_column (has_cabin_number <- if_else(is.na(titanic_original$cabin), 0, 1))

# Include your code, the original data as a CSV file titanic_original.csv, and the cleaned up data as a CSV file called titanic_clean.csv.
write_csv(titanic_original,"titanic_clean.csv")
