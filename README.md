
<!-- README.md is generated from README.Rmd. Please edit that file -->

# locateip

<!-- badges: start -->
<!-- badges: end -->

The goal of locateip is to locate IP addresses using
[ip-api.com](ip-api.com)

## Installation

You can install the development version of wikiapir from
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("clessn/ipadress")
```

## Example

``` r
library(locateip)

resp <- locate_ip("142.162.45.64")

resp |>
  httr2::resp_body_string()
#> [1] "success,Canada,CA,NB,New Brunswick,Fredericton,E3A,46.0401,-66.3862,America/Moncton,Bell Canada,Bell Canada,AS855 Bell Canada,142.162.45.64\n"
```
