# -----------------------------------
# Snippets - Excel Import Examples (last lesson first)
# -----------------------------------
# install.packages("tidyverse") # done
# install.packages("readxl") # not needed because of above
library("readxl")
# Compared to many of the existing packages (e.g. gdata, xlsx, xlsReadWrite) readxl has no external dependencies
# https://readxl.tidyverse.org/
# Print out the names of both spreadsheets
excel_sheets("E:/One Drive/OneDrive/data_mining/DataCamp examples/urbanpop.xlsx")

# -----Adapting Sheets---------------
# createSheet(book, name "xxxxxx.xlsx", createSheet(book, name = "xxx_2010")
# writeWorksheet(book, pop_xxx, sheet = "xxx_2010", saveWorkbook(book, file = "new.xlsx")
# renameSheet(book,  "old_name", "new_name), removeSheet(book, sheet = "num or name"
my_book <- loadWorkbook("urbanpop.xlsx")
# Add a worksheet to my_book, named "data_summary"
createSheet(my_book, "data_summary")
getSheets(my_book)

# populate new sheet  and save to a new file --------------
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
# Add a worksheet to my_book, named "data_summary"
createSheet(my_book, "data_summary")
# Create data frame: summ
sheets <- getSheets(my_book)[1:3]
dims <- sapply(sheets, function(x) dim(readWorksheet(my_book, sheet = x)), USE.NAMES = FALSE)
summ <- data.frame(sheets = sheets,
                   nrows = dims[1, ],
                   ncols = dims[2, ])
# Add data in summ to "data_summary" sheet
writeWorksheet(my_book,summ,  "data_summary" )
saveWorkbook(my_book, file = "summary.xlsx")

# -------  renaming sheets ------------
# my_book is available
getSheets(my_book)
# Rename "data_summary" sheet to "summary"
renameSheet(my_book, "data_summary","summary" )
# Print out sheets of my_book
getSheets(my_book)
# Save workbook to "renamed.xlsx"
saveWorkbook(my_book, file = "renamed.xlsx")

# --- Removing sheets ---------------
# Load the XLConnect package
library(XLConnect)
# Build connection to renamed.xlsx: my_book
my_book <- loadWorkbook("renamed.xlsx")
getSheets(my_book)
# Remove the fourth sheet
removeSheet(my_book, sheet = 4)
getSheets(my_book)
# Save workbook to "clean.xlsx"
saveWorkbook(my_book, file = "clean.xlsx")

# ----XL Connect  -------------------
install.packages("XLConnect")
library(XLConnect)
loadWorkbook()

# Load the XLConnect package
library(XLConnect)
# Build connection to urbanpop.xlsx: my_book
my_book <- loadWorkbook("urbanpop.xlsx")
# Print out the class of my_book
class(my_book)

# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
# List the sheets in my_book
getSheets(my_book)
# Import the second sheet in my_book
my_book2 <- my_book[2]
  # startRow = xx, endRow = xx, startCol = 2, header = FALSE
my_book2

# get selected rows, combine rows to new sheet
# Build connection to urbanpop.xlsx
my_book <- loadWorkbook("urbanpop.xlsx")
my_book
# Import columns 3, 4, and 5 from second sheet in my_book: urbanpop_sel
urbanpop_sel <- readWorksheet(my_book, sheet = 2, startCol = 3, endCol = 5)
urbanpop_sel
# Import first column from second sheet in my_book: countries
countries <- readWorksheet(my_book, sheet = 2, startCol = 1, endCol = 1)
countries
# cbind() urbanpop_sel and countries together: selection
selection <- cbind(countries, urbanpop_sel)
selection


# -----gdata-------------------------
# needs perl installed <<<<<<<<<<-----------------
install.packages("gdata")
library(gdata)
urban_pop <- read.xls("E:/One Drive/OneDrive/data_mining/DataCamp examples/urbanpop.xls","1967-1974")
head(urban_pop,11)

# Column names for urban_pop -------------
columns <- c("country", paste0("year_", 1967:1974))
urban_pop <- read.xls("urbanpop.xls", sheet = 2, skip = 50, header = FALSE, stringsAsFactors = FALSE, col.names = columns)
head(urban_pop, 10)

# ----------------------
# Add code to import data from all three sheets in urbanpop.xls
# note; na.omit to remove "NA" and cbind() to combine into one df
path <- "urbanpop.xls"
urban_sheet1 <- read.xls(path, sheet = 1, stringsAsFactors = FALSE)
urban_sheet2 <- read.xls(path, sheet = 2, stringsAsFactors = FALSE)
urban_sheet3 <- read.xls(path, sheet = 3, stringsAsFactors = FALSE)
# Extend the cbind() call to include urban_sheet3: urban
urban <- cbind(urban_sheet1, urban_sheet2[-1], urban_sheet3[-1])
# Remove all rows with NAs from urban: urban_clean
urban_clean <- na.omit(urban)
# Print out a summary of urban_clean
summary(urban_clean)

# -----------------------------------
# skip and head (no col_names)
urbanpop_sel <- read_excel("E:/One Drive/OneDrive/data_mining/DataCamp examples/urbanpop.xlsx", 
	skip = 21, sheet=2, col_names = FALSE )
# Print out the first observation from urbanpop_sel
head(urbanpop_sel, n=1)

# -----------------------------------
# Import the the first Excel sheet of urbanpop_nonames.xlsx (R gives names): pop_a
pop_a <- read_excel("E:/One Drive/OneDrive/data_mining/DataCamp examples/urbanpop_nonames.xlsx", 
	sheet = 1, col_names = FALSE)
# Import the the first Excel sheet of urbanpop_nonames.xlsx (specify col_names): pop_b
cols <- c("country", paste0("year_", 1960:1966))
pop_b <- read_excel("E:/One Drive/OneDrive/data_mining/DataCamp examples/urbanpop_nonames.xlsx", 
	sheet = 1, col_names = cols)
summary(pop_a)
summary(pop_b)

# -----------------------------------
# crt list of data frams from all sheets in an excel file
# Read all Excel sheets with lapply(): pop_list
pop_list <- lapply(excel_sheets("urbanpop.xlsx"),
                  read_excel,
                  path = "urbanpop.xlsx")
# Display the structure of pop_list
str(pop_list)

# -----------------------------------
# Read the sheets, one by one
pop_1 <- read_excel("urbanpop.xlsx", sheet = 1)
pop_2 <- read_excel("urbanpop.xlsx", sheet = 2)
pop_3 <- read_excel("urbanpop.xlsx", sheet = 3)
# Put pop_1, pop_2 and pop_3 in a list: pop_list
pop_list <- list(pop_1,pop_2,pop_3)
# Display the structure of pop_list
str(pop_list)
# -----------------------------------
# -----------------------------------
