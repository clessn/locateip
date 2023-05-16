
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

For the most recent version, on CRAN:

``` r
install.packages("locateip")
```

You can install the development version of locateip from
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("clessn/locateip")
```

## Example

``` r
library(locateip)

locate_ip("132.203.167.188", fields = c("status,message,country,city"))
#> # A tibble: 1 × 3
#>   status  country city  
#>   <chr>   <chr>   <chr> 
#> 1 success Canada  Québec
```

## Usage

[ip-api](https://ip-api.com/) is free for non-commercial use.

For API documentation and terms of service, see
[ip-api.com](https://ip-api.com/).
