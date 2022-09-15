#' Render ordinal dates in UK or US style
#'
#' @param date_to_format The date to use. It must be either be of class `Date` or a string written as "YYYY-MM-DD" or "YYYY/MM/DD")
#' @param uk_or_us Defaults to "UK", which results in outputs like "12th September 2022"; if
#' "US", the output resembles "September 12th, 2022".
#' @param formal_or_informal Defaults to "informal", so the ordinals are included (e.g. "st", "nd", "rd", "th").
#' If "formal" is chosen, the ordinals are omitted (e.g. "12 September 2022").
#'
#' @return A string (e.g. "12th September 2022")
#' @export
#'
#' @examples prettify_date(Sys.Date(), "UK", "informal")
prettify_date <- function(date_to_format = Sys.Date(),
                          uk_or_us = "UK",
                          formal_or_informal = "informal") {

  day_num <- as.numeric(format(as.Date(date_to_format), "%d"))

  if (!(day_num %% 100 %in% c(11, 12, 13))) {
    day_th <- switch(as.character(day_num %% 10),
                     "1" = {paste0(day_num, "st")},
                     "2" = {paste0(day_num, "nd")},
                     "3" = {paste0(day_num, "rd")},
                     paste0(day_num, "th"))
  } else {
    day_th <- paste0(day_num, "th")
  }

  num_to_use <- ifelse(formal_or_informal == "informal",
                       day_th,
                       day_num)

  if(uk_or_us == "UK") {
    paste(num_to_use, format(as.Date(date_to_format), "%B %Y"))
  } else {
    paste0(format(as.Date(date_to_format), "%B"), " ",
           num_to_use, ", ", format(as.Date(date_to_format), "%Y"))
  }
}
