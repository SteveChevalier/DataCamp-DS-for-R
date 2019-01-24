# --------------------------------------------
# ---------- Data Manipulation in R ---------
# --------------------------------------------
library(hflights);library(dplyr) # done; install.packages("hflights")

# Both the dplyr and hflights packages are loaded
# Convert the hflights data.frame into a hflights tbl
hflights <- tbl_df(hflights)
# Display the hflights tbl
print(hflights)
# Create the object carriers
carriers <- hflights$UniqueCarrier
carriers

# Changing labels of hflights, part 1 of 2
# Both the dplyr and hflights packages are loaded into workspace
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")
# Add the Carrier column to hflights
hflights$Carrier <- lut[hflights$UniqueCarrier]
# Glimpse at hflights
glimpse(hflights$Carrier)

# The five verbs and select in more detail
# onVariables(select, mutate (new col, values)), onObservations(filter, arrange),  onGroups(summarize)
# do delays tend to shrink or grow during a flight?

# hflights is pre-loaded as a tbl, together with the necessary libraries.
# Print out a tbl with the four columns of hflights related to delay
print(select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay))
# Print out the columns Origin up to Cancelled of hflights
print(select(hflights, 14:19))
# Answer to last question: be concise!
select(hflights, 1:4, 12:21)

# dplyr comes with a set of helper functions that can help you select 
  # groups of variables inside a select() call:
# starts_with("X"): every name that starts with "X",
# ends_with("X"): every name that ends with "X",
# contains("X"): every name that contains "X",
# matches("X"): every name that matches "X", where "X" can be a regular expression,
# num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
# one_of(x): every name that appears in x, which should be a character vector.
# Pay attention here: When you refer to columns directly inside select(), you don't use quotes. 
  # If you use the helper functions, you do use quotes.

# As usual, hflights is pre-loaded as a tbl, together with the necessary libraries.
# Print out a tbl containing just ArrDelay and DepDelay
select(hflights, contains("Delay"))
# Print out a tbl as described in the second instruction, using both helper functions and variable names
select(hflights, 7:9, 19:20)
select(hflights, 7:9, Cancelled, CancellationCode)
# Print out a tbl as described in the third instruction, using only helper functions.
select(hflights, contains("Time"), contains("Delay"))

names(hflights)

# both hflights and dplyr are available
# Finish select call so that ex1d matches ex1r
ex1r <- hflights[c("TaxiIn", "TaxiOut", "Distance")]
ex1d <- select(hflights, contains("Taxi"), Distance)
# Finish select call so that ex2d matches ex2r
ex2r <- hflights[c("Year", "Month", "DayOfWeek", "DepTime", "ArrTime")]
ex2d <- select(hflights, 1:2, 4:5, ArrTime)
# Finish select call so that ex3d matches ex3r
ex3r <- hflights[c("TailNum", "TaxiIn", "TaxiOut")]
ex3d <- select(hflights,TailNum, 17:18 )


# mutate, adds new data to a dataset (adds columns)
h2 <- mutate(h1, loss = ArrDelay - DepDelay)

# hflights and dplyr are loaded and ready to serve you.
# Add the new variable ActualGroundTime to a copy of hflights and save the result as g1.
g1 <- mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime)
# Add the new variable GroundTime to g1. Save the result as g2.
g2 <- mutate(g1,GroundTime = TaxiIn + TaxiOut )
# Add the new variable AverageSpeed to g2. Save the result as g3.
g3 <- mutate(g2, AverageSpeed = Distance / AirTime * 60)
# Print out g3
g3

# hflights and dplyr are ready, are you?
# Add a second variable loss_ratio to the dataset: m1
m1 <- mutate(hflights, loss = ArrDelay - DepDelay, loss_ratio = loss/DepDelay)
# Add the three variables as described in the third instruction: m2
m2 <- mutate(hflights, TotalTaxi = TaxiIn + TaxiOut, 
             ActualGroundTime = ActualElapsedTime - AirTime, 
             Diff = TotalTaxi - ActualGroundTime)
View(m2)

