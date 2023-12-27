# Cyclistic Bike-Sharing Data Analysis

This project is a capstone part of the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics) on Coursera. 

The purpoes of this project is to analyze Cyclistic's historical bike trip data in 2022 in order to identify how annual members and casual riders use Cyclistic bikes differently. It also aims to extract insights and develop the most appropriate marketing strategy that appeal to casual riders and encourage them to subscribe to annual memberships. 

This project follows the six steps of the data analysis process, as follows: 

1. **ASK PHASE:** Focus on the question: How do annual members and casual riders use Cyclistic bikes differently?
2. **PREPARE PHASE:** Download the trip data and check its itegrity
3. **PROCESS PHASE:** Clean the trip data in order to be ready for the data analysis
4. **ANALYZE PHASE:** Analyze the trip data using RStudio
5. **SHARE PHASE:** Visualize the trip data and share the insights to the stakeholders using Tableau or Google Slides
6. **ACT PHASE:** Make the top three recommendtions based on the analysis



## Documents

- [Cyclistic Bike-Sharing Data Analysis:](https://github.com/thanakorntha/cyclistic-analysis/blob/main/docs/index.Rmd) The complete R Markdown that explains the whole process throughout this project.
- [Cyclistic Bike-Sharing Presentation:](https://docs.google.com/presentation/d/10rjNoz974A2b5eaHbziuGUkXN23U-6WRiy8WsUE7ves/edit?usp=sharing) The slide deck that reports the whole anlysis to stakeholders.
- [Data Processing:](https://github.com/thanakorntha/cyclistic-analysis/blob/main/code/data-processing.R) The R code that provides the process of how I clean the data.
- [Data Analysis and Visualization:](https://github.com/thanakorntha/cyclistic-analysis/blob/main/code/data-analysis.R) The R code that provides the analysis and visualization of the data.



## Requirements

### Dataset

This project analyzes Cyclistic's historical bike trip data from January to December 2022 from the [Divvy system data website](https://divvy-tripdata.s3.amazonaws.com/index.html).

Run the following scripts to download the trip data in 2022:

``` shell
# Change to the 'code' directory
cd ./code/

# Run retrieve_data.sh
./retrieve_data.sh
```

### IDE

[RStudio](https://posit.co) (the latest version) to gather all the information, process it, explore the data, and use it to find bike usage's patterns and insights.

### Libraries

Here are the R packages I used for the project:

- [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
- [forcats](https://cran.r-project.org/web/packages/lubridate/index.html)
- [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
- [knitr](https://cran.r-project.org/web/packages/knitr/index.html)
- [lubridate](https://cran.r-project.org/web/packages/lubridate/index.html)
- [purrr](https://cran.r-project.org/web/packages/forcats/index.html)
- [readr](https://cran.r-project.org/web/packages/readr/index.html)
- [scales](https://cran.r-project.org/web/packages/scales/index.html)
- [skimr](https://cran.r-project.org/web/packages/skimr/index.html)
- [stringr](https://cran.r-project.org/web/packages/stringr/index.html)
- [tibble](https://cran.r-project.org/web/packages/tibble/index.html)
- [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)
- [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html)



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)