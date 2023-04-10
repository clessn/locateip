#' Locate an IP adress
#'
#' `r lifecycle::badge('experimental')`
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

  httr2::request("http://ip-api.com") |>
    httr2::req_url_path_append(format) |>
    httr2::req_url_path_append(ip) |>
    httr2::req_user_agent("locateip (https://github.com/clessn; info@clessn.ca)") |>
      httr2::req_throttle(45 / 60) |>
      httr2::req_perform()

}

#' Validate
#' @param ip IP address in IPv4 or IPv6
#' @return Logical.
#' @describeIn validate Validate IP
validate_ip <- function(ip) {
  is_ipv4 <- validate_ipv4(ip)
  is_ipv6 <- validate_ipv6(ip)

  return(is_ipv4 | is_ipv6)
}

#' @describeIn validate Validate IPv4
validate_ipv4 <- function(ip){
  valid <- grepl("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$", ip)
  return(valid)
}

#' @describeIn validate Validate IPv6
validate_ipv6 <- function(ip){
  valid <- grepl("(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))", ip)
  return(valid)
}
