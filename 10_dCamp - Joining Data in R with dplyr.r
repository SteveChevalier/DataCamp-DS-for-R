# --------------------------------------------
# ---------- Writing functions in R  Joining Data ---------
# --------------------------------------------
library(dplyr)
# Mutating Joins -----------------------------------
# Keys
  # left_join(tabl1, tbl2, by = c("key", "etc...")
  # inner_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
  # left_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
  # right_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
  # full_join(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...)
  # semi_join(x, y, by = NULL, copy = FALSE, ...)
  # anti_join(x, y, by = NULL, copy = FALSE, ...)

# Complete the code to join artists to bands
bands2 <- left_join(bands, artists, by = c("first","last"))
# Examine the results
bands2

# Complete the code to join artists to bands
bands2 <- left_join(bands, artists, by = c("first","last"))
# Examine the results
bands2


# Fix the code to recreate bands2
left_join(bands, artists, by = c("first", "last"))
# Finish the code below to recreate bands3 with a right join
bands2 <- left_join(bands, artists, by = c("first", "last"))
bands3 <- right_join(artists,bands, by = c("first", "last"))
# Check that bands3 is equal to bands2
setequal(bands2,bands3)

# Join albums to songs using inner_join()
inner_join(albums, songs, by = "album")
# Join bands to artists using full_join()
full_join(bands, artists, by = c("first","last"))

# Join albums to songs using inner_join()
inner_join(songs, albums, by = "album")
# Join bands to artists using full_join()
full_join(artists, bands, by = c("first","last"))

# Find guitarists in bands dataset (don't change)
temp <- left_join(bands, artists, by = c("first", "last"))
temp <- filter(temp, instrument == "Guitar")
select(temp, first, last, band)

# Reproduce code above using pipes
bands %>% 
  left_join(artists, by = c("first", "last")) %>%
  filter(instrument == "Guitar") %>%
  select(first, last, band)

# Examine the contents of the goal dataset
goal
# Create goal2 using full_join() and inner_join() 
goal2 <- artists %>%
  full_join(bands, by = c("first","last")) %>%
  inner_join(songs, by = c("first","last"))
# Check that goal and goal2 are the same
setequal(goal, goal2)
# Create one table that combines all information
artists %>%
  full_join(bands, by = c("first","last")) %>%
  full_join(songs, by = c("first","last")) %>%
  full_join(albums, by = c("album", "band"))

# Filtering joins and set operations  ---------------------------
# View the output of semi_join()
artists %>% 
  semi_join(songs, by = c("first", "last"))
# Create the same result
artists %>% 
  right_join(songs, by = c("first", "last")) %>% 
  filter(!is.na(instrument)) %>% 
  select(first, last, instrument)

albums %>% 
  # Collect the albums made by a band - ny note; this makes no scence, gives count of all rows not just A band
  semi_join(bands, by = "band") %>% 
  # Count the albums made by a band
  nrow()

# these produce the same result
tracks %>% semi_join(
  matches,
  by = c("band", "year", "first")
)

tracks %>% filter(
  (band == "The Beatles" & 
     year == 1964 & first == "Paul") |
    (band == "The Beatles" & 
       year == 1965 & first == "John") |
    (band == "Simon and Garfunkel" & 
       year == 1966 & first == "Paul")
)

# Return rows of artists that don't have bands info
artists %>% 
  anti_join(bands, by = c("first","last"))

# Check whether album names in labels are mis-entered
labels %>% 
  anti_join(albums, by = "album")

# Determine which key joins labels and songs
labels
songs
# Check your understanding
songs %>% 
  # Find the rows of songs that match a row in labels
  semi_join(labels, by = "album") %>% 
  # Number of matches between labels and songs
  nrow()

# example from https://www.safaribooksonline.com/library/view/the-r-book/9780470510247/ch002-sec073.html
setA<-c("a", "b", "c", "d", "e")
setB<-c("d", "e", "f", "g")
# union() every row in one or more data, intersect() both dataset, setdiff() first but not 2nd
# The union of two sets is everything in the two sets taken together, but counting elements only once that are common to both sets:
union(setA,setB)  
# The intersection of two sets is the material that they have in common:
intersect(setA,setB)
# Note, however, that the difference between two sets is order-dependent. It is the material that is in the first named set, that is not in the second named set. Thus setdiff(A,B) gives a different answer than setdiff(B,A). For our example,
setdiff(setA,setB)
setdiff(setB,setA)
setequal(setA,setB)

aerosmith %>% 
  # Create the new dataset using a set operation
  union(greatest_hits) %>% 
  # Count the total number of songs
  nrow()

# Create the new dataset using a set operation
aerosmith %>% 
  intersect(greatest_hits)

# Select the song names from live
live_songs <- live %>% select("song")
# Select the song names from greatest_hits
greatest_songs <- greatest_hits %>% select("song")
# Create the new dataset using a set operation
live_songs %>% setdiff(greatest_songs, live_songs)

