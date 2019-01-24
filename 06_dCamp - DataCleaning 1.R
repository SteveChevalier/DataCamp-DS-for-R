# -----------------------------------
# Snippets - preparing for analysis
# -----------------------------------
# outline for cleaning data
# 	Inspect data
# 	Tidy data
# 	Improved dates if needed
# 	correct variable encoding
# 	deal with missing data
# 	Id and correct errors
# 	visualize result
# ----------- putting it all together --------------
# ------ understand structure, look at the data
class() # class of data
dim() # dimensions of data
names() # column names
str() # Preview data with helpful details
glimpse() # better version of str() from dplyr
summary() # Summary of data
# look at data
head()
tail()
print()
# visualize
hist() # visualize single variable
plot() # look at two variables
# lubridate
library(lubridate)
ymd("yyy-mm-dd")  # or yyyy Month dd
mdy("month dd, yyyy")
hms()
ymd_hms()
# type conversions
as.character()
as.numeric()
as.interger()
as.factor()
as.logical()
# find missing values
is.na()
sum(is.na())
which(is.na(df$col))

# Verify that weather is a data.frame
class(weather)
# Check the dimensions
dim(weather)
# View the column names
names(weather)

# View the structure of the data
str(weather)
# Load dplyr package
library(dplyr)
# Look at the structure using dplyr's glimpse()
glimpse(weather)
# View a summary of the data
summary(weather)

# View first 6 rows
head(weather, 6)
# View first 15 rows
head(weather, 15)
# View the last 6 rows
tail(weather, 6)
# View the last 10 rows
tail(weather, 10)

# ------ tidy the data - day columns to rows
# Load the tidyr package
library(tidyr)
# Gather the columns
weather2 <- gather(weather, day, value, X1:X31, na.rm = TRUE)
# View the head
head(weather2)

# ----  measure column spread to seperate column based on value
## The tidyr package is already loaded
# First remove column of row names
without_x <- weather2[, -1]
# Spread the data
weather3 <- spread(without_x, measure,value)
# View the head
head(weather3)

# ---- rename col,  crt good date from sep flds, arrage col
## tidyr and dplyr are already loaded
# Load the stringr and lubridate packages
library(stringr)
library(lubridate)
# Remove X's from day column
head(weather3$day)
weather3$day <- str_replace(weather3$day,"X","")
head(weather3$day)
# Unite the year, month, and day columns
head(weather3)
weather4 <- unite(weather3, date, year, month, day, sep = "-")
head(weather4)
# Convert date column to proper date format using lubridates's ymd()
weather4$date <- as.Date(weather4$date)
head(weather4)
# Rearrange columns using dplyr's select()
weather5 <- select(weather4, date, Events, CloudCover:WindDirDegrees)
# View the head of weather5
head(weather5)

# -- convert "T" (trace of rain) to zero in DF
## The dplyr and stringr packages are already loaded
# Replace "T" with "0" (T = trace)
weather5$PrecipitationIn <- str_replace(weather5$PrecipitationIn,"T","0")
# Convert characters to numerics
weather6 <- mutate_at(weather5, vars(CloudCover:WindDirDegrees), funs(as.numeric))
# Look at result
str(weather6)

# ---- data analysis
# Count missing values
sum(is.na(weather6))
# Find missing values
summary(weather6)
# Find indices of NAs in Max.Gust.SpeedMPH
ind <- which(is.na(weather6$Max.Gust.SpeedMPH))
# Look at the full rows for records missing Max.Gust.SpeedMPH
weather6[ind, ]

# Review distributions for all variables
summary(weather6)
# Find row with Max.Humidity of 1000
ind <- which(weather6$Max.Humidity == 1000)
# Look at the data for that day
weather6[ind, ]
# Change 1000 to 100
weather6$Max.Humidity[ind] <- 100

# -- fix outlyer data
# Look at summary of Mean.VisibilityMiles
summary(weather6$Mean.VisibilityMiles)
# Get index of row with -1 value
ind <- which(weather6$Mean.VisibilityMiles == -1)
# Look at full row
weather6[ind, ]
# Set Mean.VisibilityMiles to the appropriate value
weather6$Mean.VisibilityMiles[ind] <- 10

# Review summary of full data once more
summary(weather6)
# Look at histogram for MeanDew.PointF
hist(weather6$MeanDew.PointF)
# Look at histogram for Min.TemperatureF
hist(weather6$Min.TemperatureF)
# Compare to histogram for Mean.TemperatureF
hist(weather6$Mean.TemperatureF)

