# ---------------------- #
#   SET UP ENVIRONMENT   #
# ---------------------- #

# Set default theme
theme_set(theme_bw())

# Convert the 'day_of_week' column to a factor variable with a specified level order
trip_data_v2$day_of_week <- ordered(trip_data_v2$day_of_week, 
                                    levels = c("Monday", 
                                               "Tuesday", 
                                               "Wednesday", 
                                               "Thursday", 
                                               "Friday", 
                                               "Saturday", 
                                               "Sunday"))

# Order the levels of the month from January to December
trip_data_v2$month <- ordered(trip_data_v2$month, 
                              levels = c("January", 
                                         "February", 
                                         "March", 
                                         "April", 
                                         "May", 
                                         "June", 
                                         "July", 
                                         "August", 
                                         "September", 
                                         "October", 
                                         "November", 
                                         "December"))


## -------------------------- ##
##   MAKE DESCRIPTIVE STATS   ##
## -------------------------- ##

summary

# Calculate descriptive statistics for the 'ride_length' column
trip_data_v2 %>%
    summarise(mean = mean(ride_length), 
              median = median(ride_length), 
              min = min(ride_length), 
              max = max(ride_length), 
              sd = sd(ride_length), 
              count = n())


## ------------------------- ##
##   ANALYZE RIDE DURATION   ##
## ------------------------- ##




## ----------------------- ##
##   ANALYZE RIDE NUMBER   ##
## ----------------------- ##