# practice not finished - live = 16 songs, greatest_hits = 17
# Select songs from live and greatest_hits
# Select songs from live and greatest_hits
live_songs <- live %>% select("song")
greatest_songs <- greatest_hits  %>% select("song")
# Return the songs that only exist in one dataset
uSongs <- union(live_songs, greatest_songs)
iSongs <- intersect(live_songs, greatest_songs)
dSongs <- setdiff(uSongs,iSongs)

# the answer
# Select songs from live and greatest_hits
live_songs <- live %>% select(song)
greatest_songs <- greatest_hits %>% select(song)

# Return the songs that only exist in one dataset
all_songs <- live_songs %>% union(greatest_songs)
common_songs <- live_songs %>% intersect(greatest_songs)
all_songs %>% setdiff(common_songs)

# comparing dataset - same set of rows in any order
# Check if same order: definitive and complete
identical(definitive,complete)
# Check if any order: definitive and complete
setequal(definitive,complete)
# Songs in definitive but not complete
setdiff(definitive,complete)
# Songs in complete but not definitive
setdiff(complete,definitive)

# Return songs in definitive that are not in complete
definitive %>% 
  anti_join(complete)
# Return songs in complete that are not in definitive
complete %>% 
  anti_join(definitive)

# Check if same order: definitive and union of complete and soundtrack
identical(definitive,union(complete,soundtrack))
# Check if any order: definitive and union of complete and soundtrack
setequal(definitive,union(complete,soundtrack))

# Assembling data ---------------------------

# Examine side_one and side_two
side_one
side_two
# Bind side_one and side_two into a single dataset
side_one %>% 
  rbind(side_two)

# Examine discography and jimi
discography
jimi
jimi %>% 
  # Bind jimi into a single data frame
  bind_rows(.id = "album") %>% 
  # Make a complete data frame
  left_join(discography)


# Examine hank_years and hank_charts
hank_years
hank_charts

hank_years %>% 
  # Reorder hank_years alphabetically by song title
  arrange(song) %>% 
  # Select just the year column
  select(year) %>% 
  # Bind the year column
  bind_cols(hank_charts) %>% 
  # Arrange the finished dataset
  arrange(year, song)


# Advanced joining --------------------------
# video notes -----
data.frame()
as.data.frame()
# better to use....
data_frame()
as_data_frame()

data_frame(
  Beatles = c("john", "Paul", "george", "ringo"),
  Stones = c("mick", "keith", "charlie","ronnie"),
  Zepplins = c("robert","jimmy","john Paul", "john")
)
# # A tibble: 4 x 3
# Beatles Stones  Zepplins 
# <chr>   <chr>   <chr>    
#   1 john    mick    robert   
# 2 Paul    keith   jimmy    
# 3 george  charlie john Paul
# 4 ringo   ronnie  john 

# frm lessons
# Make combined data frame using data_frame()
data_frame(year = hank_year,song = hank_song,peak = hank_peak) %>% 
  # Extract songs where peak equals 1
  filter(peak == 1)

# Examine the contents of hank
hank
# Convert the hank list into a data frame
as_data_frame(hank) %>% 
  # Extract songs where peak equals 1
  filter(peak == 1)

# Examine the contents of michael
michael

bind_rows(michael, .id = "album") %>% 
  group_by(album) %>% 
  mutate(rank = min_rank(peak)) %>% 
  filter(rank == 1) %>% 
  select(-rank, -peak)

seventies %>% 
  # Coerce seventies$year into a useful numeric
  mutate(year = as.character(year)) %>% 
  mutate(year = as.numeric(year)) %>% 
  # Bind the updated version of seventies to sixties
  bind_rows(sixties) %>% 
  arrange(year)

# Load the tibble package
library(tibble)
stage_songs %>% 
  # Add row names as a column named song
  rownames_to_column(var = "song") %>% 
  # Left join stage_writers to stage_songs
  left_join(stage_writers, by = "song")

# Examine the result of joining singers to two_songs
two_songs %>% inner_join(singers, by = "movie")
# Remove NA's from key before joining
two_songs %>% 
  filter(!is.na(movie)) %>% 
  inner_join(singers, by = "movie")

movie_years %>% 
  # Left join movie_studios to movie_years
  left_join(movie_studios, by = "movie") %>%  # look @ this to see new names
  # Rename the columns: artist and studio
  rename("artist" = "name.x") %>%
  rename("studio" = "name.y")

# Identify the key column
elvis_songs
elvis_movies

elvis_movies %>% 
  # Left join elvis_songs to elvis_movies by this column
  left_join(elvis_songs, by = c("name" = "movie")) %>% 
  # Rename columns
  rename("movie" = "name") %>%
  rename("song" = "name.y")

