# capstonIBS

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/BouranDS/My_Capstone.svg?branch=master)](https://travis-ci.com/BouranDS/My_Capstone)
[![Travis build status](https://travis-ci.org/BouranDS/My_Capstone.svg?branch=master)](https://travis-ci.org/BouranDS/My_Capstone)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/BouranDS/My_Capstone?branch=master&svg=true)](https://ci.appveyor.com/project/BouranDS/My_Capstone)
<!-- badges: end -->

The goal of capstonIBS is to propose a handy set of functions to deal with the analysis of the NOAA data frame.
This package contains several functions such as:
# Data analysis functions
## Create_date
This function takes as input three integer which stand respectively for year, month and day and make date according to dDate object format. In addition missing month and day are replaced by 01. 
## remove_Country_name
This is a simple function used on character to extract the word after  ":". In fact the character "Mali: bamako" becomes "Bamako"
## eq_clean_data
This function is used for cleaning the eartquake data set from NOA web site.
## eq_location_clean
This function apply remove_Country_name on a dataset.
# mapping functions
## eq_map
This function allows to annote leaflet object from data.frame whose annoted information is in one of columns. 
## eq_create_label
This function label for leaflet popup. The labels created by eq_create_label respect htlm5 constraints.
# Geom 
## geom_timeline
geom_timeline is Geom to annote on leaflet with its spacial coordonates. 
## geom_timeline_label
geom_timeline_label is geom and allows to addadditional information after geom_timeline.
## Installation

You can install the released version of capstonIBS from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("capstonIBS")
```

## Example

This is a basic example which shows you how to solve a common problem:
# Function Create_date

``` r
library(capstonIBS)
## basic example code
date_format <- Create_date(1984, 12, 11)
date_format <- Create_date(1984, NA, NA)
```

# Function eq_clean_data
``` r
my_data <- data.frame(
  YEAR = c("1984", "2000", "2014"),
  MONTH = c("1", "2", "12"),
  DAY = c("19", "20", "24"),
  LONGITUDE = c("12.344", "14.89", "13.345"),
  LATITUDE = c("-8.00", "-8.89", "-9.345")
)
data_cleanning <- eq_clean_data(my_data)

```
# Function eq_location_clean 
``` r
my_data <- data.frame (LOCATION_NAME = c("Mali : bamako",
                                          "Guinee : kankan",
                                          "Mali : sikasso wassoulou" ))
my_data <- eq_location_clean(my_data)
```
# Function remove_Country_name 
``` r
remove_Country_name(c("Mali:bamako", "Cote ivoire : man"))
```      
# Function eq_create_label
``` r
 my_data <- data.frame(
                DEATHS = c(125, 12),
                EQ_PRIMARY  = c(7.981792, 8.019300),
                CLEAN_LOCATION_NAME = c("Bamako Coura", "Badialan")
 )
 my_data <- eq_create_label(my_data)
```
# Function eq_map
``` r
mydata <- data.frame(
 LONGITUDE = c(12.585080, 12.651165),
 LATITUDE = c(-7.981792, -8.019300),
 Annotation = c("Bamako Coura", "Badialan")
 )
eq_map(mydata, "Annotation")
```
