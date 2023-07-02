## ----------------------- ##
#####   LOAD PACKAGES   #####
## ----------------------- ##

# Install the required packages
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")

# Load the required packages
library(tidyverse)
library(skimr)
library(janitor)


## ------------------------------------- ##
#####   IMPORT AND COMBINE THE DATA   #####
## ------------------------------------- ##

# Import and combine the data
trip_data <- list.files(path = "./data/raw-data/", 
                        pattern = "*.csv", 
                        full.names = TRUE) %>%
  lapply(read_csv) %>%
  bind_rows %>% 
  arrange(started_at)


## ----------------------- ##
#####   SKIM THE DATA   #####
## ----------------------- ##

# Preview the data using the head() function
head(trip_data)

# View all column names
colnames(trip_data)

# Obtain a summary of the data frame
skim_without_charts(trip_data)


## ------------------------ ##
#####   CLEAN THE DATA   #####
## ------------------------ ##

# Create a new data frame with the desired columns
trip_data_v2 <- trip_data %>%
  select(ride_id, rideable_type, member_casual, started_at, ended_at)


## ---------------------------- ##
#####   TRANSFORM THE DATA   #####
## ---------------------------- ##

# Calculate the difference between the two times and store it as the 'ride_length' variable
trip_data_v2$ride_length <- as.double(difftime(trip_data_v2$ended_at, trip_data_v2$started_at, units = "mins"))

# Extract the day of the week from the 'trip_data_v2$started_at' column
trip_data_v2$day_of_week <- weekdays(trip_data_v2$started_at)

# Extract the month of the year from the 'trip_data_v2$started_at' column
trip_data_v2$month <- format(trip_data_v2$started_at, "%b")


## --------------------------- ##
#####   SKIM THE NEW DATA   #####
## --------------------------- ##

# Preview the data using the head() function
head(trip_data_v2)

# View all column names
colnames(trip_data_v2)

# Obtain a summary of the new data frame
skim_without_charts(trip_data_v2)


## ------------------------- ##
#####   REMOVE OUTLIERS   #####
## ------------------------- ##

# Identify the instances with outlier ride lengths
error_rows <- trip_data_v2$ride_length < 1 
timeout_rows <- trip_data_v2$ride_length > 1440

# Retain only the rows with positive ride lengths
trip_data_v2 <- trip_data_v2[!(error_rows | timeout_rows), ]

# Verify if any rows remain in the data frame
nrow(trip_data_v2)

# Obtain a summary of the new data frame
skim_without_charts(trip_data_v2)


## --------------------- ##
#####   EXPORT FILE   #####
## --------------------- ##

# Export full ride trip data for data visualization
write.csv(trip_data_v2, file = "./data/trip-data.csv", row.names = FALSE, na = '', quote = FALSE)
