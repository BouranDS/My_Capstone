# capstonIBS

<!-- badges: start -->
<!-- badges: end -->

The goal of capstonIBS is to propose a handy set of functions to deal with the analysis of the NOAA data frame.
This package contains several functions such as:
# Data analysis functions
## Create_date
## remove_Country_name
## eq_clean_data
## eq_location_clean
# mapping functions
## eq_map
## eq_create_label
# Geom 
## geom_timeline
## geom_timeline_label
## Installation

You can install the released version of capstonIBS from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("capstonIBS")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(capstonIBS)
## basic example code
date_format <- Create_date(1984, 12, 11)
```
