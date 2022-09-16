#' Spell out numbers if they are smaller than ten
#'
#' @param number Whole number as `numeric` or `integer`, to be turned into text. Numbers 1-10 are always written out in full,
#' regardless of their place in the sentence. Number 11-999 are written out in full if they are at the beginning of a sentence.
#' Numbers greater than 1000 are returned as numerals.
#' @param sentence_start Logical. If `TRUE`, numbers below 100 are written out in full, and their first letter is capitalised.
#' @param zero_or_no Specify what to print when the number is 0. Defaults to "no". Can be any string.
#' @param uk_or_us Defaults to UK which adds an "and" between "hundred" and other numbers (e.g. "One hundred and five"). If "US"
#' is chosen, the "and" is removed (e.g. "One hundred five").
#' @param big_mark Defaults to "," (e.g. "1,999").
#'
#' @return A string
#' @export
#'
#' @examples num_to_text(3)
#' num_to_text(333, sentence_start = TRUE)
#'
num_to_text <- function(number,
                        sentence_start = FALSE,
                        zero_or_no = "no",
                        uk_or_us = "UK",
                        big_mark = ",") {

  # Return numeral if no other conditions are met (x > 10, & not start of sentence or x > 100)
  num_to_print <- number
  uk_or_us <- toupper(uk_or_us)

  x <- as.numeric(number)
  if (is.na(x)) stop(paste0(number, " is not a number."))

  if(x %% 1 != 0) warning(paste0(number, " is not a whole number. It is kept as a numeral."))

  if(x %% 1 == 0 & x > 999) {
    warning("Numbers greater than 1000 are returned as numerals, regardless of their place in the sentence.")
    num_to_print <- format(x, big.mark = big_mark)
  }

  ones <- c("one", "two", "three", "four",
            "five", "six", "seven", "eight", "nine")
  teens <- c("ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
             "sixteen", "seventeen", "eighteen", "nineteen")
  tens <- c("twenty", "thirty", "forty", "fifty",
            "sixty", "seventy", "eighty", "ninety")

  if(x == 0) num_to_print <- zero_or_no
  if(x !=0  & x %% 1 == 0 & x < 10) num_to_print <- ones[x]
  if(x == 10) num_to_print <- "ten"
  if(x == 100) num_to_print <- "one hundred"
  if(x == 1000) num_to_print <- "one thousand"

  if(sentence_start == TRUE & x %in% c(10:19)) {
    num_to_print <- teens[x-9]
  }

  if(sentence_start == TRUE & x %in% c(20:999)) {

    hundreds <- ifelse(x > 99,
                       paste(ones[x %/% 100], "hundred"),
                       "")
    if(x %% 100 > 19) {
      sub_hundreds <-  paste0(tens[(x %% 100 %/% 10) - 1],
                              ifelse(x %% 10 != 0, "-", ""),
                              ones[x %% 10])
    } else if (x %% 100 > 9) {
      sub_hundreds <- paste0(teens[x %% 100 - 9])
    } else if (x %% 100 > 0) {
      sub_hundreds <- ones[x %% 100]
    }

    num_to_print <- paste0(
      ifelse(x > 99, paste(ones[x %/% 100], "hundred"), ""),
      ifelse(x > 99 & x %% 100 != 0 & uk_or_us == "UK", " and ", ""),
      ifelse(x %% 100 != 0,
             sub_hundreds,
             "")
    )
  }

  if(sentence_start == TRUE) {
    num_to_print <- stringr::str_to_sentence(num_to_print)
  }

  return(num_to_print)

}
