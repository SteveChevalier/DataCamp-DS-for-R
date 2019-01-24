# --------------------------------------------
# ---------- Connect to a database ---------
# --------------------------------------------
# --------Importing data from statistical software packages------------------------------------
install.packages("haven")  # SAS, STATA and SPSS file formats
library(haven)

#SAS: read_sas()
#STATA: read_dta() (or read_stata(), which are identical)
#SPSS: read_sav() or read_por(), depending on the file type.

# Load the haven package
library(haven)
# Import sales.sas7bdat: sales
sales <- read_sas("sales.sas7bdat")
# Display the structure of sales
str(sales)

# haven is already loaded
# Import the data from the URL: sugar
sugar <- read_dta("http://assets.datacamp.com/production/course_1478/datasets/trade.dta")
# Structure of sugar
str(sugar)
# Convert values in Date column to dates
sugar$Date <- as.Date(as_factor(sugar$Date))
# Structure of sugar again
str(sugar)

# haven is already loaded
# Import person.sav: traits
traits <- read_sav("person.sav")
# Summarize traits
summary(traits)
# Print out a subset
subset(traits, Extroversion > 40 & Agreeableness > 40)

# haven is already loaded
# Import SPSS data from the URL: work
work <- read_sav("http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")
# Display summary of work$GENDER
summary (work$GENDER)
# Convert work$GENDER to a factor
work$GENDER <- as_factor(work$GENDER)
# Display summary of work$GENDER again
summary (work$GENDER)

# install.packages("foreign")
library(foreign)

# Load the foreign package
library(foreign)
# Import florida.dta and name the resulting data frame florida
florida <- read.dta("florida.dta")
# Check tail() of florida
tail(florida,6)

nrow(subset(edu_equal_1, age > 40 & literate == "yes"))
nrow(subset(edu_equal_1,ethnicity_head == "Bulgaria" & income > 1000))
# --------Importing data from the web (Part 2)------------------------------------
install.packages("jsonlite")
library(jsonlite)
fromJSON("http://www.omdbapi.com/i=tt0095953&r=json")

# Load the jsonlite package
library(jsonlite)
# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'
# Convert wine_json into a list: wine
wine <- fromJSON(wine_json)
# Print structure of wine
str(wine)

# jsonlite is preloaded
# Definition of quandl_url
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"
# Import Quandl data: quandl_data
quandl_data<- fromJSON(quandl_url)
# Print structure of quandl_data
str(quandl_data)

# The package jsonlite is already loaded
# Definition of the URLs
url_sw4 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0121766&r=json"
# Import two URLs with fromJSON(): sw4 and sw3
sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)
# Print out the Title element of both lists
print(sw4$Title)
print(sw3$Title)
# Is the release year of sw4 later than sw3?
print(sw4$Year > sw3$Year)

# jsonlite is already loaded
# Challenge 1
json1 <- '[1, 2, 3, 4, 5, 6]'
fromJSON(json1)
# Challenge 2
json2 <- '{"a": [1, 2, 3], "b" : [4,5,6]}'
fromJSON(json2)

# jsonlite is already loaded
# Challenge 1
json1 <- '[[1, 2], [3, 4]]'
fromJSON(json1)
# Challenge 2
json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4},{"a": 5, "b": 6}]'
fromJSON(json2)

# jsonlite is already loaded
# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"
# Import the .csv file located at url_csv
water <- read.csv(url_csv, stringsAsFactors = FALSE)
# Convert the data file according to the requirements
water_json <- toJSON(water)
# Print out water_json
print(water_json)

# jsonlite is already loaded
# Convert mtcars to a pretty JSON: pretty_json
pretty_json <- toJSON(mtcars, pretty = TRUE)
# Print pretty_json
print(pretty_json)
# Minify pretty_json: mini_json
mini_json <- minify(pretty_json)
# Print mini_json
print(mini_json)

# foreign is already loaded
# Import international.sav as a data frame: demo
demo <- read.spss("international.sav",to.data.frame = TRUE)
# Create boxplot of gdp variable of demo
boxplot(demo$gdp)

