#' Locate an IP adress
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ip A single IPv4/IPv6 address or a domain name. If you don't supply a query the current IP address will be used.
#' @param format Json, xml, csv, newline or php.
#' @return A response.
#' @export
#' @examples
#' resp <- locate_ip("142.162.45.64")
#'
#' resp |>
#'   httr2::resp_body_string()
locate_ip <- function(ip, format = "csv") {
  if (validate_ip(ip) == FALSE) {
    return(print("Pleade use a valid IP adress"))
  } else {
    resp <- httr2::request("http://ip-api.com") |>
      httr2::req_url_path_append(format) |>
      httr2::req_url_path_append(ip) |>
      httr2::req_user_agent("locateip (https://github.com/clessn; info@clessn.ca)") |>
      httr2::req_throttle(45 / 60) |>
      httr2::req_perform()

    return(resp)
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
#' @param format Json, xml, csv, newline or php.
#' @return A response.
#' @export
#' @examples
#' resp <- locate_ip("142.162.45.64")
#'
#' resp |>
#'   httr2::resp_body_string()
get_location <- function(ip, format = "csv") {
  if (validate_ip(ip) == FALSE) {
    return(print("Pleade use a valid IP adress"))
  } else {
    resp <- httr2::request("http://ip-api.com") |>
      httr2::req_url_path_append(format) |>
      httr2::req_url_path_append(ip) |>
      httr2::req_user_agent("locateip (https://github.com/clessn; info@clessn.ca)") |>
      httr2::req_throttle(45 / 60) |>
      httr2::req_perform()

    return(resp)
  }
}
