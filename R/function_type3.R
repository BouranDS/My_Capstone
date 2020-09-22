#
#' @title Defines Our GeomTimeline class
#'
#' @description The ggproto() function is used to construct a new class corresponding to your new geom.
#' @import ggplot2 grid
#' @importFrom ggplot2 ggproto aes
#' @importFrom grid segmentsGrob gList pointsGrob gpar unit
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ggplot(dataCapstone_clean, aes(x = date, y = COUNTRY,
#'                color = as.numeric(TOTAL_DEATHS),
#'                size = as.numeric(EQ_PRIMARY),
#'                label = CLEAN_LOCATION_NAME)) +
#'   geom_timeline() +
#'   ggplot2::theme(panel.background = ggplot2::element_blank(),
#'         legend.position = "bottom",
#'         axis.title.y = ggplot2::element_blank()) + ggplot2::xlab("DATE")
#'
#' }

GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                        required_aes = c("x"),
                        default_aes = ggplot2::aes(y=1, alpha=0.7,
                                                   fill="white", colour="black",
                                                   size=1, shape=21, stroke = 0.4),
                        draw_key = ggplot2::draw_key_point,
                        draw_group = function(data, panel_scales, coord) {
                          coords <- coord$transform(data, panel_scales)
                          # Points definition
                          points <- grid::pointsGrob(coords$x, coords$y,
                                                     pch = coords$shape,
                                                     size = grid::unit(coords$size/(10*1.62), "lines"),
                                                     gp = grid::gpar(col = alpha(coords$colour, coords$alpha),
                                                                     fill = alpha(coords$colour, coords$alpha)
                                                     )
                          )

                          # Segment definition
                          line <- grid::segmentsGrob(
                            x0 = unit(0, "npc"), y0 = unit(coords$y, "npc"),
                            x1 = unit(1, "npc"), y1 = unit(coords$y, "npc"),
                            gp = grid::gpar(col = "gray70", alpha = .5, size = 3)
                          )
                          grid::gList(points, line)
                        }
)
## Geom Building
# timeline()
#' geom timeline is used to create a geom point in date time in order to localize an event on time.
#'
#' @param mapping Set of aesthetic mappings created by aes() or aes_(). If specified and inherit.aes = TRUE (the default), it is combined with the default mapping at the top level of the plot. You must supply mapping if there is no plot mapping.
#' @param data The data to be displayed in this layer. There are three options: If NULL, the default, the data is inherited from the plot data as specified in the call to ggplot().
#' @param stat The statistical transformation to use on the data for this layer, as a string.
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param show.legend ogical. Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. FALSE never includes, and TRUE always includes. It can also be a named logical vector to finely select the aesthetics to display.
#' @param na.rm If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.
#' @param inherit.aes If FALSE, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. borders().
#' @param ... Other arguments passed on to layer().
#'
#' @return Geom or ggproto object to build
#' @export
#'
#' @examples
#' \dontrun{
#' ggplot(data = dataCapstone_clean, mapping = aes(x = DATE)) +
#' geom_timeline( mapping = aes(size  = EQ_PRIMARY)) +
#' }
geom_timeline <- function(
  mapping = NULL, data = NULL, stat = "identity", position = "identity",
  show.legend = NA, na.rm = FALSE, inherit.aes = TRUE, ...){
  layer(
    geom = GeomTimeline, mapping = mapping, data = data,
    stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
#
#' @title Defines Our GeomTimelineLabel class
#'
#' @description The ggproto() function is used to construct a new class corresponding to your new geom.
#'
#' @import ggplot2 grid
#' @importFrom grid segmentsGrob textGrob gList gpar unit
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ggplot(dataCapstone_clean, aes(x = date, y = COUNTRY,
#'                color = as.numeric(TOTAL_DEATHS),
#'                size = as.numeric(EQ_PRIMARY),
#'                label = CLEAN_LOCATION_NAME)) +
#'   geom_timeline() +
#'   ggplot2::theme(panel.background = ggplot2::element_blank(),
#'         legend.position = "bottom",
#'         axis.title.y = ggplot2::element_blank()) + ggplot2::xlab("DATE") +
#'   geom_timeline_label(data=dataCapstone_clean)
#' }
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", ggplot2::Geom,
                             required_aes = c("x", "label"),
                             default_aes = aes( y = 1, alpha = 0.7, size = 1, fill = "grey19", colour = "grey10"),
                             draw_key = ggplot2::draw_key_label,

                             # we can already get the points and horizontal line using geom_timeline
                             # here we look to add a vertical line to a label
                             draw_group = function(data, panel_scales, coord) {
                               # print(head(data))
                               coords <- coord$transform(data, panel_scales)

                               y_extension <- 0.05
                               # Segment definition
                               line <- grid::segmentsGrob(
                                 x0 = grid::unit(coords$x, "npc") , y0 = grid::unit(coords$y, "npc"),
                                 x1 = grid::unit(coords$x, "npc"),  y1 = grid::unit(coords$y + y_extension, "npc"),
                                 gp = grid::gpar(col = "black", alpha = .7, size = 1)
                               )

                               text <- grid::textGrob(
                                 label = coords$label,
                                 x = coords$x,
                                 y = coords$y + y_extension,
                                 rot = 45,
                                 just = c("left", "bottom"),
                                 gp = grid::gpar(
                                   fontfamily = "serif",
                                   cex = .7,
                                   alpha = 0.8,
                                   fontface = "italic",
                                   size = .1)
                               )

                               grid::gList(line, text)
                             }
)
#
# geom_timeline_label
#
#' geom_timeline_label adds text directly to the plot
#'
#' @param mapping Set of aesthetic mappings created by aes() or aes_(). If specified and inherit.aes = TRUE (the default)
#' @param data The data to be displayed in this layer.
#' @param stat The statistical transformation to use on the data for this layer, as a string.
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param show.legend if TRUE a legend is shown on the figure
#' @param na.rm If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.
#' @param n_max Integer and stands for the maximum number of event to show by country
#' @param size double and stands for the size of text
#' @param inherit.aes If FALSE, overrides the default aesthetics, rather than combining with them.
#' @param ... Other arguments passed on to layer()
#' @importFrom magrittr %>%
#' @importFrom dplyr arrange filter mutate desc
#' @importFrom utils head
#'
#' @return Geom text
#' @export
#'
#' @examples
#' \dontrun{
#' ggplot(data = dataCapstone_clean, mapping = aes(x = DATE)) +
#' geom_timeline( mapping = aes(size  = EQ_PRIMARY)) +
#'  geom_timeline_label(data = dataCapstone_clean,
#'                      mapping = aes( x = DATE,
#'                                     color = TOTAL_DEATHS,
#'                                     label = CLEAN_LOCATION_NAME
#'                      )
#'  ) +
#'  ylim(0, 5)
#'
#' }
geom_timeline_label <- function(
  mapping = NULL, data = NULL, stat = "identity", position = "identity",
  show.legend = NA, na.rm = FALSE, n_max = 5, size = 1, inherit.aes = TRUE, ...
){
  #
  #
  #

  data <- data %>% dplyr::mutate(COUNTRY = as.character(COUNTRY),
                                 EQ_PRIMARY = as.numeric(EQ_PRIMARY)) %>%
    dplyr::arrange(COUNTRY, dplyr::desc(EQ_PRIMARY))

  countries <- unique(data$COUNTRY)
  df_all <- data.frame()
  for(country in countries){
    df <- data %>% dplyr::filter(COUNTRY == country) %>% utils::head(n_max)
    df_all <- rbind(df_all, df)
  }
  data <- df_all
  #
  #
  #
  layer(
    geom = GeomTimelineLabel, data = data, mapping = mapping,
    stat = stat,  position = position ,show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
