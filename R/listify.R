#' Turn vectors into lists with any specified linking word
#'
#' @param items A vector of items to turn into a list phrase (e.g. c("a", "b", "c")).
#' @param linking_word Defaults to "and". Can be anything.
#' @param oxford_comma `logical`. Defaults to `FALSE`. If TRUE, an oxford comma is added (e.g. "a, b, and c").
#'
#' @return A string in the form of a list (e.g. "a, b and c")
#' @export
#'
#' @examples listify(c("a", "b", "c"), "or")
#'
listify <- function(items,
                    linking_word = "and",
                    oxford_comma = FALSE) {

  if(length(items) > 1) {
  paste0(paste0(items[1:length(items)-1],
              collapse = ", "),
        ifelse(oxford_comma == TRUE, ", ", " "),
        linking_word,
        " ",
        items[length(items)])
  } else {
    paste(items)
  }
}
