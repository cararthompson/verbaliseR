

#' Spell out numbers if they are smaller than ten
#'
#' @param number Whole number as `numeric` or `integer`, to be turned into text.
#' @param sentence_start Logical. If `TRUE`, numbers below 100 are written out in full, and their first letter is capitalised.
#' @param zero_or_no Specify what to print when the number is 0. Defaults to "no". Can be any string.
#'
#' @return
#' @export
#'
#' @examples
num_to_text <- function(number,
                        sentence_start = FALSE,
                        zero_or_no = "no") {

  # Return numeral if no other conditions are met (x > 10, & not start of sentence or x > 100)
  num_to_print <- number

  x <- as.numeric(number)
  if (is.na(x)) stop(paste0(number, " is not a number."))

  if(x %% 1 != 0) stop(paste0(number, " is not a whole number. Use numerals instead of spelling it out."))

  if(x > 100) warning("Numbers over 99 will be returned as numerals,
                     regardless of their place in the sentence.")

  ones <- c("one", "two", "three", "four",
            "five", "six", "seven", "eight", "nine")
  teens <- c("Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen",
             "Sixteen", "Seventeen", "Eighteen", "Nineteen")
  tens <- c("Twenty", "Thirty", "Forty", "Fifty",
            "Sixty", "Seventy", "Eighty", "Ninety")

  if(x == 0) num_to_print <- zero_or_no
  if(x < 10) num_to_print <- ones[x]
  if(x == 10) num_to_print <- "ten"
  if(x == 100) num_to_print <- "one hundred"

  if(sentence_start == TRUE & x %in% c(10:19)) {
    num_to_print <- teens[x-9]
  }

  if(sentence_start == TRUE & x %in% c(20:99)) {
    num_to_print <- paste0(
      tens[(x %/% 10) - 1],
      ifelse(x %% 10 != 0, "-", ""),
      ones[x %% 10]
    )
  }

  if(sentence_start == TRUE) {
    num_to_print <- stringr::str_to_sentence(num_to_print)
  }

  return(num_to_print)

}
