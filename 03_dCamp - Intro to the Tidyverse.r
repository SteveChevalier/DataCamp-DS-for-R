# --------------------------------------------
# ---------- Introduction to the Tidyverse ---------
# --------------------------------------------
# ----------Data wrangling  ------------------
# install.packages("gapminder") # done
# Load the gapminder package
library(gapminder)
# Load the dplyr package
library(dplyr)
# Look at the gapminder dataset
View(gapminder)

# A tibble: 1,704 x 6
#   country     continent  year lifeExp      pop gdpPercap
#   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
# 1 Afghanistan Asia       1952    28.8  8425333      779.
# 2 Afghanistan Asia       1957    30.3  9240934      821.
# 3 Afghanistan Asia       1962    32.0 10267083      853.
 
# library calls not repeated here
# Filter the gapminder dataset for the year 1957
gapminder %>% filter(year == 1957)

 # Filter for China in 2002
gapminder %>% filter(country == "China",year == 2002) 

# sort = arrange([desc](column)
# Sort in ascending order of lifeExp
gapminder %>% arrange(lifeExp)
# Sort in descending order of lifeExp
gapminder %>% arrange(desc(lifeExp))

# Filter for the year 1957, then arrange in descending order of population
gapminder %>% filter(year == 1957) %>% arrange(desc(pop)) 

# Use mutate to CHANGE lifeExp to be in months
gapminder %>% mutate(lifeExp = 12 * lifeExp)
# Use mutate to create a new column called lifeExpMonths
gapminder %>% mutate(lifeExpMonths =  12 * lifeExp)

# Filter, mutate, and arrange the gapminder dataset
gapminder %>% filter(year == 2007) %>% mutate(lifeExpMonths =  12 * lifeExp) %>% arrange(desc(lifeExpMonths))

# ----------Data Visualization --------------------------
# usefull to save data as a new DF
gapminder_2007 <- gapminder %>% filter(year == 2007)
library(ggplot2)

# Load the ggplot2 package as well
library(gapminder);library(dplyr);library(ggplot2)
# Create gapminder_1952
gapminder_1952 <- gapminder %>% filter(year == 1952)

library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>% filter(year == 1952)
# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()
  
library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>% filter(year == 1952)

# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()
  
library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%   filter(year == 1952)

# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() + scale_x_log10()

library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>% filter(year == 1952)
# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point() + scale_x_log10() + scale_y_log10()

# color = continent, size = pop))
library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent)) +
  geom_point() + scale_x_log10() + scale_y_log10()   

library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, 
    size = gdpPercap )) +
  geom_point() +
  scale_x_log10()
  
# + facet_wrap(~ continent) # ~ = "by"
library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%
  filter(year == 1952)
# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952, 
  aes(x = pop, y = lifeExp, color = continent, size = gdpPercap )) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~continent )
  
library(gapminder);library(dplyr);library(ggplot2)
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop )) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year)
 
# ----------Grouping and summarizing --------------------
# gapminder %>% summarize(df, meanLifeExp = mean(lifeExp), moreVars) # filter first if needed

library(gapminder);library(dplyr)
# Summarize to find the median life expectancy
gapminder %>%
  summarize(medianLifeExp = median(lifeExp))

library(gapminder);library(dplyr)
# Filter for 1957 then summarize the median life expectancy
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp))
  
library(gapminder);library(dplyr)
# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))

library(gapminder);library(dplyr)
# Find median life expectancy and maximum GDP per capita in each year
gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))
  
library(gapminder);library(dplyr)
# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))
  
library(gapminder);library(dplyr)
# Find median life expectancy and maximum GDP per capita in each year/continent combination
gapminder %>%
  group_by(continent,year) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))

library(gapminder);library(dplyr);library(ggplot2)
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))
# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, 
  aes(x = year, y = medianLifeExp)) +
  geom_point() +
  expand_limits(y = 0)
  
library(gapminder);library(dplyr);library(ggplot2)
# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))
# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, 
  aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y = 0)
  
library(gapminder);library(dplyr);library(ggplot2)
# Summarize the median GDP and median life expectancy per continent in 2007
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap),medianLifeExp = median(lifeExp))
# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_year_continent, 
  aes(x = medianLifeExp, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

library(gapminder);library(dplyr);library(ggplot2)
# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap),medianLifeExp = median(lifeExp))
# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, 
  aes(x = medianGdpPercap, y = medianLifeExp, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

# ----------Types of visualizations -------------------  
# line plots, geom_line()
library(gapminder);library(dplyr);library(ggplot2)
# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))
# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, 
  aes(x = year, y = medianGdpPercap)) +
  geom_line() +
  expand_limits(y = 0)

library(gapminder);library(dplyr);library(ggplot2)
# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))
# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, 
  aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_line() +
  expand_limits(y = 0)

# bar plots, geom_col()
library(gapminder);library(dplyr);library(ggplot2)
# Summarize the median gdpPercap by year and continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))
# Create a bar plot showing medianGdp by continent
ggplot(by_continent, 
  aes(x = continent, y = medianGdpPercap)) +
  geom_col() +
  expand_limits(y = 0)

library(gapminder);library(dplyr);library(ggplot2)
# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>% filter(year == 1952, continent == "Oceania")
# Create a bar plot of gdpPercap by country
ggplot(oceania_1952, 
  aes(y = gdpPercap, x = country)) +
  geom_col() +
  expand_limits(y = 0)

# histogram, shows distribution, geom_historgram(binwidth = x), consider scale
gapminder_1952
# A tibble: 142 x 6
#   country     continent  year lifeExp      pop gdpPercap
#   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
# 1 Afghanistan Asia       1952    28.8  8425333      779.
# 2 Albania     Europe     1952    55.2  1282697     1601.
library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%   filter(year == 1952)
# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(x = pop)) +
    geom_histogram()

library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%   filter(year == 1952)
# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x = pop)) +
    geom_histogram() +
    scale_x_log10()

# box plots, distribution of grouped data, eom_boxplot()
library(gapminder);library(dplyr);library(ggplot2)
gapminder_1952 <- gapminder %>%   filter(year == 1952)
# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
    geom_boxplot() +
    scale_y_log10()

# The aim of this tutorial is to describe how to modify plot titles (main title, axis labels and legend titles) using R software and ggplot2 package.
# ggtitle(label) # for the main title
# xlab(label) # for the x axis label
# ylab(label) # for the y axis label
# labs(...) # for the main title, axis labels and legend titles
# ggplot(df, .........) + ggtitle("Plot of length \n by dose") + xlab("Dose (mg)") + ylab("Teeth length")
library(gapminder);library(dplyr);library(ggplot2))
gapminder_1952 <- gapminder %>% filter(year == 1952)
# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() + 
  ggtitle("Comparing GDP per capita across continents") 
  
  