# use purrr reduce()
# Load the purrr library
library(purrr)
# Place supergroups, more_bands, and more_artists into a list
list(supergroups, more_bands, more_artists) %>% 
  # Use reduce to join together the contents of the list
  reduce(left_join, by = c("first","last"))

list(more_artists, more_bands, supergroups) %>% 
  # Return rows of more_artists in all three datasets
  reduce(semi_join, by = c("first","last"))

merge(names, plays, by =  )

# Case study -------------------------------
install.packages("Lahman")  # realworld baseball database
library(Lahman)
data(AllstarFull) # load data package
player_appearances <- with(AllstarFull, rev(sort(table(playerID))))

# -------------------
# Examine lahmanNames
lahmanNames
# Find variables in common
reduce(lahmanNames, intersect)

lahmanNames %>%  
  # Bind the data frames in lahmanNames
  bind_rows(.id = "dataframe") %>%
  # Group the result by var
  group_by(var)  %>%
  # Tally the number of appearances
  tally(n()) %>%
  # Filter the data
  filter(n > 1) %>% 
  # Arrange the results
  arrange(desc(n))

lahmanNames %>% 
  # Bind the data frames
  bind_rows(.id = "dataframe") %>%
  # Filter the results
  filter(var == "playerID") %>% 
  # Extract the dataframe variable
  `$`("dataframe")

library(dplyr) # make sure this is active
# salaries -------
# df of distinct list of players
players <- Master %>% 
  # Return one row for each distinct player
  distinct(playerID, nameFirst, nameLast)

players %>% 
  # Find all players who do not appear in Salaries
  left_join(Salaries) %>%
  # Count them
  count()

# number of players that have salary data
players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries, by = "playerID") %>%
  # Count them
  count()

# add a join to the pipe to determine how many (if any) unsalaried players played at least one game.
players %>% 
  anti_join(Salaries, by = "playerID") %>% 
  # How many unsalaried players appear in Appearances?
  semi_join(Appearances, by = "playerID") %>% 
  count()

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries, by = "playerID") %>% 
  # Join them to Appearances
  left_join(Appearances, by = "playerID") %>% 
  # Calculate total_games for each player
  group_by(playerID) %>%
  summarize(total_games = sum(G_all, na.rm = TRUE)) %>%
  # Arrange in descending order by total_games
  arrange(desc(total_games))

# How many at-bats?
players %>%
  # Find unsalaried players
  anti_join(Salaries, by = "playerID") %>% 
  # Join Batting to the unsalaried players
  left_join(Batting, by = "playerID") %>% 
  # Group by player
  group_by(playerID) %>% 
  # Sum at-bats for each player
  summarize(total_at_bat = sum(AB, na.rm = TRUE)) %>% 
  # Arrange in descending order
  arrange(desc(total_at_bat))

# Hall of fame nominations
# Find the distinct players that appear in HallOfFame
nominated <- HallOfFame %>% distinct(playerID)
# Count the number of players in nominated
nominated %>% count()
# Join to Master
# Return playerID, nameFirst, nameLast  
nominated_full <- nominated %>% 
  left_join(Master, by = "playerID") %>% 
  select(playerID, nameFirst, nameLast)

# Hall of fame inductions
# Find distinct players in HallOfFame with inducted == "Y"
inducted <- HallOfFame %>% 
  filter(inducted == "Y") %>% 
  distinct(playerID)
inducted %>% 
  # Count the number of players in inducted
  count()
inducted_full <- inducted %>% 
  # Join to Master
  left_join(Master, by = "playerID") %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)

# Awards
nAwards <- AwardsPlayers %>% 
  group_by(playerID) %>%
  tally()
nAwards %>% 
  # Filter to just the players in inducted 
  semi_join(inducted, by = "playerID") %>% 
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n,na.rm = TRUE))
nAwards %>% 
  # Filter to just the players in nominated 
  semi_join(nominated, by = "playerID") %>%
  # Filter to players NOT in inducted 
  anti_join(inducted, by = "playerID") %>%
  # Calculate the mean number of awards per player
  summarize(avg_n = mean(n, na.rm = TRUE))

# Salary
# Find the players who are in nominated, but not inducted
notInducted <- nominated %>% setdiff(inducted)

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(notInducted, by = "playerID") %>% 
  # Calculate the max salary by player
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  # Calculate the average of the max salaries
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(inducted, by = "playerID") %>% 
  # Calculate the max salary by player
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  # Calculate the average of the max salaries
  summarize(avg_salary = mean(max_salary ,na.rm = TRUE))


# Retirement
Appearances %>% 
  # Filter Appearances against nominated
  semi_join(nominated, by = "playerID") %>% 
  # Find last year played by player
  group_by(playerID) %>% 
  summarise(last_year = max(yearID, na.rm = TRUE)) %>% 
  # Join to full HallOfFame
  left_join(HallOfFame, by = "playerID") %>%
  filter(last_year >= yearID)
