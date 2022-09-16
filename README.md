verbaliseR
================

![](inst/figures/logo-social.png)

## Make your text mighty fine

**{verbaliseR}** is a collection of functions that make it easier to
turn R analysis outputs into sentences. Here’s a quick example:

``` r
library(dplyr)

unique_species <- palmerpenguins::penguins %>%
  pull(species) %>%
  unique()

paste0("There are ", 
       verbaliseR::pluralise(word = "species", 
                             count = length(unique_species), 
                             plural = "species", 
                             add_or_swap = "swap"), 
       " of penguins in this dataset: ",
       verbaliseR::listify(unique_species, 
                           linking_word = "and"),
       ".")
```

    ## [1] "There are three species of penguins in this dataset: Adelie, Gentoo and Chinstrap."

## Installation

Install from GitHub:

``` r
# If you don't already have the {remotes} package installed:
install.package("remotes")

# Then:
remotes::install_github("cararthompson/verbaliseR")
```

## Main functions

### `listify()`

Takes a vector and returns a string where the items in the vector are
listed in prose. The link word can be anything you like, and there is an
option to add an Oxford comma if desired. Here are a few examples:

``` r
# The default returns a list with "and" ...
verbaliseR::listify(c("a", "b", "c"))
```

    ## [1] "a, b and c"

``` r
# to which you can choose add an Oxford comma
verbaliseR::listify(c("a", "b", "c"),
                    oxford_comma = TRUE)
```

    ## [1] "a, b, and c"

``` r
# You can modify the linking word...
verbaliseR::listify(c("a", "b", "c"), 
                    linking_word = "or")
```

    ## [1] "a, b or c"

``` r
# ... and get quite creative with it ...
verbaliseR::listify(c(verbaliseR::listify(c("a", "b", "c"), 
                                          linking_word = "or"),
                      "d"),
                    linking_word = "but most certainly not",
                    oxford_comma = TRUE)
```

    ## [1] "a, b or c, but most certainly not d"

``` r
# ... in whatever language you choose
verbaliseR::listify(c(verbaliseR::listify(c("a", "b", "c"), 
                                          linking_word = "ou"),
                      "d"),
                    linking_word = "mais jamais au grand jamais",
                    oxford_comma = TRUE)
```

    ## [1] "a, b ou c, mais jamais au grand jamais d"

### `prettify_date()`

Takes a `date` or string formatted as “YYYY_MM_DD” or “YYYY/MM/DD” and
returns a string which is the date formatted in prose. Options include
UK/US style and formal/informal (without / with the ordinals)

``` r
# Defaults to UK style, informal
verbaliseR::prettify_date(Sys.Date())
```

    ## [1] "16th September 2022"

``` r
# Can also do US style
verbaliseR::prettify_date("2022/09/15", 
                          uk_or_us = "US")
```

    ## [1] "September 15th, 2022"

``` r
# To remove the ordinals, select formal_or_informal = "formal"
verbaliseR::prettify_date("2022-09-15", 
                          uk_or_us = "US", 
                          formal_or_informal = "formal")
```

    ## [1] "September 15, 2022"

### `num_to_text()`

Used within `pluralise()` this function can also be useful on its own.
It takes a number (whole number as numeric or integer) and writes it out
in full, applying the following rules:

-   Numbers 0-10 are always written out in full, regardless of their
    place in the sentence
-   Numbers 11-1000 are written out in full only if they are at the
    start of a sentence
-   Numbers above 1000 or numbers containing a decimal point are never
    written out in full, but are formatted for readability with a big
    mark delimiter (e.g. 12345.67 turns into “1,2345.67”)

The big mark can be modified.

``` r
verbaliseR::num_to_text(3)
```

    ## [1] "three"

``` r
# 0 defaults to "no", but can be changed to anything
verbaliseR::num_to_text(0)
```

    ## [1] "no"

``` r
verbaliseR::num_to_text(0, zero_or_no = "none")
```

    ## [1] "none"

``` r
verbaliseR::num_to_text(3, 
                        sentence_start = TRUE)
```

    ## [1] "Three"

``` r
# Only whole numbers are returned as text; a warning is issued accordingly
verbaliseR::num_to_text(1.25, 
                        sentence_start = TRUE)
```

    ## Warning in verbaliseR::num_to_text(1.25, sentence_start = TRUE): 1.25 is not a
    ## whole number. It is kept as a numeral.

    ## [1] "1.25"

``` r
# Numbers greater than 1000 are not returned as text even if they are at the start of a sentence; 
# a warning is issued accordingly
# They are however formatted for readability
verbaliseR::num_to_text(3333, 
                        sentence_start = TRUE)
```

    ## Warning in verbaliseR::num_to_text(3333, sentence_start = TRUE): Numbers greater
    ## than 1000 are returned as numerals, regardless of their place in the sentence.

    ## [1] "3,333"

``` r
# To change the default formatting, specify a custom big_mark
verbaliseR::num_to_text(3333, 
                        sentence_start = TRUE, 
                        big_mark = " ")
```

    ## Warning in verbaliseR::num_to_text(3333, sentence_start = TRUE, big_mark = " "):
    ## Numbers greater than 1000 are returned as numerals, regardless of their place in
    ## the sentence.

    ## [1] "3 333"

### `pluralise()`

Takes a string and turns it into its plural, based on user input. It
also retains the number, applying the rules of `num_to_text()` to it,
unless specified otherwise. The flexibility of this function means it
can be used in any language, but since numbers are currently returned
only in English, users of other languages will need to specify
`include_number = FALSE` for now if the number is between 1 and 10 or if
`sentence_start` is `TRUE`.

``` r
# The default plural is an s tagged onto the end of the word ...
verbaliseR::pluralise("penguin", 3)
```

    ## [1] "three penguins"

``` r
# ... but this can be changed ...
verbaliseR::pluralise("bateau", 3, 
                      plural = "x", 
                      include_number = FALSE)
```

    ## [1] "bateaux"

``` r
# ... or a new word can be substituted
verbaliseR::pluralise("sheep", 3, 
                      plural = "sheep", 
                      add_or_swap = "swap")
```

    ## [1] "three sheep"

``` r
# Numbers below 1001 are written out in full at the start of sentences ...
verbaliseR::pluralise("penguin", 333,
                      sentence_start = TRUE)
```

    ## [1] "Three hundred and thirty-three penguins"

``` r
# ... but not in the middle of sentences
verbaliseR::pluralise("penguin", 333)
```

    ## [1] "333 penguins"

``` r
# Numbers above 1000 are never written out in full but are formatted for readability ...
verbaliseR::pluralise("unit", 12345.67,
                      sentence_start = TRUE)
```

    ## [1] "12345.67 units"

``` r
# ... with a cusomisable big mark
verbaliseR::pluralise("unit", 12345.67,
                      big_mark = " ")
```

    ## [1] "12345.67 units"

### `restore_capitals()`

Takes a string in which some or all capitalisation has been lost, and
restores capitals in the specified items.

``` r
x <- "Should i tell c-3po the french call him z-6po?"

verbaliseR::restore_capitals(x, c("I", "C-3PO", "French", "Z-6PO"))
```

    ## [1] "Should I tell C-3PO the French call him Z-6PO?"

## Further information

-   Report bugs or suggest new features
    [here](https://github.com/cararthompson/verbaliseR/issues).
-   Open to PRs from rstats users who want to make `num_to_text` and
    `prettify_date()` work in different languages.
-   Logo by [Jenny Legrand
    Photography](https://www.jennylegrandphotography.com/)
