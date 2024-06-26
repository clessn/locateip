test_that("tidy response works", {
  output <- tibble::tibble(
    status = "fail",
    message = "invalid query"
  )

  expect_equal(
    tidy_resp(response = "status,message\nfail,invalid query\n"),
    output
  )

  output <- tibble::tibble(
    status = "success",
    country = "Canada",
    city = "Fredericton",
    query = "0.0.0.0"
  )

  expect_equal(
    tidy_resp(response = "status,country,city,query\nsuccess,Canada,Fredericton,0.0.0.0\n"),
    output
  )
})

test_that("locate ip works", {
  output <- tibble::tibble(
    status = "success",
    country = "Canada",
    city = "Québec"
  )

  expect_equal(
    locate_ip("132.203.167.188", tidy = TRUE),
    output
  )

  output <- "status,country,city\nsuccess,Canada,Québec\n"

  expect_equal(
    locate_ip("132.203.167.188", tidy = FALSE),
    output
  )
})

test_that("create request works", {
  req <- create_req(ip = "132.203.167.188")
  expect_equal(
    req[["url"]],
    "http://ip-api.com/csv/132.203.167.188?fields=status%2Cmessage%2Ccountry%2Ccity"
  )

  req <- create_req(ip = NULL)
  expect_equal(req[["url"]],
               "http://ip-api.com/csv?fields=status%2Cmessage%2Ccountry%2Ccity")

  req <-
    create_req(ip = "132.203.167.188",
      fields = c(
        "status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,query"
      )
    )
  expect_equal(req[["url"]],
               "http://ip-api.com/csv/132.203.167.188?fields=status%2Cmessage%2Ccountry%2CcountryCode%2Cregion%2CregionName%2Ccity%2Czip%2Clat%2Clon%2Ctimezone%2Cisp%2Corg%2Cas%2Cquery")

  req <- create_req(ip = "132.203.167.188", lang = "en")
  expect_equal(req[["url"]],
               "http://ip-api.com/csv/132.203.167.188?fields=status%2Cmessage%2Ccountry%2Ccity&lang=en")

  req <- create_req(ip = "132.203.167.188", header = "true")
  expect_equal(req[["url"]],
               "http://ip-api.com/csv/132.203.167.188?fields=status%2Cmessage%2Ccountry%2Ccity&header=true")

  expect_error(get_location(ip = "132.203.167.188", lang = "uk"))
})

test_that("locate_ips() works", {
  output <- tibble::tibble(status = c("success", "success"),
                   country = c("Canada", "United States"),
                   city = c("Québec", "Ashburn"),
                   message = c(NA, NA))

  expect_equal(locate_ips(c("132.203.167.188", "8.8.8.8")), output)
})
