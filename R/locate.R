#' Locate an IP adress
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ip A single IPv4/IPv6 address or a domain name. If you don't supply a query the current IP address will be used.
#' @return A string.
#' @export
#' @examples
#' locate_ip("142.162.45.64")
locate_ip <- function(ip) {
  resp <- get_location(ip, format = "csv")

  string <- resp |>
    httr2::resp_body_string()

  return(string)
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
