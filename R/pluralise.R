#' Pluralise words if their accompanying number is not 1
#'
#' @param word A word which should be returned as plural if `count` is equal to 0 or greater than 1.
#' @param count A number to apply to `word`
#' @param plural How to make the plural; defaults to an "s" which is added at the end of the word.
#' Can be anything. See `add_or_swap`.
#' @param add_or_swap Choose between `add` (add the plural form (e.g. "s") onto the end; e.g. `house`
#' becomes `houses`) and `swap` (swap for the plural form; e.g. `mouse` becomes `mice`)
#'
#' @return A word which is pluralised or not based on the value of `count`
#' @export
#'
#' @examples
pluralise <- function(word,
                      count,
                      plural = "s",
                      add_or_swap = "add",
                      include_number = TRUE,
                      sentence_start = FALSE){

  if(count == 1) {
    output_word <- word
  } else {
    output_word <- ifelse(add_or_swap == "swap",
                          plural,
                          paste0(word, plural))
  }




}