# ------  "." should be "_", blank = "None"
# Clean up column names
names(weather6) <- new_colnames
# Replace empty cells in events column
weather6$events[weather6$events == ""] <- "None"
# Print the first 6 rows of weather6
head(weather6, 6)



# ----------- END, putting it all together --------------

# ------ Missing and special values
# find missing
is.na(df) # finds all "NA"
any(is.na(df)) # true if any are found in entire DF
sum(is.na(df)) # counts the "NA" events
summary(df) #  shows count of "NA" by variables
df[complete.cases(df), ] # new subset minus rows with missing values
na.omit(df) # removes rows with missing values

# box plot
? boxplot
# View a boxplot of age
boxplot(students3$age)
# View a boxplot of absences
boxplot(students3$absences)

# outliers and obvious errors
# box plot, rnorm(xxx, xx, xx) , hist(df, breats = xx)
?hist
# Look at a summary() of students3
summary(students3)
# View a histogram of the age variable
hist(students3$age)
# View a histogram of the absences variable
hist(students3$absences)
# View a histogram of absences, but force zeros to be bucketed to the right of zero
hist(students3$absences, right = FALSE)
  

# remove NA 
## The stringr package is preloaded
# Replace all empty strings in status with NA
social_df$status[social_df$status == ""] <- NA
# Print social_df to the console
print(social_df)
# Use complete.cases() to see which rows have no missing values
complete.cases(social_df)
# Use na.omit() to remove all rows with any missing values
na.omit(social_df)

# find bad statuss
> # Call is.na() on the full social_df to spot all NAs
> is.na(social_df)
      name n_friends status
[1,] FALSE     FALSE  FALSE
[2,] FALSE      TRUE  FALSE
[3,] FALSE     FALSE  FALSE
[4,] FALSE     FALSE  FALSE
> 
> # Use the any() function to ask whether there are any NAs in the data
> any(is.na(social_df))
[1] TRUE
> 
> # View a summary() of the dataset
> summary(social_df)
    name     n_friends                status 
 Alice:1   Min.   : 43.0                 :2  
 David:1   1st Qu.: 94.0   Going out!    :1  
 Sarah:1   Median :145.0   Movie night...:1  
 Tom  :1   Mean   :144.0                     
           3rd Qu.:194.5                     
           Max.   :244.0                     
           NA's   :1'
> 
> # Call table() on the status column
> table(social_df$status)

                   Going out! Movie night... 
             2              1              1
			 

# -------- find and replace ----------------
# Copy of students2: students3
students3 <- students2
# Look at the head of students3
head(students3)
# Detect all dates of birth (dob) in 1997
str_detect(students3$dob, "1997")
# In the sex column, replace "F" with "Female" ...
students3$sex <- str_replace(students3$sex, "F", "Female")
# ... and "M" with "Male"
students3$sex <- str_replace(students3$sex, "M", "Male")
# View the head of students3
head(students3)

# string manipulations --------stringr------------
library(stringr)
str_trim() #  all blanks both sides
str_pad("string", width = x, side = "left", pad = "0")
str_detect("str1", "str2", .....) TRUE or FALSE returned per element
str_replace("vector", "toFind", "replaceWith") # replace element in vector
# -- R base --
toLower("str")
toUpper("str")
> # Load the stringr package
> library(stringr) 
> # Trim all leading and trailing whitespace
> str_trim(c("   Filip ", "Nick  ", " Jonathan"))
[1] "Filip"    "Nick"     "Jonathan"
> # Pad these strings with leading zeros
> str_pad(c("23485W", "8823453Q", "994Z"),width = 9, side = "left", pad = "0")
[1] "00023485W" "08823453Q" "00000994Z"

# ----------- dates with libridate  -----
# > ymd("yyyy-mm-dd") , mdy("MonthName dd, yyyy), hms("hh:mm:ss"), 
#    ymd_hms, 
# Preview students2 with str()
str(students2)
# Load the lubridate package
library(lubridate)
# Parse as date
dmy("17 Sep 2015")
# Parse as date and time (with no seconds!)
mdy_hm("July 15, 2012 12:56") 
# Coerce dob to a date (with no time)
# $ dob: chr  "2000-06-05" "1999-11-25"
students2$dob <- ymd(students2$dob)
# Coerce nurse_visit to a date and time
# $ nurse_visit: chr  "2014-04-10 14:59:54"
students2$nurse_visit <- ymd_hms(students2$nurse_visit)
# Look at students2 once more with str()
str(students2)

# ------ type conversions ------------
install.packages(lubridate)
library(lubridate)

-- convert variables 
 str(students)
