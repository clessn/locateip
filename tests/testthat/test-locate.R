test_that("tidy location works", {
  output <- tibble::tibble(status = "success",
                           message = NA,
                           country = "Canada",
                           city = "Fredericton",
                           query = "0.0.0.0")

  expect_equal(tidy_location(response = "success,Canada,Fredericton,0.0.0.0\n", fields = "status,message,country,city,query"), output)

  output <- tibble::tibble(status = "success",
                           country = "Canada",
                           city = "Fredericton",
                           query = "0.0.0.0")

  expect_equal(tidy_location(response = "success,Canada,Fredericton,0.0.0.0\n", fields = "status,country,city,query"), output)
})

test_that("locate ip works", {
  output <- tibble::tibble(status = "success",
                           message = NA,
                           country = "Canada",
                           city = "Québec")

  expect_equal(locate_ip("132.203.167.188", fields = "status,message,country,city", tidy = TRUE), output)

  output <- "success,Canada,Québec\n"

  expect_equal(locate_ip("132.203.167.188", fields = "status,message,country,city", tidy = FALSE), output)
})
