# ----------------------------------------------------------------------------------------------------
# DATA PREPARATION
# ----------------------------------------------------------------------------------------------------

# Load necessary libraries 
library(tidyverse)
library(skimr)
library(scales)

# Load CSV files into 'trip_data' data frame
trip_data <- list.files(path = "./data/", pattern = "*-divvy-tripdata.csv", full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows %>% 
  arrange(started_at)

# Inspect data frame using 'dim()' and 'head()' 
dim(trip_data)
head(trip_data)



# ----------------------------------------------------------------------------------------------------
# DATA CLEANING
# ----------------------------------------------------------------------------------------------------


# --------------------------------------------------
# Remove Duplicates
# --------------------------------------------------

# Check duplicates in the 'ride_id' column 
sum(duplicated(trip_data$ride_id))

# Remove duplicates in the 'ride_id' column 
trip_data <- trip_data %>% 
  distinct(ride_id, .keep_all = TRUE)

# --------------------------------------------------
# Correct Structural Errors
# --------------------------------------------------

# Check unique values in the 'member_casual' columm 
member_type <- count(trip_data, member_casual, name = "count")
member_type


# Check unique type of the 'rideable_type' column 
bike_type <- count(trip_data, rideable_type, name = "count")
bike_type

# Change values from 'docked_bike' to 'classic_bike' in the 'rideable_type' column 
trip_data_v2 <- trip_data %>% 
  mutate(rideable_type = str_replace_all(rideable_type, "docked_bike", "classic_bike"))

# Recheck unique type of the 'rideable_type' column
bike_type_v2 <- count(trip_data_v2, rideable_type, name = "count")
bike_type_v2


# Check unique values in the 'start_station_name' column 
start_station <- trip_data_v2 %>% 
  count(start_station_name, name = "count") %>% 
  arrange(start_station_name)

start_station

# Check unique values in the 'end_station_name' column 
end_station <- trip_data_v2 %>% 
  count(end_station_name, name = "count") %>% 
  arrange(end_station_name)

end_station


# List test stations in the data frame 
test_station_list <- c("Pawel Bialowas - Test- PBSC charging station", 
                       "Hastings WH 2", 
                       "DIVVY CASSETTE REPAIR MOBILE STATION", 
                       "Base - 2132 W Hubbard Warehouse", 
                       "Base - 2132 W Hubbard", 
                       "NewHastings", 
                       "WestChi", 
                       "WEST CHI-WATSON")

# Remove test stations and assign back to 'trip_data_v2' data frame 
trip_data_v2 <- trip_data_v2 %>% 
  filter(!(trip_data_v2$start_station_name %in% test_station_list | 
           trip_data_v2$end_station_name %in% test_station_list))


# List inconsistent words in station names
words <- c("*", " - Charging", " (Temp)", "amp;", "Public Rack - ", 
           " - north corner", " - south corner", " - midblock south", " - midblock", 
           " - North", " - South", " - East", " - West", 
           " - NE", " - NW", " - SE", " - SW", 
           " - N", " - S", " - E", " - W", 
           " NE", " NW", " SE", " SW")

# Remove inconsistent words in station names (Fixed) 
for (word in words) {
  trip_data_v2 <- trip_data_v2 %>% 
    mutate(start_station_name = str_replace_all(start_station_name, fixed(word, ignore_case = TRUE), "")) %>%
    mutate(end_station_name   = str_replace_all(end_station_name, fixed(word, ignore_case = TRUE), ""))
}

# Remove inconsistent words in station names (Regex) 
trip_data_v2 <- trip_data_v2 %>% 
  mutate(start_station_name = str_replace_all(start_station_name, regex(" (?<=\\s)[N|S|E|W]$", ignore_case = TRUE), "")) %>% 
  mutate(end_station_name   = str_replace_all(end_station_name, regex(" (?<=\\s)[N|S|E|W]$", ignore_case = TRUE), ""))


# Recheck unique values in the 'start_station_name' column 
start_station_v2 <- trip_data_v2 %>% 
  count(start_station_name, name = "count") %>% 
  arrange(start_station_name)

start_station_v2

# Recheck unique values in the 'end_station_name' column 
end_station_v2 <- trip_data_v2 %>% 
  count(end_station_name, name = "count") %>% 
  arrange(end_station_name)

end_station_v2


# --------------------------------------------------
# Handle Missing Values
# --------------------------------------------------

# Check missing values in the data frame 
colSums(is.na(trip_data_v2))

# Preview missing station names  
start_station_location <- trip_data_v2 %>% 
  count(start_lat, start_lng , start_station_name, name = "count") %>% 
  arrange(start_lat, start_lng)

start_station_location

# Preview missing station names 
end_station_location <- trip_data_v2 %>% 
  count(end_lat, end_lng, end_station_name, name = "count") %>% 
  arrange(end_lat, end_lng)

end_station_location


# Impute missing station names and IDs by using geographic coordinate as reference 
digit <- 5
while (digit > 1) {
  trip_data_v2 <- trip_data_v2 %>% 
  # Round latitudes and longitudes
  mutate(start_lat_round = round(start_lat, digits = digit), 
         start_lng_round = round(start_lng, digits = digit), 
         end_lat_round   = round(end_lat,   digits = digit), 
         end_lng_round   = round(end_lng,   digits = digit))

  # Impute missing station names and IDs 
  trip_data_v2 <- trip_data_v2 %>% 
    group_by(start_lat_round, start_lng_round) %>% 
    fill(start_station_name, .direction = "downup") %>% 
    fill(start_station_id,   .direction = "downup") %>% 
    ungroup()
  
  # Impute missing station names and IDs 
  trip_data_v2 <- trip_data_v2 %>% 
    group_by(end_lat_round, end_lng_round) %>%  
    fill(end_station_name, .direction = "downup") %>% 
    fill(end_station_id,   .direction = "downup") %>% 
    ungroup()
  
  # Update digit for next round 
  digit <- digit - 1
}

# Remove unnecessary columns
trip_data_v2 <- trip_data_v2 %>% 
  select(!c(start_lat_round, start_lng_round, end_lat_round, end_lng_round))


# Recheck missing values in the data frame
colSums(is.na(trip_data_v2))

# Preview missing station names  
start_station_location_v2 <- trip_data_v2 %>% 
  count(start_lat, start_lng, start_station_name, name = "count") %>% 
  arrange(start_lat, start_lng)

start_station_location_v2

# Preview missing station names  
end_station_location_v2 <- trip_data_v2 %>% 
  count(end_lat, end_lng, end_station_name, name = "count") %>% 
  arrange(end_lat, end_lng)

end_station_location_v2

# Remove rows with missing values 
trip_data_v2 <- drop_na(trip_data_v2)

# Recheck missing values in the data frame
dim(trip_data_v2)


# --------------------------------------------------
# Add Relevant Columns
# --------------------------------------------------

# Add relevant columns 
trip_data_v2$ride_length_min <- as.double(difftime(trip_data_v2$ended_at, trip_data_v2$started_at, units = "mins"))
trip_data_v2$day_of_week <- wday(trip_data_v2$started_at, label = TRUE)
trip_data_v2$month <- format(trip_data_v2$started_at, "%b")

# Reorder columns 
trip_data_v2 <- within(trip_data_v2, {
  day_of_week <- ordered(day_of_week, levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))
  month <- ordered(month, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
})


# --------------------------------------------------
# Drop Unnecessary Data
# --------------------------------------------------

# Drop irrelevant columns
trip_data_v2 <- trip_data_v2 %>% 
  select( !c(start_station_id, end_station_id) )


# Check summary statistics 
summary(trip_data_v2$ride_length_min)

# Remove error inputs
trip_data_v2 <- trip_data_v2 %>% 
  filter( !(trip_data_v2$start_lat == 0 | trip_data_v2$start_lng == 0 | trip_data_v2$end_lat == 0 | trip_data_v2$end_lng == 0 | 
            trip_data_v2$ride_length_min < 1 | trip_data_v2$ride_length_min > 1440) )

# Recheck summary statistics
summary(trip_data_v2$ride_length_min)


# Remove outliers
ggplot(data = trip_data_v2, aes(x = member_casual, y = ride_length_min, fill = member_casual)) + 
  geom_boxplot() +
  coord_flip() + 
  theme(legend.position = "none") + 
  labs(x = "Member type", 
       y = "Ride length (in minutes)", 
       title = "Box plot showing 'ride_length_min' before removing outliers")

quantiles <- as.numeric(quantile(trip_data_v2$ride_length_min, probs = c(0.25, 0.50, 0.75), na.rm = FALSE))
iqr_value <- IQR(trip_data_v2$ride_length_min)
lower_fence <- quantiles[1] - ( 1.5 * iqr_value )
upper_fence <- quantiles[3] + ( 1.5 * iqr_value )

trip_data_v2 <- trip_data_v2 %>%
  filter(!(trip_data_v2$ride_length_min < lower_fence | trip_data_v2$ride_length_min > upper_fence))

summary(trip_data_v2$ride_length_min)

ggplot(data = trip_data_v2, aes(x = member_casual, y = ride_length_min, fill = member_casual)) + 
  geom_boxplot() +
  coord_flip() + 
  theme(legend.position = "none") + 
  labs(x = "Member type", 
       y = "Ride length (in minutes)", 
       title = "Box plot showing 'ride_length_min' after removing outliers")


# --------------------------------------------------
# Validate the Data
# --------------------------------------------------

skim_without_charts(trip_data_v2)

summary_stats <- summarise(trip_data_v2,
                           sd = sd(ride_length_min),
                           mean = mean(ride_length_min),
                           count = n())

calculate_percentage <- function(n_sd) {
  filtered_count <- trip_data_v2 %>%
  filter(between(ride_length_min, 
                 summary_stats$mean - n_sd * summary_stats$sd, 
                 summary_stats$mean + n_sd * summary_stats$sd)) %>%
  summarise(count = n())
  round((filtered_count$count / summary_stats$count) * 100, 2)
}

percentage_sd1 <- calculate_percentage(1)
percentage_sd2 <- calculate_percentage(2)
percentage_sd3 <- calculate_percentage(3)
