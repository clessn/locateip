test_that("tidy location works", {
  output <- tibble::tibble(status = "success",
                           message = NA,
                           country = "Canada",
                           city = "Fredericton",
                           query = "0.0.0.0")

  expect_equal(tidy_location("success,Canada,Fredericton,0.0.0.0\n", "status,message,country,city,query"), output)
})
