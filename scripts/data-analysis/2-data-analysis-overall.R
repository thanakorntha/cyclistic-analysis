## ------------------------ ##
#####   STATS SUMMARY   ######
## ------------------------ ##

# Create descriptive statistics by the 'ride_length' column
trip_data_v2 %>% 
  summarize(
    Mean = mean(ride_length),
    Min = min(ride_length),
    Mode = find_mode(ride_length),
    Median = median(ride_length),
    Max = max(ride_length),
    SD = sd(ride_length),
    Size = n(),
    Popular_Day = find_mode(day_of_week)
  )


## ------------------------------------------------------- ##
#####   PLOT TIME DURATION DISTRIBUTION OF ALL RIDES   ######
## ------------------------------------------------------- ##

# Create a histogram
plot_01 <- ggplot(trip_data_v2, aes(x = ride_length)) +
  geom_histogram(color = "black", fill = "darkgray") +
  scale_x_continuous(limits = c(0, 40)) +
  scale_y_continuous(limits = c(0, 600000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  theme(axis.line.x = element_line(arrow = grid::arrow(length = unit(0.10, "cm"), type = "closed"))) +
  labs(
    x = "Time duration (min.)",
    y = "Number of rides",
    title = "Distribution of rides at a time duration"
  )

# Add annotation for plot_01
plot_01 +
  # Median
  geom_vline(xintercept = median(trip_data_v2$ride_length), linetype = "dashed", size = 0.50, color = "red") +
  annotate(
    "text", label = "Median:\n10.20",
    x = median(trip_data_v2$ride_length), y = 600000,
    vjust = 1.25, hjust = -0.25,
    size = 2.50, color = "red"
  ) +
  # Mean
  geom_vline(xintercept = mean(trip_data_v2$ride_length), linetype = "dashed", size = 0.50, color = "blue") +
  annotate(
    "text", label = "Mean:\n15.50",
    x = mean(trip_data_v2$ride_length), y = 600000,
    vjust = 1.25, hjust = -0.25,
    size = 2.50, color = "blue"
  ) +
  # Mode
  geom_vline(xintercept = find_mode(trip_data_v2$ride_length), linetype = "dashed", size = 0.50, color = "darkgreen") +
  annotate(
    "text", label = "Mode:\n5.38",
    x = find_mode(trip_data_v2$ride_length), y = 600000,
    vjust = 1.25, hjust = -0.25,
    size = 2.50, color = "darkgreen"
  ) +
  # Standard Deviation
  geom_vline(xintercept = sd(trip_data_v2$ride_length), linetype = "dashed", size = 0.50, color = "purple") +
  annotate(
    "text", label = "SD:\n25.10",
    x = sd(trip_data_v2$ride_length), y = 600000,
    vjust = 1.25, hjust = -0.25,
    size = 2.50, color = "purple"
  )


## -------------------- ##
#####   RIDE TYPE   ######
## -------------------- ##

trip_data_v2 %>%
  group_by(rideable_type) %>%
  summarise(count = n())