# Filter and arrange
# R comes with a set of logical operators that you can use inside filter():
#   
# x < y, TRUE if x is less than y
# x <= y, TRUE if x is less than or equal to y
# x == y, TRUE if x equals y
# x != y, TRUE if x does not equal y
# x >= y, TRUE if x is greater than or equal to y
# x > y, TRUE if x is greater than y
# x %in% c(a, b, c), TRUE if x is in the vector c(a, b, c)

# hflights is at your disposal as a tbl, with clean carrier names
# All flights that traveled 3000 miles or more
filter(hflights, Distance >= 3000)
# All flights flown by one of JetBlue, Southwest, or Delta
filter(hflights, UniqueCarrier %in% c("JetBlue","Southwest","Delta"))
# All flights where taxiing took longer than flying
filter(hflights,TaxiIn + TaxiOut > AirTime )

# hflights is at your service as a tbl!
# All flights that departed before 5am or arrived after 10pm
filter(hflights, DepTime < 500 | ArrTime > 2200)
# All flights that departed late but arrived ahead of schedule
filter(hflights, DepDelay > 0 & ArrDelay < 0)
# All flights that were cancelled after being delayed
filter(hflights, DepDelay > 0 & Cancelled == 1)

# hflights is already available in the workspace
# Select the flights that had JFK as their destination: c1
c1 <- filter(hflights, Dest == "JFK")
# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2 <- mutate(c1, Date = paste(Year,Month,DayofMonth, sep="-"))
# Print out a selection of columns of c2
select(c2, Date, DepTime, ArrTime, TailNum)

c1 <- filter(hflights, DayOfWeek %in% c(6,7), Distance > 1000, TaxiIn + TaxiOut < 15)
str(c1)
View(c1)

# dplyr and the hflights tbl are available
# Definition of dtc
dtc <- filter(hflights, Cancelled == 1, !is.na(DepDelay))
# Arrange dtc by departure delays
arrange(dtc, DepDelay)
# Arrange dtc so that cancellation reasons are grouped
arrange(dtc,CancellationCode )
# Arrange dtc according to carrier and departure delays
arrange(dtc,UniqueCarrier, DepDelay)

# dplyr and the hflights tbl are available
# Arrange according to carrier and decreasing departure delays
arrange(hflights, UniqueCarrier, desc(DepDelay))
# Arrange flights by total delay (normal order).
arrange(hflights,ArrDelay + DepDelay)

# Summarise and the pipe operator
# hflights and dplyr are loaded in the workspace
# Print out a summary with variables min_dist and max_dist
summarise(hflights, min_dist = min(Distance), max_dist = max(Distance))
# Print out a summary with variable max_div
h2 <- filter(hflights, Diverted == 1)
summarise(h2, max_div = max(Distance))

# Aggregate functions
# 
# You can use any function you like in summarise() so long as the function can take a vector of data and return a single number. R contains many aggregating functions, as dplyr calls them:
# 
# min(x) - minimum value of vector x.
# max(x) - maximum value of vector x.
# mean(x) - mean value of vector x.
# median(x) - median value of vector x.
# quantile(x, p) - pth quantile of vector x.
# sd(x) - standard deviation of vector x.
# var(x) - variance of vector x.
# IQR(x) - Inter Quartile Range (IQR) of vector x.
# diff(range(x)) - total range of vector x.
# 

# hflights is available
# Remove rows that have NA ArrDelay: temp1
temp1 <- filter(hflights, !is.na(ArrDelay))
# Generate summary about ArrDelay column of temp1
summarise(temp1, earliest = min(ArrDelay), average = mean(ArrDelay), latest = max(ArrDelay), sd = sd(ArrDelay))
# Keep rows that have no NA TaxiIn and no NA TaxiOut: temp2
temp2 <- filter(hflights, !is.na(TaxiIn), !is.na(TaxiOut))
# Print the maximum taxiing difference of temp2 with summarise()
summarise(temp2, max_taxi_diff = max(abs(TaxiIn-TaxiOut)))