'data.frame':	395 obs. of  31 variables:
 $ school    : Factor w/ 2 levels "GP","MS": 1 1 1 1 1 1 1 1 1 1 ...
 $ sex       : Factor w/ 2 levels "F","M": 1 1 1 1 1 2 2 1 2 2 ...
 $ age       : int  18 17 15 15 16 16 16 17 15 15 ...
 $ address   : Factor w/ 2 levels "R","U": 2 2 2 2 2 2 2 2 2 2 ...
# Preview students with str()
str(students)
# Coerce Grades to character
students$Grades <- as.character(students$Grades)
# Coerce Medu to factor
students$Medu <- as.factor(students$Medu)
# Coerce Fedu to factor
students$Fedu <- as.factor(students$Fedu)
# Look at students once more with str()
str(students)



# ----------- tidyR part II ------------
# seperate(data, col, into(a char vector of new col names), sep = "," [optional])
# --- example, seperate(treatments, year_mo, c("year", "month"))
# ---( treatements, year_mo, year, month)
# ---         data        target    src1, src2, ........ optional sep = ","
# Apply separate() to bmi_cc
head(bmi_cc)
bmi_cc_clean <- separate(bmi_cc, Country_ISO, c("Country", "ISO"), sep = "/")
# Print the head of the result
head(bmi_cc_clean)

# Apply unite() to bmi_cc_clean
bmi_cc <- unite(bmi_cc_clean, Country_ISO, Country, ISO, sep = "-")
# View the head of the result
head(bmi_cc)

# -- gather example
## tidyr and dplyr are already loaded for you
#  YEAR    JAN    FEB    MAR    APR    MAY    JUN    JUL    AUG    SEP    OCT
#1 1992 146913 147270 146831 148082 149015 149821 150809 151064 152595 153577
# View the head of census
head(census)
# Gather the month columns
census2 <- gather(census, month, amount, -YEAR)
head(census2)
# Arrange rows by YEAR using dplyr's arrange
census2 <- arrange(census2, YEAR)
# View first 20 rows of census2
head(census2, 20)
#   YEAR month amount
#1  1992   JAN 146913
#2  1992   FEB 147270
#3  1992   MAR 146831

#  YEAR month type   amount
#1  1992   JAN  MED 146913.0
#2  1992   FEB  MED 147270.0
## tidyr is already loaded for you
# View first 50 rows of census_long
head(census_long,50)
# Spread the type column
census_long2 <- spread(census_long, type, amount)
# View first 20 rows of census_long2
head(census_long2, 20)
#  YEAR month     HIGH      LOW    MED
#1 1992   APR 157623.9 146174.1 148082
#2 1992   AUG 152280.8 149368.9 151064

 yr_month     HIGH      LOW    MED
1 1992_APR 157623.9 146174.1 148082
2 1992_AUG 152280.8 149368.9 151064
3 1992_DEC 162142.4 146701.6 155504

## tidyr is already loaded for you
# View the head of census_long3
head(census_long3)
# Separate the yr_month column into two
census_long4 <- separate(census_long3, yr_month, c("year", "month"))
# View the first 6 rows of the result
head(census_long4, 6)

 year month     HIGH      LOW    MED
1 1992   APR 157623.9 146174.1 148082
2 1992   AUG 152280.8 149368.9 151064

# ------------- tidy data ------------------
#               Country  year  bmi_val
# 1         Afghanistan Y1980 21.48678
# Apply spread() to bmi_long
bmi_wide <- spread(bmi_long, year, bmi_val)
# View the head of bmi_wide
head(bmi_wide)
# convert columns to rows -----------
# Apply gather() to bmi and save the result as bmi_long
bmi_long <- gather(bmi, year, bmi_val, -Country)
# View the first 20 rows of the result
head(bmi_long, n = 20)

----- hist and plot --------------
# Histogram of BMIs from 2008
hist(bmi$Y2008)
# Scatter plot comparing BMIs from 1980 to those from 2008
plot(bmi$Y1980, bmi$Y2008)

# view head and tail -------------------
# Print bmi to the console
print(bmi)
# View the first 6 rows
head(bmi,n=6)
# View the first 15 rows
head(bmi,n=15)
# View the last 6 rows
tail(bmi, n=6)
# View the last 10 rows
tail(bmi, n=10)
# -----------------------------------
# https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html
# https://www.r-project.org/nosvn/pandoc/dplyr.html
# ---------dplyr simple example--------------------------
install.packages("dplyr")
# Check the structure of bmi
str(bmi)
# Load dplyr
library(dplyr)
# Check the structure of bmi, the dplyr way
glimpse(bmi)
# View a summary of bmi
summary(bmi)
# -----------------------------------