# Pearson's Correlation. It is a measurement to evaluate the linear dependency between two variables, say X and Y
# <- read.spss("international.sav",to.data.frame = TRUE)
# > cor(i$gdp, i$f_illit)
# [1] -0.4476856

# > i
   # id              country  contint m_illit f_illit lifeexpt   gdp
# 1   1 Argentina            Americas     3.0     3.0       16  3375
# 2   2 Benin                  Africa    45.2    74.5        7   521
# 3   3 Burundi                Africa    33.2    48.1        5    86
# 4   4 Chile                Americas     4.2     4.4       14  4523
# 5   5 Dominican Republic   Americas    12.0    12.7       12  2408
# 6   6 El Salvador          Americas    17.6    22.9       11  2302
# 7   7 Ghana                  Africa    37.1    54.3        7   354
# 8   8 Hungary                Europe     0.6     0.7       15  8384
# 9   9 Iran                     Asia    16.5    29.6       11  2079
# 10 10 Laos                     Asia    23.0    39.1        9   361
# 11 11 Malta                  Europe     8.2     6.6       14 11790
# 12 12 Mauritania             Africa    48.5    68.7        7   381
# 13 13 Morocco                Africa    36.7    61.7        9  1463
# 14 14 Namibia                Africa    16.2    17.2       12  2307
# 15 15 Senegal                Africa    43.9    71.5        6   641
# 16 16 Sierra Leone           Africa    60.2    79.5        7   197
# 17 17 Swaziland              Africa    19.6    21.9       10  1653
# 18 18 Macedonia              Europe     1.8     5.9       12  2225
# 19 19 United Arab Emirates     Asia    24.4    19.3       11 22130
# 20 20 Uruguay              Americas     2.7     1.9       15  3274

# foreign is already loaded
# Import international.sav as demo_1
demo_1 <- read.spss("international.sav",to.data.frame = TRUE)
# Print out the head of demo_1
head(demo_1)
# Import international.sav as demo_2
demo_2 <- read.spss("international.sav",to.data.frame = T, use.value.labels = F)
# Print out the head of demo_2
head(demo_2)

# --------Importing data from the web (Part 1)------------------------------------
# Load the readr package
library(readr)
# Import the csv file: pools
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
pools <- read_csv(url_csv)
# Import the txt file: potatoes
url_delim <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/potatoes.txt"
potatoes <- read_tsv(url_delim)
# Print pools and potatoes
pools
potatoes

# https URL to the swimming_pools csv file.
url_csv <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/swimming_pools.csv"
# Import the file using read.csv(): pools1
pools1 <- read.csv(url_csv)
# Load the readr package
library(readr)
# Import the file using read_csv(): pools2
pools2 <- read_csv(url_csv)
# Print the structure of pools1 and pools2
str(pools1)
str(pools2)

# Load the readxl and gdata package
library(readxl)
library(gdata)
# Specification of url: url_xls
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"
# Import the .xls file with gdata: excel_gdata
excel_gdata <- read.xls(url_xls)
# Download file behind URL, name it local_latitude.xls
download.file(url_xls, destfile = "local_latitude.xls")
# Import the local .xls file with readxl: excel_readxl
excel_readxl <- read_excel("local_latitude.xls")

# https URL to the wine RData file.
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"
# Download the wine file to your working directory
download.file(url_rdata, "wine_local.RData")
# Load the wine data into your workspace using load()
load("wine_local.RData")
# Print out the summary of the wine data
summary(wine)

# Load the httr package
library(httr)
# Get the url, save response to resp
url <- "http://www.example.com/"
resp <- GET(url)
# Print resp
resp
# Get the raw content of resp: raw_content
raw_content <- content(resp, as = "raw")
# Print the head of raw_content
head(raw_content)

# httr is already loaded
# Get the url
url <- "http://www.omdbapi.com/?apikey=ff21610b&t=Annie+Hall&y=&plot=short&r=json"
resp <- GET(url)
# Print resp
resp
# Print content of resp as text
content(resp, as = "text")
# Print content of resp
content(resp)

# --------Importing data from databases (Part 2)------------------------------------
# Connect to the database
library(DBI)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Import tweat_id column of comments where user_id is 1: elisabeth
elisabeth <- dbGetQuery(con, "select tweat_id from comments where user_id = 1")
# Print elisabeth
elisabeth

