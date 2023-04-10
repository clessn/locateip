#' Locate an IP adress
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @inheritParams get_location
#' @return A string.
#' @export
#' @examples
#' locate_ip("142.162.45.64")
locate_ip <- function(ip, fields = c("status,message,query,country,city"), ...) {
  resp <- get_location(ip, fields = fields, ..., format = "csv")

  string <- resp |>
    httr2::resp_body_string()

  return(string)
}

#' Tidy location string into a tibble
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' Internal function.
#'
#' @param string Body string response
#' @inheritParams get_location
#'
#' @return Tibble.
#' @export
tidy_location <- function(string, fields) {

  ip <- "142.162.45.64"
  fields <- "status,message,query,country,city"

  string <- get_location(ip, fields) |>
    httr2::resp_body_string()

  string_split <- stringr::str_split_1(string, ",")

  fields_split <- stringr::str_split_1(fields, ",")

  fields_n <- length(fields_split)
  string_n <- length(string_split)

  if (fields_n == string_n + 1){
    string_split <- append(string_split, NA, after = 1)

    string <- paste(string_split, collapse = ",")
  }

  data <- read.csv(text = c(fields, string), header = TRUE)
}




#' Get location
#'
#' `r lifecycle::badge('experimental')`
#'
#' Internal function.
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ip A single IPv4/IPv6 address or a domain name. If you don't supply a query the current IP address will be used.
#' @param fields Response fields to pass on to the API.
#' @param ... Query parameters to pass on to the API.
#' @param format Json, xml, csv, newline or php.
#' @return A response.
#' @export
#' @examples
#' resp <- get_location("142.162.45.64")
#'
#' resp |>
#'   httr2::resp_body_string()
get_location <- function(ip, fields = c("status,message,query,country,city"), ..., format = "csv") {
  if (validate_ip(ip) == FALSE) {
    return(print("Pleade use a valid IP adress"))
  } else {
    params <- list(
      fields = fields,
      ...
    )


    resp <- httr2::request("http://ip-api.com") |>
      httr2::req_url_path_append(format) |>
      httr2::req_url_path_append(ip) |>
      httr2::req_url_query(!!!params) |>
      httr2::req_user_agent("locateip (https://github.com/clessn; info@clessn.ca)") |>
      httr2::req_throttle(45 / 60) |>
      httr2::req_perform()

    return(resp)
  }
}
