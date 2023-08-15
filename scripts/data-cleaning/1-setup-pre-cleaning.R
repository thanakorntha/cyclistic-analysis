## ----------------------- ##
#####   LOAD PACKAGES   #####
## ----------------------- ##

# Install the required packages
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("scales")

# Load the required packages
library(tidyverse)
library(skimr)
library(janitor)
library(scales)


## --------------------------- ##
#####   SET GGPLOT2 THEME   #####
## --------------------------- ##

# Creating a ggplot2 theme
theme_nun <- function(base_size = 14) {
  theme_bw(base_size = base_size) %+replace%
    theme(
      # Figure
      plot.title = element_text(size = rel(1), face = "bold", margin = margin(0, 0, 10, 0), color = "#343434", hjust = 0),
      plot.subtitle = element_text(size = rel(0.80), margin = margin(0, 0, 10, 0), color = "#343434",  hjust = 0),
      plot.caption = element_text(size = rel(0.70), face = "italic", margin = margin(5, 0, 5, 0), color = "#343434",  hjust = 0),
      # Graph area
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.border = element_blank(),
      # Axis
      axis.title = element_text(size = rel(0.60), face = "bold", color = "#343434", hjust = 1),
      axis.text = element_text(size = rel(0.55), color = "#343434"),
      axis.line.x = element_line(color = "#343434"),
      axis.ticks.x = element_line(color = "#343434"),
      axis.line.y = element_blank(),
      axis.ticks.y = element_blank(),
      # Legend
      legend.title = element_blank(),
      legend.text = element_text(size = rel(0.60)),
      legend.position = "top",
      legend.key = element_rect(fill = "transparent", colour = NA),
      legend.key.size = unit(1, "lines"),
      legend.background = element_rect(fill = "transparent", colour = NA),
      legend.margin = margin(0, 0, 0, 0),
      # The labels (faceting)
      strip.background = element_rect(fill = "#343434", color = "#343434"),
      strip.text = element_text(size = rel(0.80), face = "bold", color = "white", margin = margin(5, 0, 5, 0))
    )
}

# Changing the default theme
theme_set(theme_nun())
