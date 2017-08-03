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
  
  mutate(company = gsub("unilver", "unilever", x=company))

2: Separate product code and number

Separate the product code and product number into separate columns i.e. add two new columns called product_code and product_number, containing the product code and number respectively

separate (refine_original1, `Product code / number`, into=c("product_code","product_number"))

3: Add product categories

You learn that the product codes actually represent the following product categories:

p = Smartphone

v = TV

x = Laptop

q = Tablet

In order to make the data more readable, add a column with the product category for each record.

refine_original3 %>% mutate(product_category = product_code) %>%

  mutate(product_category = gsub("p", "Smartphone", x = product_category))%>%
  
  mutate(product_category = gsub("v", "TV", x = product_category))%>%
  
  mutate(product_category = gsub("x", "Laptop", x = product_category))%>%
  
  mutate(product_category = gsub("q", "Tablet", x = product_category))

4: Add full address for geocoding

You'd like to view the customer information on a map. In order to do that, the addresses need to be in a form that can be easily geocoded. Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.

refine_original2 %>% mutate (full_address = paste(address, city, country, sep = ","))

5: Create dummy variables for company and product category

Both the company name and product category are categorical variables i.e. they take only a fixed set of values. In order to use them in further analysis you need to create dummy variables. Create dummy binary variables for each of them with the prefix company_ and product_ i.e.,

Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.

Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.

refine_original4 %>% 

  mutate(company_philips = if_else(company=="philips", 1, 0)) %>% 
  
  mutate(company_akzo = if_else(company=="akzo", 1, 0)) %>% 
  
  mutate(company_van_houten = if_else(company=="van houten", 1, 0)) %>% 
  
  mutate(company_unilever = if_else(company=="unilever", 1, 0)) %>% 
  
  mutate(product_smartphone = if_else(product_code=="p", 1, 0)) %>% 
  
  mutate(product_tv = if_else(product_code=="v", 1, 0)) %>% 
  
  mutate(product_laptop = if_else(product_code=="x", 1, 0)) %>% 
  
  mutate(product_tablet = if_else(product_code="q", 1, 0)) %>% 
  
  mutate_at(vars(matches("company_|product_")),funs(as.logical))

6: Submit the project on Github

Include your code, the original data as a CSV file refine_original.csv, and the cleaned up data as a CSV file called refine_clean.csv.

write.csv(refine_original, file = "refine_clean.csv")
