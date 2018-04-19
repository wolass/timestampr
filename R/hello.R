#' @title Timestamp a file
#' @description This function uses cryptography to timestamp a text file
#' @param filename This is the text file that will be read into the function using ReadLines. After this the hash will be produced
#' @param key This is the authentication token used on your stamping site if you are using originstam.org then get it here http://originstamp.org/dev
#' @param service Right now only originstamp is supported.
#' @export

require("magrittr")
require("digest")
require(httr)


timestamp <- function(filename,
                      key,
                      service = "originstamp",
                      email,
                      comment) {
  body <- list(email=email,
               comment=comment
  )
  if(service=="originstamp"){
    base <- "http://api.originstamp.org/api/"
    endpoint <- "stamps"
    url <- paste0(base,readLines(filename) %>%
                    digest::digest(algo="sha256"))
    obj <- httr::POST(url = url,
                      body = body,
                      add_headers(Authorization = paste0(key)),
                      encode = "json",
                      verbose())
  }
}
