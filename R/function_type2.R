#
#' eq_map allows to annotate on a map or leaflet object position and gives information through a htlm popup
#'
#' @param my_data stands for data.frame or list which contains at least two columns denoted by LONGITUDE and LATITUDE
#' @param annot_col defines the column which will appear on the map in popup
#' @importFrom leaflet leaflet addTiles addCircleMarkers
#'
#' @return a leaflet or htmlwidget object which is an interactive map if \code{annot_col} is a column name of
#' \code{my_data}
#' @export
#'
#' @examples{
#' mydata <- data.frame(
#' LONGITUDE = c(12.585080, 12.651165),
#' LATITUDE = c(-7.981792, -8.019300),
#' Annotation = c("Bamako Coura", "Badialan")
#' )
#' mymap <- eq_map(mydata, "Annotation")
#' mymap
#' }
eq_map <- function(my_data, annot_col){
  if(annot_col %in% colnames(my_data)){
    annoted_map <- my_data %>%
      leaflet::leaflet() %>%
      leaflet::addTiles() %>%
      leaflet::addCircleMarkers(lng     = my_data$LONGITUDE,
                                lat     = my_data$LATITUDE,
                                popup   = my_data[[annot_col]],
                                color   = "blue",
                                weight  = 2,
                                opacity = 0.3)
    return(annoted_map)
  }else{
    stop(paste(annot_col, " is not a column name in database !!!"))
    #
  }
}
##
#' @title eq_create_label
#' @description Create formated html label for annoting map from leaflet object
#' Annotation focuses and combines information on location, magnitude accordin richter scale
#' and the nomber of deaths recorded during the earthquake.
#' @param my_data stands for data.frame in which the columns contains information in order to annatate a map.
#' this my_data must have CLEAN_LOCATION_NAME, EQ_PRIMARY, DEATHS as columns names.
#' @return vector of character
#' @export
#'
#' @examples{
#' my_data <- data.frame(
#' DEATHS = c(125, 12),
#' EQ_PRIMARY  = c(7.981792, 8.019300),
#' CLEAN_LOCATION_NAME = c("Bamako Coura", "Badialan")
#' )
#'
#' eq_create_label(my_data)
#' }
eq_create_label <- function(my_data){
  info <- c("CLEAN_LOCATION_NAME", "EQ_PRIMARY", "DEATHS")
  info_name <- c("Location", "Magnitude", "Deaths")
  coldesignation <- colnames(my_data)
  test_valide <- all(
    match(info, coldesignation, nomatch = FALSE)
          )
  if(test_valide){
    Ntext <- nrow(my_data)
    vector_txt <- character(length = 0L)
    for(i in 1:Ntext){
      my_text <- character(0L)
      for (jkl in info) {
        my_text <- paste(my_text,
                         paste0("<b>", info_name[which(info == jkl)],": </b>" , my_data[, jkl][i]),
                         sep = "</br>"
        )
        vector_txt[i] <- my_text
      }
    }
    return(vector_txt)
  }else{
    return(NULL)
  }
}
