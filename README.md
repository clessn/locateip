
<!-- README.md is generated from README.Rmd. Please edit that file -->

# locateip

<!-- badges: start -->
<!-- badges: end -->

The goal of locateip is to locate IP addresses using
[ip-api.com](ip-api.com)

## Installation

You can install the development version of wikiapir from
[GitHub](https://github.com/):

1.  Create an access token in <https://github.com/settings/tokens>
2.  Save the access token to R environ using `usethis::edit_r_environ()`

``` r
# .Renviron
GITHUB_TOKEN <- "tokenstring"
```

3.  Install the package

``` r
# install.packages("devtools")

devtools::install_github("clessn/locateip",
  ref = "main",
  auth_token = Sys.getenv("GITHUB_TOKEN")
)
```

## Example

``` r
library(locateip)

resp <- locate_ip("142.162.45.64")

resp |>
  httr2::resp_body_string()
```