# dplyr aggregate functions
# 
# dplyr provides several helpful aggregate functions of its own, in addition to the ones that are already defined in R. These include:
#   
# first(x) - The first element of vector x.
# last(x) - The last element of vector x.
# nth(x, n) - The nth element of vector x.
# n() - The number of rows in the data.frame or group of observations that summarise() describes.
# n_distinct(x) - The number of unique values in vector x.
# 
# Next to these dplyr-specific functions, you can also turn a logical test into an aggregating function 
#   with sum() or mean(). A logical test returns a vector of TRUE's and FALSE's. 
#   When you apply sum() or mean() to such a vector, R coerces each TRUE to a 1 and each FALSE to a 0. sum() 
#   then represents the total number of observations that passed the test; mean() represents the proportion.

# hflights is available with full names for the carriers
# Generate summarizing statistics for hflights
summarise(hflights,
          n_obs = n(),
          n_carrier = n_distinct(UniqueCarrier),
          n_dest = n_distinct(Dest)
)
# All American Airline flights
aa <- filter(hflights, UniqueCarrier == "American")
# Generate summarizing statistics for aa 
summarise(aa, 
          n_flights = n(),
          n_canc = sum(Cancelled == 1),
          avg_delay = mean(ArrDelay, na.rm = TRUE)
)

# Chain together mutate(), filter() and summarise()
hflights %>% mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>%
  filter(!is.na(mph) & mph < 70) %>%
  summarise(n_less = n(), n_dest = n_distinct(Dest), min_dist = min(Distance), max_dist = max(Distance))

# Finish the command with a filter() and summarise() call
hflights %>%
  mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>%
  filter(mph < 105 | Cancelled == 1 | Diverted == 1)    %>%
  summarise(n_non = n(), n_dest = n_distinct(Dest), min_dist = min(Distance), max_dist = max(Distance))

# Group_by and working with databases
# hflights is in the workspace as a tbl, with translated carrier names
# Make an ordered per-carrier summary of hflights
hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(p_canc = mean(Cancelled == 1) * 100, 
            avg_delay = mean(ArrDelay, na.rm = TRUE)) %>%
  arrange(avg_delay, p_canc)

# dplyr is loaded, hflights is loaded with translated carrier names
# Ordered overview of average arrival delays per carrier
hflights %>% filter(ArrDelay > 0) %>%
  group_by(UniqueCarrier) %>%
  summarise(avg = mean(ArrDelay)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)

# dplyr and hflights (with translated carrier names) are pre-loaded
# How many airplanes only flew to one destination?
hflights %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n())
# Find the most visited destination for each carrier
hflights %>% 
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)

# Connect to database
# library(data.table)
# hflights2 <- as.data.table(hflights)

# hflights2 is pre-loaded as a data.table
# Use summarise to calculate n_carrier
# summarise(hflights2, n_carrier = n_distinct(UniqueCarrier))
# Set up a connection to the mysql database
my_db <- src_mysql(dbname = "dplyr", 
                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "student",
                   password = "datacamp")
# Reference a table within that source: nycflights
nycflights <- tbl(my_db, "dplyr")
# glimpse at nycflights
glimpse(nycflights)
# Ordered, grouped summary of nycflights
nycflights %>% group_by(carrier) %>%
  summarise(n_flights = n(), avg_delay = mean(arr_delay)) %>%
  arrange(avg_delay)

# new version; rename, mute, count, group_by short hand, non ep joins, multi table, distinct, 
# test on local sql
# Set up a connection to the mysql database
my_db <- src_mysql(dbname = "book_other", 
                   host = "127.0.0.1", 
                   port = 3307, 
                   user = "root",
                   password = "admin1")
# Reference a table within that source: nycflights
t_tweets <- tbl(my_db, "trumpstweets")
# glimpse at nycflights
glimpse(t_tweets)
# Ordered, grouped summary of nycflights
t_tweets %>% 
  select(row_names, source, text, created_at, retweet_count, favorite_count, is_retweet, id_str) %>%
  filter(row_names >=1 & row_names < 20)
  
