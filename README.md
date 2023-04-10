
<!-- README.md is generated from README.Rmd. Please edit that file -->

# locateip

<!-- badges: start -->

[![R-CMD-check](https://github.com/clessn/ipadress/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/clessn/ipadress/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/clessn/locateip/branch/main/graph/badge.svg)](https://app.codecov.io/gh/clessn/locateip?branch=main)
<!-- badges: end -->

The goal of locateip is to locate IP addresses using
[ip-api.com](https://ip-api.com/)

## Installation

You can install the development version of locateip from
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("clessn/locateip")
```

## Example

``` r
library(locateip)

resp <- locate_ip("142.162.45.64")

resp |>
  httr2::resp_body_string()
#> [1] "success,Canada,CA,NB,New Brunswick,Fredericton,E3A,46.0401,-66.3862,America/Moncton,Bell Canada,Bell Canada,AS855 Bell Canada,142.162.45.64\n"
```

## Usage

[ip-api](https://ip-api.com/) is free for non-commercial use.

For API documentation and terms of service, see
[ip-api.com](https://ip-api.com/).
