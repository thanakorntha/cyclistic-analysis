# ----- FIX BIKE AND USER TYPES -----

# See how many observations fall under each bike type
trip_data_v2 %>%
    count(rideable_type, name = "total_ride")

# See how many observations fall under each user type
trip_data_v2 %>%
    count(member_casual, name = "total_ride")


# ----- INSPECT STATION NAMES (PRE) -----

# Pre-examine the start station names
preclean_start_station <- trip_data_v2 %>% 
  count(start_station_name, name = "total_station")

# Pre-examine the end station names
preclean_end_station <- trip_data_v2 %>% 
  count(end_station_name, name = "total_station")


# ----- FIX STATION NAMES -----

# Store a list of test stations in test_station_list
test_station_list <- c("Pawel Bialowas - Test- PBSC charging station",
                       "Hastings WH 2",
                       "DIVVY CASSETTE REPAIR MOBILE STATION",
                       "Base - 2132 W Hubbard Warehouse",
                       "Base - 2132 W Hubbard",
                       "NewHastings",
                       "WestChi",
                       "WEST CHI-WATSON")

# Remove all rows that have eight test stations in both the start and end locations
trip_data_v2 <- trip_data_v2[
    !( trip_data_v2$start_station_name %in% test_station_list | 
       trip_data_v2$end_station_name %in% test_station_list ), ]

# Remove all unwanted characters from the starting and ending station names
trip_data_v2 <- trip_data_v2 %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed("*"), "")) %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed(" - Charging"), "")) %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed(" (Temp)"), "")) %>% 
  mutate(start_station_name = str_replace_all(start_station_name, fixed("amp;"), "")) %>% 
  mutate(end_station_name = str_replace_all(end_station_name, fixed("*"), "")) %>% 
  mutate(end_station_name = str_replace_all(end_station_name, fixed(" - Charging"), "")) %>% 
  mutate(end_station_name = str_replace_all(end_station_name, fixed(" (Temp)"), "")) %>% 
  mutate(end_station_name = str_replace_all(end_station_name, fixed("amp;"), ""))


# ----- INSPECT DATA FRAME -----

# Get the names of the columns
colnames(trip_data_v2)

# Get the dimensions of the data, telling how many rows and columns there are in the data frame
dim(trip_data_v2)

# Print the first and last 6 rows of the data to get a better understanding of the data
head(trip_data_v2)
tail(trip_data_v2)

# Print a summary of the data, showing the number of rows and columns in the data, as well as the data types of each column
str(trip_data_v2)
