# --------------------------------------------
# ---------- Writing functions in R ---------
# --------------------------------------------
# Writing a function
# A quick refresher -------------------
	# Define ratio() function
	ratio <- function(x, y) {
	  x / y
	}
	# Call ratio() with arguments 3 and 4
	ratio(3,4)
# Arguments
# Rewrite the call to follow best practices
mean(c(1:9, NA),trim = 0.1,na.rm = TRUE)	
?mean

# subsetting lists
# 2nd element in tricky_list
typeof(tricky_list[[2]])
# Element called x in tricky_list
typeof(tricky_list[["x"]])
# 2nd element inside the element called x in tricky_list
typeof(tricky_list[["x"]][[2]])

# exploring lists
# Guess where the regression model is stored
names(tricky_list)
# Use names() and str() on the model element
names(tricky_list$model)
str(tricky_list$model)
# Subset the coefficients element
tricky_list$model[["coefficients"]]
# Subset the wt element
tricky_list$model[["coefficients"]][["wt"]]

# for loops in R - seq_along example for sequence
# Replace the 1:ncol(df) sequence
for (i in seq_along(df)) {
  print(median(df[[i]]))
}
# Change the value of df
df <- data.frame()
# Repeat for loop to verify there is no error
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

# When and how you should write a function -------------------
# Define example vector x
x = c(1,2,3,4,5,6,7,8,9,10)
# Rewrite this snippet to refer to x
(x - min(x, na.rm = TRUE)) /
  (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

# Define example vector x
x <- 1:10
# Define rng
rng <- range(x, na.rm = TRUE)
# Rewrite this snippet to refer to the elements of rng
(x - min(x, rng)) / (max(x, rng) - min(x,rng))

# Define example vector x
x <- 1:10 
rng <- range(x, na.rm = TRUE)
# Use the function template to create the rescale01 function
rescale01 <- function(x) {
  # body
  rng <- range(x, na.rm = TRUE) 
  (x - rng[1]) / (rng[2] - rng[1])
}
# Test your function, call rescale01 using the vector x as the argument
rescale01(x)

# How should you write a function? -------------------
# Define example vectors x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)
# Turn this snippet into a function: both_na()
both_na <- function(x,y) {
  sum(is.na(x) & is.na(y))
}

# Define x, y1 and y2
x <-  c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)
# Call both_na on x, y1
both_na(x,y1)
# Call both_na on x, y2
both_na(x,y2)

# How can you write a good function? -------------------
# Rewrite mean_ci to take arguments named level and x
mean_ci <- function(level, x) {
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - level
  mean(x) + se * qnorm(c(alpha / 2, level / 2))
}

# Alter the arguments to mean_ci
mean_ci <- function(x, level = 0.95) {
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - level
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
}

# Alter the mean_ci function
mean_ci <- function(x, level = 0.95) {
  if (length(x) == 0) {
    warning("`x` was empty", call. = FALSE)
    interval <- c(-Inf, Inf)
  } else {
    se <- sd(x) / sqrt(length(x))
    alpha <- 1 - level
    interval <- mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
  }
  interval
}

# Define a numeric vector x with the values 1, 2, NA, 4 and 5
x <- c(1,2,NA,4,5)
# Call f() with the arguments x = x and y = 3
f(x,3)
# Call f() with the arguments x = x and y = 10
f(x,10)

# Rename the function f() to replace_missings()
replace_missings <- function(x, replacement) {
  # Change the name of the y argument to replacement
  x[is.na(x)] <- replacement
  cat(sum(is.na(x)), replacement, "\n")
  x
}
# Rewrite the call on df$z to match our new names
df$z <- replace_missings(df$z, 0)

replace_missings <- function(x, replacement) {
  # Define is_miss
  is_miss <- is.na(x)
  # Rewrite rest of function to refer to is_miss
  x[is_miss] <- replacement
  cat(sum(is_miss), replacement, "\n")
  x
}

# Functional programming
# Initialize output vector
output <- vector("double", ncol(df))  
# Fill in the body of the for loop
for (i in seq_along(df)) {            
  output[i] <- median(df[[i]])
}
# View the result
output

# Turn this code into col_median()
col_median <- function(df2) {
  output <- vector("double", ncol(df2))  
  for (i in seq_along(df2)) {            
    output[[i]] <- median(df2[[i]])      
  }
  output
}
df2 <- df
output <- col_median(df2)

# Create col_mean() function to find column means
col_mean <- function(df) {
  output <- numeric(length(df))
  for (i in seq_along(df)) {
    output[[i]] <- mean(df[[i]])
  }
  output
}

# Define col_sd() function
col_sd <- function(df) {
  output <- numeric(length(df))
  for (i in seq_along(df)) {
    output[[i]] <- sd(df[[i]])
  }
  output
}

# Add a second argument called power
f <- function(x,power) {
  # Edit the body to return absolute deviations raised to power
  abs(x - mean(x)) ** power
}

