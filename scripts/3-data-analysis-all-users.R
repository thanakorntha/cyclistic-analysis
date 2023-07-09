## ------------------- ##
#####   ALL USERS   #####
## ------------------- ##

###### Ride Length Statistics ######

# Create descriptive statistics of the 'ride_length' column (also use summary(trip_data_v2$ride_length))
trip_data_v2 %>% 
  summarize(
    min = min(ride_length), 
    q1 = quantile(ride_length, 0.25), 
    mean = mean(ride_length), 
    median = median(ride_length), 
    q3 = quantile(ride_length, 0.75), 
    max = max(ride_length), 
    sd = sd(ride_length), 
    count = n()
  )

###### Distribution Chart - Overall ######

# Define labels for the plot
label_1 <- labs(
  x = "Duration of ride (in minutes)", 
  y = "Number of rides", 
  title = "The majority of riders spent less time on their bikes than the average", 
  subtitle = "Distribution of ride duration for all users, 2022", 
  caption = "Source: Cyclistic (Divvy) dataset with 5,541,268 ride records"
)

# Define a text annotation for average line
annotation_1 <- annotate(
  geom = "text", 
  label = "AVG = 16.61 min.", 
  x = mean(trip_data_v2$ride_length), 
  y = Inf, 
  vjust = -0.75, 
  hjust = -0.1, 
  angle = "270", 
  size = 2, 
  color = "#c76a27"
)

# Create a histogram of ride length
ggplot(trip_data_v2, aes(x = ride_length)) + 
  geom_histogram(color = "black", fill = "#2C7EB8") +
  # Add a vertical line at the average ride length
  geom_vline(
    aes(xintercept = mean(ride_length)), 
    linetype = "dashed", 
    size = 0.5, 
    color = "#c76a27"
  ) + 
  # Add a text annotation to label the average ride length
  annotation_1 + 
  # Format the x-axis and the y-axis 
  xlim(0, 60) + 
  expand_limits(y = c(0, 800000)) + 
  scale_y_continuous(labels = unit_format(unit = "k", scale = 1e-3)) + 
  # Add a title, legend and color theme
  label_1 + 
  plot_theme + theme(legend.position = "none") + 
  scale_fill_brewer(palette = "YlGnBu")
