#'
#' @title Create_date
#' @description This function takes three integers as year, month, day in inputs and creates date by blending together in date format "year-month-day" if the given year, month, day are correct.
#' @param YEAR Integer and represents the corresponding year.
#' @param MONTH Integer between 1 and 12. MONTH stands for the month in date.
#' @param DAY Integer between 1 and 31. DAY stands for the number of day and must be respect some contrainsts according to the month.
#' @return Date object
#' @export
#'
#' @examples{
#' year  <-  c("1984", "2004", "2000")
#' month <-  c("11", "06", NA)
#' day   <- c("15", "05", NA)
#' my_date <- Create_date(year, month, day)
#' }
Create_date <- function(YEAR, MONTH, DAY){
  MONTH <- base::ifelse(base::is.na(MONTH), 1,MONTH)
  DAY   <- base::ifelse(base::is.na(DAY), 1, DAY)
  dateUni       <- paste(YEAR, MONTH, DAY, sep = "/")
  dateUni       <-  base::as.Date(dateUni, format = "%Y/%m/%d",tryFormats = c("%Y-%m-%d", "%Y/%m/%d"),
                            origin = "1970-01-01")
  DATE  <- dateUni
  return(DATE)
}
#' @title remove_Country_name
#' @description remove_Country_name extracts the city name from a text
#' @param string character with this format "something: name of city"
#'
#' @importFrom stringr str_remove str_trim str_to_title
#'
#' @return character
#' @export
#'
#' @examples{
#' textcity <- c("Mali:bamako", "Cote ivoire : man")
#' citytext <- remove_Country_name(textcity)
#' }
remove_Country_name <- function(string){
  texte <- stringr::str_remove(string, ".*:")
  texte <- stringr::str_trim(texte)
  texte <- stringr::str_to_title(texte)
  return(texte)
}

#' @title eq_clean_data
#' @description eq_clean_data makes earthquake data in the required format. In which each column has its data in the correct format.
#' @param datalist stands for data.frame whichcontains earthquake information.
#' @param YEAR Interger
#' @param MONTH INteger between 1 to 12
#' @param DAY Integer  between 1 to 31
#' @param LATITUDE Double
#' @param LONGITUDE Double
#' @seealso Create_date
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#'
#' @return data.frame object
#' @export
#'
#' @examples{
#' my_data <- data.frame(
#' YEAR = c("1984", "2000", "2014"),
#' MONTH = c("1", "2", "12"),
#' DAY = c("19", "20", "24"),
#' LONGITUDE = c("12.344", "14.89", "13.345"),
#' LATITUDE = c("-8.00", "-8.89", "-9.345")
#' )
#' my_data_clean <- eq_clean_data(my_data)
#' }
eq_clean_data <- function(datalist, YEAR = "YEAR" , MONTH = "MONTH",
                          DAY = "DAY", LATITUDE = "LATITUDE",
                          LONGITUDE = "LONGITUDE"){
  #
  data_clean <-  datalist  %>%
    dplyr::mutate(DATE = Create_date(YEAR, MONTH, DAY)) %>%
                        dplyr::mutate(LATITUDE = base::as.numeric(LATITUDE),
                              LONGITUDE = base::as.numeric(LONGITUDE)
                              )
  return(data_clean)
  #
}
#
#' @title eq_location_clean
#' @description create CLEAN_LOCATION_NAME by Removing the country names from LOCATION_NAME
#'
#' @param datalist data.frame
#' @param LOCATION_NAME column of datalist which contains the complete location name of each earthquake.
#' @seealso remove_Country_name
#' @import magrittr
#'
#' @return data.frame
#' @export
#'
#' @examples{
#' datalist <- data.frame (LOCATION_NAME = c("Mali : bamako",
#'                                           "Guinee : kankan",
#'                                           "Mali : sikasso wassoulou" ))
#' datalist <- eq_location_clean(datalist)
#' }
eq_location_clean <- function(datalist, LOCATION_NAME = "LOCATION_NAME"){

  datalist <- datalist %>%
    dplyr::mutate(CLEAN_LOCATION_NAME = remove_Country_name(LOCATION_NAME))

  return(datalist)
}