# provided by Datacamp
col_summary <- function(df, fun) {
  output <- vector("numeric", length(df))
  for (i in seq_along(df)) {
    output[[i]] <- fun(df[[i]])
  }
  output
}

# Find the column medians using col_median() and col_summary()
col_median(df)
col_summary(df, median)
# Find the column means using col_mean() and col_summary()
col_mean(df)
col_summary(df, mean)
# column interquartile ranges using the function IQR()
# Find the column IQRs using col_summary()
col_summary(df, IQR)

x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))

# purrr map no arg returns a list, map_dbl(), map_lgl logical....etc... int, chr
library(purrr)

# Load the purrr package
library(purrr)
# Use map_dbl() to find column means
map_dbl(df, mean)
# Use map_dbl() to column medians
map_dbl(df, median)
# Use map_dbl() to find column standard deviations
map_dbl(df, sd)

# Find the mean of each column
map_dbl(planes, mean)
# Find the mean of each column, excluding missing values
map_dbl(planes, mean, na.rm = TRUE)
# Find the 5th percentile of each column, excluding missing values
map_dbl(planes, quantile, probs = c(0.05), na.rm = TRUE)

# Find the columns that are numeric
map_lgl(df3, is.numeric)
# Find the type of each column
map_chr(df3, typeof)
# Find a summary of each column
map(df3, summary)
# Advanced inputs and outputs
# http://r-statistics.co/Linear-Regression.html
# Examine the structure of cyl
str(cyl)
# Extract the first element into four_cyls
four_cyls <- cyl[[1]]
# Fit a linear regression of mpg on wt using four_cyls
lm(mpg ~ wt, data = four_cyls)
# Rewrite to call an anonymous function
map(cyl, function(df) lm(mpg ~ wt, data = df))
# Rewrite to use the formula shortcut instead
map(cyl, ~ lm(mpg ~ wt, .))

# Save the result from the previous exercise to the variable models
models <- map(cyl, ~ lm(mpg ~ wt, data = .))
# Use map and coef to get the coefficients for each model: coefs
coefs <- map(models, coef)
# Use string shortcut to extract the wt coefficient 
map(coefs, "wt")

coefs <- map(models, coef)
# use map_dbl with the numeric shortcut to pull out the second element
map_dbl(coefs,2)

# Define models (don't change)
models <- mtcars %>% 
  split(mtcars$cyl) %>%
  map(~ lm(mpg ~ wt, data = .))

# Rewrite to be a single command using pipes 
summaries <- models  %>% map(summary) %>%
  map_dbl("r.squared")

# Advanced inputs and outputs
# Create safe_readLines() by passing readLines() to safely()
safe_readLines <- safely(readLines)
# Call safe_readLines() on "http://example.org"
safe_readLines("http://example.org")
# Call safe_readLines() on "http://asdfasdasdkfjlda"
safe_readLines("http://asdfasdasdkfjlda")

# Define safe_readLines()
safe_readLines <- safely(readLines)

# Use the safe_readLines() function with map(): html
html <- map(urls, safe_readLines)
# Call str() on html
str(html)
# Extract the result from one of the successful elements
html$rproj[[1]]
# Extract the error from the element that was unsuccessful
html$asdf[[2]]

# Define safe_readLines() and html
safe_readLines <- safely(readLines)
html <- map(urls, safe_readLines)
# Examine the structure of transpose(html)
str(transpose(html))
# Extract the results: res
res <- transpose(html)[["result"]]
# Extract the errors: errs
errs <- transpose(html)[["error"]]

# Initialize some objects
safe_readLines <- safely(readLines)
html <- map(urls, safe_readLines)
res <- transpose(html)[["result"]]
errs <- transpose(html)[["error"]]
# Create a logical vector is_ok
is_ok <- map_lgl(errs, is_null)
# Extract the successful results
res[is_ok]
# Find the URLs that were unsuccessful
urls[!is_ok]

# Create a list n containing the values: 5, 10, and 20
n <- list(5,10,20)
# Call map() on n with rnorm() to simulate three samples
map(n, rnorm)

# Initialize n
n <- list(5, 10, 20)
# Create a list mu containing the values: 1, 5, and 10
mu <- list(1,5,10)
# Edit to call map2() on n and mu with rnorm() to simulate three samples
map2(n, mu, rnorm)

# Initialize n and mu
n <- list(5, 10, 20)
mu <- list(1, 5, 10)
# Create a sd list with the values: 0.1, 1 and 0.1
sd <- list(0.1,1,0.1)
# Edit this call to pmap() to iterate over the sd list as well
pmap(list(n, mu,sd), rnorm)

# Name the elements of the argument list
pmap(list(mean = mu, n = n, sd = sd), rnorm)

# Define list of functions
f <- list("rnorm", "runif", "rexp")
# Parameter list for rnorm()
rnorm_params <- list(mean = 10)
# Add a min element with value 0 and max element with value 5
runif_params <- list(min = 0, max = 5)
# Add a rate element with value 5
rexp_params <- list(rate = 5)
# Define params for each function
params <- list(
  rnorm_params,
  runif_params,
  rexp_params
)
# Call invoke_map() on f supplying params as the second argument
invoke_map(f, params, n = 5)

