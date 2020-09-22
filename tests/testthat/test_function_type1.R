testthat::context(desc = "My Capstone automatic test")

testthat::test_that(desc = "Create date Test",
                    code = {
                      testthat::expect_equal(Create_date(1984, 12, 11), as.Date("1984-12-11"))
                      testthat::expect_equal(Create_date(1984, NA, NA), as.Date("1984-01-01"))

                    }

)
#
my_data <- data.frame(
  YEAR = c("1984", "2000", "2014"),
  MONTH = c("1", "2", "12"),
  DAY = c("19", "20", "24"),
  LONGITUDE = c("12.344", "14.89", "13.345"),
  LATITUDE = c("-8.00", "-8.89", "-9.345")
)
testthat::test_that(desc = "Clean Data eq_clean_data",
                    code = {
                      testthat::expect_equal(class(eq_clean_data(my_data)), "data.frame")
                      testthat::expect_equal(class((eq_clean_data(my_data))[,4]), "numeric")
                      testthat::expect_equal(class((eq_clean_data(my_data))[,5]), "numeric")
                      testthat::expect_equal(class((eq_clean_data(my_data))[,6]), "Date")

                    }

)
my_data <- data.frame (LOCATION_NAME = c("Mali : bamako",
                                          "Guinee : kankan",
                                          "Mali : sikasso wassoulou" ))
testthat::test_that(desc = "Clean City name eq_location_clean",
                    code = {
                      testthat::expect_equal(eq_location_clean(my_data)[, "CLEAN_LOCATION_NAME"], c("Bamako", "Kankan", "Sikasso Wassoulou"))
                    }
)
#
testthat::test_that(desc = "Remove country name remove_Country_name",
                    code = {
                      testthat::expect_equal(remove_Country_name(c("Mali:bamako", "Cote ivoire : man")),
                                             c("Bamako", "Man"))
                    }
)
#
 my_data <- data.frame(
 DEATHS = c(125, 12),
 EQ_PRIMARY  = c(7.981792, 8.019300),
 CLEAN_LOCATION_NAME = c("Bamako Coura", "Badialan")
 )
 testthat::test_that(desc = "Remove country name remove_Country_name",
                     code = {
                       testthat::expect_equal(eq_create_label(my_data),
                                              c("</br><b>Location: </b>Bamako Coura</br><b>Magnitude: </b>7.981792</br><b>Deaths: </b>125",
                                                "</br><b>Location: </b>Badialan</br><b>Magnitude: </b>8.0193</br><b>Deaths: </b>12"))
                     }
 )
#
mydata <- data.frame(
 LONGITUDE = c(12.585080, 12.651165),
 LATITUDE = c(-7.981792, -8.019300),
 Annotation = c("Bamako Coura", "Badialan")
 )
testthat::test_that(desc = "Drawing map with annotation eq_map",
                    code = {
                      testthat::expect_equal(class(eq_map(mydata, "Annotation")),
                                             c("leaflet", "htmlwidget"))}
)
