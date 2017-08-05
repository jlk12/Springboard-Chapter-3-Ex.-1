library(dplyr)
library(tidyr)

# Save the data set as a CSV file called refine_original.csv and load it in RStudio into a data frame
refine_original <- read_csv("C:/Users/esh18/Desktop/refine_original.csv")

# Clean up the 'company' column so all of the misspellings of the brand names are standardized.
refine_original %>% mutate(company = tolower(company)) %>% 
  mutate(company = gsub("phillips", "philips", x=company)) %>%
  mutate(company = gsub("phllips", "philips", x=company)) %>%
  mutate(company = gsub("phillps", "philips", x=company)) %>%
  mutate(company = gsub("fillips", "philips", x=company)) %>%
  mutate(company = gsub("phlips", "philips", x=company)) %>%
  mutate(company = gsub("akz0", "akzo", x=company)) %>% 
  mutate(company = gsub("ak zo", "akzo", x=company)) %>% 
  mutate(company = gsub("unilver", "unilever", x=company)) %>%

# Separate the product code and product number into separate columns.
separate (`Product code / number`, into=c("product_code","product_number")) %>%

# Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.
mutate (full_address = paste(address, city, country, sep = ",")) %>%

# Add a column with the product category for each record.
  mutate(product_category = product_code) %>%
  mutate(product_category = gsub("p", "Smartphone", x = product_category))%>%
  mutate(product_category = gsub("v", "TV", x = product_category))%>%
  mutate(product_category = gsub("x", "Laptop", x = product_category))%>%
  mutate(product_category = gsub("q", "Tablet", x = product_category)) %>%  

# Create dummy binary variables for each of them with the prefix company_ and product_ 
mutate(company_philips = (if_else(grepl(pattern='philips', x=refine_original$company), 1, 0)))%>%
mutate(company_akzo = (if_else(grepl(pattern='akzo', x=refine_original$company), 1, 0)))%>%
mutate(company_vanhouten = (if_else(grepl(pattern='van houten', x=refine_original$company), 1, 0)))%>%
mutate(company_unilever = (if_else(grepl(pattern='unilever', x=refine_original$company), 1, 0)))%>%
mutate(product_category_smartphone = (if_else(grepl(pattern='p', x=product_code), 1, 0)))%>%
mutate(product_category_laptop = (if_else(grepl(pattern='x', x=product_code), 1, 0)))%>%
mutate(product_category_TV = (if_else(grepl(pattern='v', x=product_code), 1, 0)))%>%
mutate(product_category_Tablet = (if_else(grepl(pattern='q', x=product_code), 1, 0)))

# include your code, the original data as a CSV file refine_original.csv, and the cleaned up data as a CSV file called refine_clean.csv.
write.csv(refine_original, file = "refine_clean.csv")
