#' Locate an IP adress
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ip String. Either an IPv4 address, IPv6 address or a domain name. If NULL, will use the current IP address.
#' @param fields String. Response fields to pass on to the API.
#' @param lang String. Response language. An ISO 639 code supported by the API. Defaults to English.
#' @param ... Query parameters to pass on to the API.
#' @param tidy Logical. TRUE to return a tibble. FALSE to return a string.
#' @return A string or a tibble.
#' @export
#' @examples
#' locate_ip("132.203.167.188")
locate_ip <-
  function(ip = NULL,
           fields = c("status,message,country,city"),
           lang = "en",
           ...,
           tidy = TRUE) {
    resp <- get_location(ip, fields = fields, lang = lang, ..., format = "csv")

    string <- resp |>
      httr2::resp_body_string()

    if (tidy) {
      data <- tidy_resp(response = string)

      return(data)
    } else {
      return(string)
    }
  }

#' Create request for 'ip-api'
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ip String. Either an IPv4 address, IPv6 address or a domain name. If NULL, will use the current IP address.
#' @param fields String. Response fields to pass on to the API.
#' @param ... Query parameters to pass on to the API.
#' @param format String. Json, xml, csv, newline or php.
#' @return A response.
#'
#' @noRd
create_req <-
  function(ip = NULL,
           fields = c("status,message,country,city"),
           ...,
           format = "csv") {
    params <- list(fields = fields,
                   ...)

    req <- httr2::request("http://ip-api.com") |>
      httr2::req_url_path_append(format)

    if (is.null(ip) == FALSE) {
      req <- httr2::req_url_path_append(req, ip)
    }

    req <- req |>
      httr2::req_url_query(!!!params) |>
      httr2::req_user_agent("locateip (https://github.com/clessn; info@clessn.ca)") |>
      httr2::req_throttle(45 / 60)

    return(req)
  }

#' Get location
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ip String. Either an IPv4 address, IPv6 address or a domain name. If NULL, will use the current IP address.
#' @param fields String. Response fields to pass on to the API.
#' @param lang String. Response language. An ISO 639 code supported by the API. Defaults to English.
#' @param header Logical. Get field headers.
#' @param ... Query parameters to pass on to the API.
#' @param format String. Json, xml, csv, newline or php.
#' @return A response.
#'
#' @noRd
get_location <-
  function(ip = NULL,
           fields = c("status,message,country,city"),
           lang = "en",
           header = "true",
           ...,
           format = "csv") {
    lang <- match.arg(lang, c("en", "de", "es", "pt-BR", "fr", "ja", "zh-CN", "ru"))

    resp <- create_req(ip = ip, fields = fields, lang = lang, header = header, ..., format = format) |>
      httr2::req_perform()

    # If there's no remaining requests, pause execution
    if (as.numeric(httr2::resp_header(resp, "X-Rl")) == 0) {
      Sys.sleep(as.numeric(httr2::resp_header(resp, "X-Ttl")))
    }

    return(resp)
  }

#' Tidy response string into a tibble
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' Internal function.
#' @param response Body string response with field headers
#' @noRd
#' @return Tibble.
tidy_resp <- function(response = NULL) {

  data <- readr::read_csv(response, show_col_types = FALSE)

  return(data)
}

#' Locate multiple IP addresses
#'
#' `r lifecycle::badge('experimental')`
#'
#' For API documentation and terms of service, see [ip-api.com](https://ip-api.com/).
#'
#' @param ips Character vector of either an IPv4 address, IPv6 address.
#' @param fields String. Response fields to pass on to the API.
#' @param lang String. Response language. An ISO 639 code supported by the API. Defaults to English.
#' @param tidy Logical. TRUE to return a tibble. FALSE to return a list.
#' @return A list or tibble
#' @export
#' @examples
#' locate_ips(c("132.203.167.188", "8.8.8.8", "208.80.152.201"))
locate_ips <- function(ips = NULL,
                       fields = c("status,message,country,city"),
                       lang = "en",
                       tidy = TRUE){

  ips <- split(ips, ceiling(seq_along(ips) / 100))
  ips <- lapply(ips, unname)

  responses <-
    lapply(ips,
         \(x){
           batch_request(ips = x, fields = fields, lang = lang, tidy = tidy)
           })

  if(tidy){
    do.call(rbind, responses) |>
      as_tibble()
  } else unlist(responses, recursive = FALSE)

}

#' JSON encoded POST request to http/::ip-api/batch
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' @param ips A character vector of 100 or fewer IP addresses.
#' Internal function.
#' @noRd
#' @return A list of responses
batch_request <- function(ips = NULL, fields, lang, tidy){
  lang <- match.arg(lang, c("en", "de", "es", "pt-BR", "fr", "ja", "zh-CN", "ru"))

  req <- httr2::request("http://ip-api.com") |>
    httr2::req_url_path_append("batch")

  req <- httr2::req_url_query(req, fields = fields, lang = lang)
  req <- httr2::req_body_json(req, data = as.list(ips))

  req <- httr2::req_user_agent(req, "locateip (https://github.com/clessn; info@clessn.ca)") |>
    httr2::req_throttle(45 / 60)

  resp <- httr2::req_perform(req)

  json_body <- httr2::resp_body_json(resp)

  if(tidy){
    lapply(json_body, tibble::as_tibble) |>
      lapply(\(x){
        fields_vec <- unlist(strsplit(fields, ","), recursive = TRUE)
        x[fields_vec[!fields_vec %in% names(x)]] <- NA
        x
      }) |>
      do.call(rbind, args = _) |>
      tibble::as_tibble()
  } else {
    json_body
  }
}