# Connect to the database
library(DBI)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Import post column of tweats where date is higher than '2015-09-21': latest
latest <- dbGetQuery(con, "select post from tweats where date > \'2015-09-21\'")
# Print latest
latest

# Connect to the database
library(DBI)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Create data frame specific
specific <- 
  dbGetQuery(con, 
  "select message from comments where tweat_id = 77 and user_id > 4")
# Print specific
specific

# Connect to the database
library(DBI)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Create data frame short
short <- 
  dbGetQuery(con, "select id, name from users where char_length(name) < 5")
# Print short
short

> result <- dbGetQuery(con, "select post, message FROM tweats INNER JOIN comments on tweats.id = tweat_id WHERE tweat_id = 77")
> result
                                           post            message
#1 2 slices of bread. add cheese. grill. heaven.             great!
#2 2 slices of bread. add cheese. grill. heaven.      not my thing!
#3 2 slices of bread. add cheese. grill. heaven. couldn't be better
#4 2 slices of bread. add cheese. grill. heaven.       saved my day

# Connect to the database
library(DBI)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Send query to the database
res <- dbSendQuery(con, "SELECT * FROM comments WHERE user_id > 4")
# Use dbFetch() twice
dbFetch(res,2)
	#    id tweat_id user_id message
	#1 1022       87       7   nice!
	#2 1000       77       7  great!
dbFetch(res,2)
	#    id tweat_id user_id message
	#1 1011       49       5 love it
	#2 1010       88       6   yuck!
# Clear res
dbClearResult(res)

# Load RMySQL package
library(DBI)
# Connect to the database
library(DBI)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "tweater",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Create the data frame  long_tweats  
long_tweats  <- dbGetQuery(con, "SELECT post, date FROM tweats WHERE char_length(post) > 40") 
# Print long_tweats
print(long_tweats)
# Disconnect from the database
dbDisconnect(con)

# --------Importing data from databases (Part 1)------------------------------------
# install.packages("DBI") #interface, installed with RMySQL
con <- dbConnect(RMySQL::MySQL(),
	dbname = "xxxxx",
	houst = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
	port = 3306,
	user = "student"
	password = "datacamp"
library(DBI)
# Load the DBI package
library(DBI)
# Edit dbConnect() call
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")
> con
<MySQLConnection:0,3>

dbListTables(con)
dbReadTable(con, "table")
dbDisconnect(con)

# Load the DBI package
library(DBI)
# Connect to the MySQL database: con
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")

# Build a vector of table names: tables
tables <- dbListTables(con)
# Display structure of tables
str(tables)
 # chr [1:3] "comments" "tweats" "users"
 
 # Load the DBI package
library(DBI)
# Connect to the MySQL database: con
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Import the users table from tweater: users
users <- dbReadTable(con, "users")
# Print users
users

# Load the DBI package
library(DBI)
# Connect to the MySQL database: con
conDataCamp <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")
# Get table names
table_names <- dbListTables(con)
# Import all tables
tables <- lapply(table_names, dbReadTable, conn = con)
# Print out tables
tables

# --------my local db connections ------------------------------------
#install.packages("RMySQL") #done on destop, works for mariaDB
#install.packages("RPostgreSQL") # done
library(RMySQL)
library(DBI)
# local mariaDB instance
library(DBI)
con_mariaDB <- dbConnect(RMySQL::MySQL(), 
                 dbname = "FEC", 
                 host = "127.0.0.1", 
                 port = 3307,
                 user = "root",
                 password = "admin1")
# good connection
dbGetQuery(conMaria, "Select CAND_NAME from candidatemasterdata where CAND_NAME like \'%Hilary%\'")
# good SQL

# local MySQL instance
library(DBI)
con_MySQL <- dbConnect(RMySQL::MySQL(), 
                 dbname = "nasa", 
                 host = "127.0.0.1", 
                 port = 3306,
                 user = "root",
                 password = "admin1")


				 # postgres
# ms sql

# Connect to the DataCamp MySQL database: con
conDataCamp <- dbConnect(RMySQL::MySQL(), 
                 dbname = "tweater", 
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306,
                 user = "student",
                 password = "datacamp")
