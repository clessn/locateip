#' Create request for IP API
#'
#' Internal function.
#'
#' @param ip IP
#' @param ... Extra parameters to add to the query.
#' @return A request.
#' @export
#' @examples
get_address <- function(ip = NULL) {

  httr2::request("http://ip-api.com") %>%
    httr2::req_url_path_append("csv") %>%
    httr2::req_url_query(ip = ip) %>%
    httr2::req_user_agent("ipadress (https://github.com/clessn; info@clessn.ca)") %>%
      httr2::req_throttle(45 / 60) %>%
      httr2::req_perform()

}

test <- get_address(ip = "24.48.0.1")

test %>%
  httr2::resp_body_json()
