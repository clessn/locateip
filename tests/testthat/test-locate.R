test_that("tidy location works", {
  output <- tibble::tibble(
    status = "success",
    message = NA,
    country = "Canada",
    city = "Fredericton",
    query = "0.0.0.0"
  )

  expect_equal(
    tidy_location(response = "success,Canada,Fredericton,0.0.0.0\n", fields = "status,message,country,city,query"),
    output
  )

  output <- tibble::tibble(
    status = "success",
    country = "Canada",
    city = "Fredericton",
    query = "0.0.0.0"
  )

  expect_equal(
    tidy_location(response = "success,Canada,Fredericton,0.0.0.0\n", fields = "status,country,city,query"),
    output
  )
})

test_that("locate ip works", {
  output <- tibble::tibble(
    status = "success",
    message = NA,
    country = "Canada",
    city = "Québec"
  )

  expect_equal(
    locate_ip("132.203.167.188", fields = "status,message,country,city", tidy = TRUE),
    output
  )

  output <- "success,Canada,Québec\n"

  expect_equal(
    locate_ip("132.203.167.188", fields = "status,message,country,city", tidy = FALSE),
    output
  )
})

test_that("create request works", {
  req <- create_req(ip = "132.203.167.188")
  expect_equal(
    req[["url"]],
    "http://ip-api.com/csv/132.203.167.188?fields=status%2Cmessage%2Ccountry%2Ccity"
  )

  # req <- create_req(ip = NULL)
  # expect_equal(req[["url"]],
  #              "http://ip-api.com/csv?fields=status%2Cmessage%2Ccountry%2Ccity")

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

})
