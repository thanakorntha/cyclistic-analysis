## ------------------------------------------------------ ##
#####   PLOT BAR CHART OF TIME DURATION BY USER TYPE   #####
## ------------------------------------------------------ ##

# Create a bar chart
plot_time_01 <- ggplot(stats_user, aes(x = member_casual, y = median_ride_length, fill = member_casual)) +
  geom_bar(stat = "identity", color = "black") +
  scale_y_continuous(limits = c(0, 15), expand = c(0, 0)) +
  scale_x_discrete(labels = c("Casual", "Member")) +
  theme(legend.position = "none") +
  labs(
    x = "User type",
    y = "Time duration (min.)",
    title = "Median time duration on bikes, by user type"
  )

# Add annotation for plot_time_01
plot_time_01 +
  # Text label for bar chart
  geom_text(aes(label = round(median_ride_length, 2)), position = position_dodge(width = 0.90), vjust = 2) +
  # Annotation for value difference
  annotate(
    "segment",
    x = 2,
    xend = 2,
    y = (12.55 / 1.03),
    yend = (9.03 * 1.03),
    arrow = arrow(ends = "both", angle = 90, length = unit(0.25, "cm")),
    color = "red"
  ) +
  annotate("text", label = "± 3.52 min.", x = 2, y = 10.79, hjust = -0.20, color = "red")


## -------------------------------------------------------------- ##
#####   PLOT BAR CHART OF TIME DURATION BY USER TYPE AND DAY   #####
## -------------------------------------------------------------- ##

# Create a bar chart
plot_time_02 <- ggplot(stats_user_day, aes(x = day_of_week, y = median_ride_length, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_continuous(limits = c(0, 20), expand = c(0, 0)) +
  scale_fill_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Day of week",
    y = "Time duration (min.)",
    title = "Median time duration on bikes, by user type and \nday of week"
  )

# Add annotation for plot_time_02
plot_time_02 +
  # Text label for bar chart
  geom_text(aes(label = round(median_ride_length, 2)), position = position_dodge(width = 0.90), hjust = -0.10, angle = 270) +
  # Median line
  geom_hline(yintercept = median(trip_data_v2$ride_length), color = "darkgray", linetype = "dashed", size = 0.50) +
  annotate(
    "text",
    label = "Median:\n10.52",
    x = 7,
    y = median(trip_data_v2$ride_length),
    vjust = -0.50,
    hjust = -0.25,
    size = 2.50,
    color = "darkgray"
  )


## ---------------------------------------------------------------- ##
#####   PLOT LINE CHART OF TIME DURATION BY USER TYPE AND HOUR   #####
## ---------------------------------------------------------------- ##

# Create a line chart
plot_time_03 <- ggplot(stats_user_hour, aes(x = hour, y = median_ride_length, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_x_continuous(limits = c(0, 23), breaks = seq(0, 23, 1)) +
  scale_y_continuous(limits = c(0, 20), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Hour",
    y = "Time duration (min.)",
    title = "Median time duration on bikes, by user type and hour"
  )

# Add annotation for plot_time_03
plot_time_03 +
  # Median line
  geom_hline(yintercept = median(trip_data_v2$ride_length), color = "darkgray", linetype = "dashed", size = 0.50) +
  annotate(
    "text",
    label = "Median: 10.52",
    x = 23,
    y = median(trip_data_v2$ride_length),
    vjust = -0.75,
    hjust = 0.70,
    size = 2.50,
    color = "darkgray"
  )


## ----------------------------------------------------------------- ##
#####   PLOT LINE CHART OF TIME DURATION BY USER TYPE AND MONTH   #####
## ----------------------------------------------------------------- ##

# Create a line chart
plot_time_04 <- ggplot(stats_user_month, aes(x = month, y = median_ride_length, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_y_continuous(limits = c(0, 20), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Month",
    y = "Time duration (min.)",
    title = "Median time duration on bikes, by user type and month"
  )

# Add annotation for plot_time_04
plot_time_04 +
  # Median line
  geom_hline(yintercept = median(trip_data_v2$ride_length), color = "darkgray", linetype = "dashed", size = 0.50) +
  annotate(
    "text",
    label = "Median: 10.52",
    x = 12,
    y = median(trip_data_v2$ride_length),
    vjust = -0.75,
    hjust = 0.70,
    size = 2.50,
    color = "darkgray"
  )