# x "%>%" walk(print)   the pipe passes the "x" as the first argument to walk

# Define list of functions
f <- list(Normal = "rnorm", Uniform = "runif", Exp = "rexp")
# Define params
params <- list(
  Normal = list(mean = 10),
  Uniform = list(min = 0, max = 5),
  Exp = list(rate = 5)
)
# Assign the simulated samples to sims
sims <- invoke_map(f, params, n = 50)
# Use walk() to make a histogram of each element in sims
walk(sims, hist)
# Turn this snippet into find_breaks()
find_breaks <- function(x) {
  rng <- range(x, na.rm = TRUE)
  seq(rng[1], rng[2], length.out = 30)
}
# Call find_breaks() on sims[[1]]
find_breaks(sims[[1]])

# Use map() to iterate find_breaks() over sims: nice_breaks
nice_breaks <- map(sims, find_breaks)
# Use nice_breaks as the second argument to walk2()
walk2(sims, nice_breaks, hist)

# Increase sample size to 1000
sims <- invoke_map(f, params, n = 1000)
# Compute nice_breaks (don't change this)
nice_breaks <- map(sims, find_breaks)
# Create a vector nice_titles
# nice_titles <- c("Normal(10, 1)","Uniform(0, 5)", "Exp(5)")
nice_titles <- c("Normal(10, 1)","Uniform(0, 5)", "Exp(5)")
# Use pwalk() instead of walk2()
# pwalk(hist, x = sims, breaks = nice_breaks, xlab = "", main = nice_titles)
pwalk(list(x = sims, breaks = nice_breaks, main = nice_titles), hist, xlab = "")

# Pipe this along to map(), using summary() as .f
sims %>%
  walk(hist) %>%
  map(summary)

# Robust functions -------------
# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)
both_na <- function(x, y) {
  # Add stopifnot() to check length of x and y
  stopifnot(length(x) == length(y) )
  sum(is.na(x) & is.na(y))
}
# Call both_na() on x and y
both_na(x, y)

# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)
both_na <- function(x, y) {
  # Replace condition with logical
  if (length(x) != length(y)) {
    # Replace "Error" with better message
    stop("x and y must have the same length", call. = FALSE)
  }  
  
  sum(is.na(x) & is.na(y))
}
# Call both_na() 
both_na(x, y)

# use purrr as all functions are type consistent !!!!!!!!!!!!!!!!!!!!!

# sapply calls
A <- sapply(df[1:4], class) 
B <- sapply(df[3:4], class)
C <- sapply(df[1:2], class) 
# Demonstrate type inconsistency
str(A)
str(B)
str(C)
# Use map() to define X, Y and Z
X <- map(df[1:4], class)
Y <- map(df[3:4], class)
Z <- map(df[1:2], class)
# Use str() to check type consistency
str(X)
str(Y)
str(Z)

col_classes <- function(df) {
  # Assign list output to class_list
  class_list <- map(df, class)
  # Use map_chr() to extract first element in class_list
  map_chr(class_list,1)
}
# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()

col_classes <- function(df) {
  class_list <- map(df, class)
  # Add a check that no element of class_list has length > 1
  if (any(map_dbl(class_list, length)>1)) {
    stop("Some columns have more than one class", call. = FALSE)
  }
  # Use flatten_chr() to return a character vector
  flatten_chr(class_list)
}
# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()

# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, 7)

# Remove the x column from diamonds
diamonds_sub$x <- NULL
# Create variable x with value 1
x <- 1
# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, 7)
# Create a threshold column with value 100
diamonds_sub$threshold <- 100
# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, diamonds_sub)

big_x <- function(df, threshold) {
  # Write a check for x not being in df
  if (!"x" %in% names(df)) {
    stop("df must contain variable called x", call. = FALSE)
  }
  # Write a check for threshold being in df
  if ('threshold' %in% names(df)) {
    stop("df must not contain variable called threshold", call. = FALSE)
  }
  dplyr::filter(df, x > threshold)
}

# from video
getOption("digits")
options(digits = 5)
getOption("digits")
options(digits = 7) # put it back
getOption("digits")
?options

# Read in the swimming_pools.csv to pools
pools <- read.csv("swimming_pools.csv")
# Examine the structure of pools
str(pools)
# Change the global stringsAsFactors option to FALSE
options(stringsAsFactors = FALSE)
# Read in the swimming_pools.csv to pools2
pools2 <- read.csv("swimming_pools.csv")
# Examine the structure of pools2
str(pools2)

# Fit a regression model
fit <- lm(mpg ~ wt, data = mtcars)
# Look at the summary of the model
summary(fit)
# Set the global digits option to 2
options(digits = 2)
# Take another look at the summary
summary(fit)

