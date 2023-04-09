#' Create request for IP API
#'
#' @param ip A single IPv4/IPv6 address or a domain name. If you don't supply a query the current IP address will be used.
#' @param format Json, xml, csv, newline or php.
#' @return A response.
#' @export
#' @examples
get_address <- function(ip, format = "csv") {

  httr2::request("http://ip-api.com") %>%
    httr2::req_url_path_append(format) %>%
    httr2::req_url_path_append(ip) %>%
    httr2::req_user_agent("ipadress (https://github.com/clessn; info@clessn.ca)") %>%
      httr2::req_throttle(45 / 60) %>%
      httr2::req_perform()

}

test <- get_address("142.162.45.64")

test %>%
  httr2::resp_body_string()
