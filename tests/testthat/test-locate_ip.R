test_that("validate ipv6 works", {
  expect_equal(validate_ipv6("2a01:cb08:832a:500:d9e3:a1d0:3d20:5f7e"),
               TRUE)
})

test_that("validate ipv4 works", {
  expect_equal(validate_ipv4("142.162.45.64"),
               TRUE)
})

test_that("validate ip works", {
  expect_equal(validate_ip("142.162.45.64"),
               NULL)
  expect_equal(validate_ip("2a01:cb08:832a:500:d9e3:a1d0:3d20:5f7e"),
               NULL)
})
