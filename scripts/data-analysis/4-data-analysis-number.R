## ----------------------------------------------------- ##
#####   PLOT BAR CHART OF RIDE NUMBERS BY USER TYPE   #####
## ----------------------------------------------------- ##

# Create a bar chart
plot_03 <- ggplot(stats_user, aes(x = member_casual, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", color = "black") +
  scale_y_continuous(limits = c(0, 4000000), labels = unit_format(unit = "M", scale = 1e-6), expand = c(0, 0)) +
  scale_x_discrete(labels = c("Casual", "Member")) +
  theme(legend.position = "none") +
  labs(
    x = "User type",
    y = "Number of rides",
    title = "Total number of rides, by user type"
  )

# Add annotation for plot_03
plot_03 +
  # Text label for bar chart
  geom_text(aes(label = prettyNum(ride_count, big.mark = ",")), position = position_dodge(width = 0.90), vjust = 2) +
  # Annotation for value difference
  annotate(
    "segment",
    x = 1,
    xend = 1,
    y = (3271770 / 1.03),
    yend = (2269498 * 1.03),
    arrow = arrow(ends = "both", angle = 90, length = unit(0.25, "cm")),
    color = "red"
  ) +
  annotate("text", label = "± 1,002,272", x = 1, y = 2770634, hjust = -0.20, color = "red")


## ------------------------------------------------------------- ##
#####   PLOT BAR CHART OF RIDE NUMBERS BY USER TYPE AND DAY   #####
## ------------------------------------------------------------- ##

# Create a bar chart
plot_05 <- ggplot(stats_user_day, aes(x = day_of_week, y = ride_count, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_y_continuous(limits = c(0, 600000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) + 
  scale_fill_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Day of week",
    y = "Number of rides",
    title = "Total number of rides, by user type and day of week"
  )

# Add annotation for plot_05
plot_05 +
  # Text label for bar chart
  geom_text(aes(label = prettyNum(ride_count, big.mark = ",")), position = position_dodge(width = 0.90), hjust = -0.10, angle = 270)


## -------------------------------------------------------------- ##
#####   PLOT BAR CHART OF RIDE NUMBERS BY USER TYPE AND HOUR   #####
## -------------------------------------------------------------- ##

# Create a line chart
plot_07 <- ggplot(stats_user_hour, aes(x = hour, y = ride_count, group = member_casual)) +
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

# Add annotation for plot_07
plot_07 +
  # Annotation for casual's peak
  annotate("segment", x = 17, xend = 17, y = 50000, yend = 190000, arrow = arrow(type = "closed", length = unit(0.20, "cm")), color = "darkgray") +
  annotate(
    "text", x = 17, y = 30000, size = 2.50, color = "#343434",
    label = "Number of casual riders slowly increases \nthroughout the day, peaking at 5 PM"
  ) +
  # Annotation for member's peak
  annotate("segment", x = 12.50, xend = 8.25,  y = 360000, yend = 210000, arrow = arrow(type = "closed", length = unit(0.20, "cm")), color = "darkgray") +
  annotate("segment", x = 12.50, xend = 12,    y = 360000, yend = 195000, arrow = arrow(type = "closed", length = unit(0.20, "cm")), color = "darkgray") +
  annotate("segment", x = 12.50, xend = 16.50, y = 360000, yend = 345000, arrow = arrow(type = "closed", length = unit(0.20, "cm")), color = "darkgray") +
  annotate(
    "text", x = 12.50, y = 380000, size = 2.50, color = "#343434",
    label = "Annual members tend to use Cyclistic bikes at 8 AM, 12 PM and 5 PM"
  )


## ---------------------------------------------------------------- ##
#####   PLOT LINE CHART OF RIDE NUMBERS BY USER TYPE AND MONTH   #####
## ---------------------------------------------------------------- ##

# Create line chart
plot_09 <- ggplot(stats_user_month, aes(x = month, y = ride_count, group = member_casual)) +
  geom_line(aes(color = member_casual), size = 1) +
  geom_point(aes(color = member_casual), size = 1) +
  scale_y_continuous(limits = c(0, 500000), labels = unit_format(unit = "k", scale = 1e-3), expand = c(0, 0)) +
  scale_color_discrete(labels = c("Casual", "Member")) +
  labs(
    x = "Month",
    y = "Number of rides",
    title = "Total number of rides, by user type and month"
  )

# Add annotation for plot_09
plot_09 +
  # Annotation for casual's trend
  annotate("segment", x = 7, xend = 7, y = 325000, yend = 370000, arrow = arrow(type = "closed", length = unit(0.02, "npc")), color = "darkgray") +
  annotate("text", x = 7, y = 300000, size = 2.50, color = "gray40", label = "Casual riders' bike usage \n peaks in July") +
  # Annotation for member's trend
  annotate("segment", x = 8, xend = 8, y = 475000, yend = 430000, arrow = arrow(type = "closed", length = unit(0.02, "npc")), color = "darkgray") +
  annotate("text", x = 8, y = 500000, size = 2.50, color = "gray40", label = "Annual members' bike usage \n peaks in August") +
  # Annotation for upward trend
  annotate("segment", x = 3, xend = 8, y = 60000, yend = 60000, arrow = arrow(ends = "both", angle = 90, length = unit(0.15,"cm")), color = "darkgray") +
  annotate( # \n Then, a number of users declined afterwards.
    "text", x = 5.50, y = 25000, size = 2.50, color = "gray40",
    label = "Casuals and members grew 51% and 18% per month \n respectively, from March to July and August."
  )
