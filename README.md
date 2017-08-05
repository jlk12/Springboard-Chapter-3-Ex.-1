# Springboard-Chapter-3-Ex.-1
0: Load the data in RStudio

Save the data set as a CSV file called refine_original.csv and load it in RStudio into a data frame.

refine_original <- read_csv

1: Clean up brand names

Clean up the 'company' column so all of the misspellings of the brand names are standardized. For example, you can transform the values in the column to be: philips, akzo, van houten and unilever (all lowercase).

refine_original %>% mutate(company = tolower(company)) %>% 

  mutate(company = gsub("phillips", "philips", x=company)) %>%
  
  mutate(company = gsub("phllips", "philips", x=company)) %>%
  
  mutate(company = gsub("phillps", "philips", x=company)) %>%
  
  mutate(company = gsub("fillips", "philips", x=company)) %>%
  
  mutate(company = gsub("phlips", "philips", x=company)) %>%
  
  mutate(company = gsub("akz0", "akzo", x=company)) %>% 
  
  mutate(company = gsub("ak zo", "akzo", x=company)) %>% 
  
  mutate(company = gsub("unilver", "unilever", x=company)) %>%

2: Separate product code and number

Separate the product code and product number into separate columns i.e. add two new columns called product_code and product_number, containing the product code and number respectively

separate (`Product code / number`, into=c("product_code","product_number")) %>%

3: Add product categories

You learn that the product codes actually represent the following product categories:

p = Smartphone

v = TV

x = Laptop

q = Tablet

In order to make the data more readable, add a column with the product category for each record.

mutate(product_category = product_code) %>%

  mutate(product_category = gsub("p", "Smartphone", x = product_category))%>%
  
  mutate(product_category = gsub("v", "TV", x = product_category))%>%
  
  mutate(product_category = gsub("x", "Laptop", x = product_category))%>%
  
  mutate(product_category = gsub("q", "Tablet", x = product_category)) %>%  
  
4: Add full address for geocoding

You'd like to view the customer information on a map. In order to do that, the addresses need to be in a form that can be easily geocoded. Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.

mutate (full_address = paste(address, city, country, sep = ",")) %>%

5: Create dummy variables for company and product category

Both the company name and product category are categorical variables i.e. they take only a fixed set of values. In order to use them in further analysis you need to create dummy variables. Create dummy binary variables for each of them with the prefix company_ and product_ i.e.,

Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.

Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.

mutate(company_philips = (if_else(grepl(pattern='philips', x=refine_original$company), 1, 0)))%>%

mutate(company_akzo = (if_else(grepl(pattern='akzo', x=refine_original$company), 1, 0)))%>%

mutate(company_vanhouten = (if_else(grepl(pattern='van houten', x=refine_original$company), 1, 0)))%>%

mutate(company_unilever = (if_else(grepl(pattern='unilever', x=refine_original$company), 1, 0)))%>%

mutate(product_category_smartphone = (if_else(grepl(pattern='p', x=product_code), 1, 0)))%>%

mutate(product_category_laptop = (if_else(grepl(pattern='x', x=product_code), 1, 0)))%>%

mutate(product_category_TV = (if_else(grepl(pattern='v', x=product_code), 1, 0)))%>%

mutate(product_category_Tablet = (if_else(grepl(pattern='q', x=product_code), 1, 0)))


6: Submit the project on Github

Include your code, the original data as a CSV file refine_original.csv, and the cleaned up data as a CSV file called refine_clean.csv.

write.csv(refine_original, file = "refine_clean.csv")



# Springboard-Chapter-3-Ex.-2

0: Load the data in RStudio

Save the data set as a CSV file called titanic_original.csv and load it in RStudio into a data frame.

titanic_original <- read_csv

1: Port of embarkation

The embarked column has some missing values, which are known to correspond to passengers who actually embarked at Southampton. Find the missing values and replace them with S. (Caution: Sometimes a missing value might be read into R as a blank or empty string.)

titanic_original %>% mutate(embarked = if_else(is.na(embarked), 'S', embarked))

titanic_original %>% select(embarked) %>% unique()

2: Age

You’ll notice that a lot of the values in the Age column are missing. While there are many ways to fill these missing values, using the mean or median of the rest of the values is quite common in such cases.

Calculate the mean of the Age column and use that value to populate the missing values

titanic_original %>% mutate(age = if_else(is.na(age), mean(age, na.rm = TRUE), age))

Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?

I would still pick mean as the best way to figure out this problem. You could use median, but mean would give a more accurate assessment of the passangers' ages.

3: Lifeboat

You’re interested in looking at the distribution of passengers in different lifeboats, but as we know, many passengers did not make it to a boat :-( This means that there are a lot of missing values in the boat column. Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'

any(is.na(titanic_original$cabin))

any(titanic_original$cabin=="", na.rm = TRUE)

4: Cabin

You notice that many passengers don’t have a cabin number associated with them.

Does it make sense to fill missing cabin numbers with a value?

 No, since we don't have that information. 

What does a missing value here mean?

1) There was no assigned cabin. 2) There is no record of the cabin number

You have a hunch that the fact that the cabin number is missing might be a useful indicator of survival. Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

library(tibble)

add_column (has_cabin_number <- if_else(is.na(titanic_original$cabin), 0, 1))

6: Submit the project on Github

Include your code, the original data as a CSV file titanic_original.csv, and the cleaned up data as a CSV file called titanic_clean.csv.
