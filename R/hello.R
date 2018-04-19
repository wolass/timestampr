# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

require("magrittr")
require("digest")
require(httr)

timestamp <- function(filename,key,service = "originstamp") {
  body <- list(hash_sha256 = readLines(filename) %>%
                 digest::digest(algo="sha256"))
  if(service=="originstamp"){
    base <- "http://api.originstamp.org/api/"
    endpoint <- "stamps"
    url <- paste0(base,endpoint)
    obj <- httr::POST(url = url,
                      body = body,
                      add_headers(Authorization = paste0("Token token='",key,"'")),
                      encode = "json",
                      verbose())
  }
}

