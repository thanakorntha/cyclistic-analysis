## ----------------------------- ##
#####   SET UP ENVIRONMENT   ######
## ----------------------------- ##

# Convert the 'day_of_week' column to a factor variable with a specified level order
trip_data_v2$day_of_week <- ordered(
  trip_data_v2$day_of_week, 
  levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
)

# Order the levels of the month from January to December
trip_data_v2$month <- ordered(
  trip_data_v2$month, 
  levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
)

# Set default theme
theme_set(theme_bw())

# Set default plot theme
plot_theme <- theme(
  axis.title.x = element_text(size = 8), 
  axis.title.y = element_text(size = 8), 
  axis.text.x = element_text(size = 6), 
  axis.text.y = element_text(size = 6), 
  plot.title = element_text(size = 9, face = "bold"), 
  plot.subtitle = element_text(size = 8), 
  plot.caption = element_text(size = 6, face = "italic", hjust = 0), 
  panel.grid.major = element_blank(), 
  panel.grid.minor = element_blank()
)

# Set default legend theme
legend_theme <- theme(
  legend.title = element_text(size = 8), 
  legend.text = element_text(size = 7)
)

# Define function to calculate mode
find_mode <- function(x) {
  u <- unique(x)
  tab <- tabulate(match(x, u))
  u[tab == max(tab)]
}
