#' Locate an IP adress
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param tidy Logical. TRUE to return a tibble. FALSE to return a string.
#' @inheritParams get_location
#' @return A string or a tibble.
#' @export
#' @examples
#' locate_ip("132.203.167.188")
locate_ip <- function(ip, fields = c("status,message,country,city"), ..., tidy = TRUE) {
  resp <- get_location(ip, fields = fields, ..., format = "csv")

  string <- resp |>
    httr2::resp_body_string()

  if (tidy) {
    data <- tidy_location(response = string, fields = fields)

    return(data)
  } else {
    return(string)
  }
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
#' resp <- get_location("132.203.167.188")
#'
#' resp |>
#'   httr2::resp_body_string()
get_location <- function(ip, fields = c("status,message,country,city"), ..., format = "csv") {
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

#' Tidy location string into a tibble
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' Internal function.
#'
#' @param response Body string response
#' @inheritParams get_location
#'
#' @return Tibble.
#' @export
#' @examples
#' ip <- "132.203.167.188"
#' fields <- "status,message,country,city"
#'
#' response <- get_location(ip, fields) |>
#'    httr2::resp_body_string()
#'
#' tidy_location(response, fields)
#'
tidy_location <- function(response = NULL, fields = NULL) {

  response <- stringr::str_trim(response, side = "right")

  response_split <- stringr::str_split_1(response, ",")
  fields_split <- stringr::str_split_1(fields, ",")

  fields_n <- length(fields_split)
  response_n <- length(response_split)

  if (fields_n == response_n + 1){
    response_split <- append(response_split, NA, after = 1)

    response <- paste(response_split, collapse = ",")
  }

  data <- utils::read.csv(text = c(fields, response), header = TRUE) |>
    tibble::as_tibble()

  return(data)
}
