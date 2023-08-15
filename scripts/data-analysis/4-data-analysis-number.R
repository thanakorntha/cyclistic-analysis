## ----------------------------------------------------- ##
#####   PLOT BAR CHART OF RIDE NUMBERS BY USER TYPE   #####
## ----------------------------------------------------- ##

# Create a bar chart
plot_ride_01 <- ggplot(stats_user, aes(x = member_casual, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", color = "black") +
  scale_y_continuous(limits = c(0, 4000000), labels = unit_format(unit = "M", scale = 1e-6), expand = c(0, 0)) +
  scale_x_discrete(labels = c("Casual", "Member")) +
  theme(legend.position = "none") +
  labs(
    x = "User type",
    y = "Number of rides",
    title = "Total number of rides, by user type"
  )

# Add annotation for plot_ride_01
plot_ride_01 +
  # Text label for bar chart
  geom_text(aes(label = prettyNum(ride_count, big.mark = ",")), position = position_dodge(width = 0.90), vjust = 2) +
  # Annotation for value difference
  annotate(
    "segment",
    x = 1,
    xend = 1,
    y = (3271770 / 1.03),
    yend = (2095577 * 1.03),
    arrow = arrow(ends = "both", angle = 90, length = unit(0.25, "cm")),
    color = "red"
  ) +
  annotate("text", label = "± 1,176,193", x = 1, y = 2683673.50, hjust = -0.20, color = "red")


## ------------------------------------------------------------- ##
#####   PLOT BAR CHART OF RIDE NUMBERS BY USER TYPE AND DAY   #####
## ------------------------------------------------------------- ##

# Create a bar chart
plot_ride_02 <- ggplot(stats_user_day, aes(x = day_of_week, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_continuous(limits = c(0, 600000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) + 
  scale_fill_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Day of week",
    y = "Number of rides",
    title = "Total number of rides, by user type and day of week"
  )

# Add annotation for plot_ride_02
plot_ride_02 +
  # Text label for bar chart
  geom_text(aes(label = prettyNum(ride_count, big.mark = ",")), position = position_dodge(width = 0.90), hjust = -0.10, angle = 270)


## -------------------------------------------------------------- ##
#####   PLOT BAR CHART OF RIDE NUMBERS BY USER TYPE AND HOUR   #####
## -------------------------------------------------------------- ##

# Create a line chart
plot_ride_03 <- ggplot(stats_user_hour, aes(x = hour, y = ride_count, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_x_continuous(limits = c(0, 23), breaks = seq(from = 0, to = 23, by = 1)) +
  scale_y_continuous(limits = c(0, 400000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Hour",
    y = "Number of rides",
    title = "Total number of rides, by user type and hour"
  )

# Add annotation for plot_ride_03
plot_ride_03 +
  # Hightlight
  annotate("rect", xmin = 8, xmax = 17, ymin = 0, ymax = 400000, alpha = 0.10, fill = "darkorange") +
  geom_vline(xintercept = c(8, 12, 17), linetype = "dashed", size = 0.50, color = "darkorange")


## ---------------------------------------------------------------- ##
#####   PLOT LINE CHART OF RIDE NUMBERS BY USER TYPE AND MONTH   #####
## ---------------------------------------------------------------- ##

# Create line chart
plot_ride_04 <- ggplot(stats_user_month, aes(x = month, y = ride_count, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_y_continuous(limits = c(0, 500000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Month",
    y = "Number of rides",
    title = "Total number of rides, by user type and month"
  )

# Add annotation for plot_ride_04
plot_ride_04 +
  # Highlight
  annotate("rect", xmin = 7, xmax = 8, ymin = 0, ymax = 500000, alpha = 0.10, fill = "darkorange") +
  geom_vline(xintercept = c(7, 8), linetype = "dashed", size = 0.50, color = "darkorange")
