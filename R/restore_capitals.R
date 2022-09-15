#' Restore sustom capitalisation in a string
#'
#' @param x A string in which capitalisation needs to be restored
#' @param items_to_capitalise Whole words or acronyms in which capitalisation must be retained; special characters can be included (e.g. "R2-D2")
#'
#' @return A string with restored capitals
#' @export
#'
#' @examples
#' x <- "Should i tell c-3po the french call him z-6po?"
#' restore_capitals(x, c("I", "C-3PO", "French", "Z-6PO"))
#'
restore_capitals <- function(x, items_to_capitalise) {

  for(item in items_to_capitalise) {

    x <- gsub(paste0("\\b", tolower(item), "\\b"),
              item,
              x)
  }

  return(x)

}
