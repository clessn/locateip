test_that("validate ipv6 works", {
  expect_equal(validate_ipv6("2a01:cb08:832a:500:d9e3:a1d0:3d20:5f7e"),
               TRUE)
})

test_that("validate ipv4 works", {
  # Valid
  expect_equal(validate_ipv4("142.162.45.64"),
               TRUE)
  expect_equal(validate_ipv4("0.0.0.0"),
               TRUE)
  expect_equal(validate_ipv4("127.255.255.255"),
               TRUE)
  expect_equal(validate_ipv4("128.0.0.0"),
               TRUE)
  expect_equal(validate_ipv4("191.255.255.255"),
               TRUE)
  expect_equal(validate_ipv4("192.0.0.0"),
               TRUE)
  expect_equal(validate_ipv4("223.255.255.255"),
               TRUE)

  # Not valid

})

test_that("validate ip works", {
  expect_equal(validate_ip("142.162.45.64"),
               TRUE)
  expect_equal(validate_ip("2a01:cb08:832a:500:d9e3:a1d0:3d20:5f7e"),
               TRUE)
})
