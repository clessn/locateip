
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ipadress

<!-- badges: start -->
<!-- badges: end -->

The goal of ipadress is to locate IP addresses using
[ip-api.com](ip-api.com)

## Installation

You can install the development version of ipadress from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("clessn/ipadress")
```

## Example

``` r
library(ipadress)

resp <- get_address("142.162.45.64")

resp |>
  httr2::resp_body_string()
```
