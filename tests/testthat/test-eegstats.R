# Tests for all eegstats functions

context('core eegstats functionality') # basically header for tests

test_that("ind_average_erp should return correct single-subject erp matrix", { # description of test

  sub = c('S1', 'S2', 'S3')
  ele = 12

  ind_average_erp_data <- compute_ind_average_erp(my_erpdata, electrode = ele, subject = sub)

  # output should be an array ?
  expect_true(is.array(ind_average_erp_data))

  # computed for all subjects ?
  expect_equal(dim(ind_average_erp_data)[1], length(sub))

  # computed for all conditions ?
  expect_equal(dim(ind_average_erp_data)[2], length(unique(my_erpdata[,2])))

  # computed for all times ?
  expect_equal(dim(ind_average_erp_data)[3], length(unique(my_erpdata[,3])))

  # no NAs
  expect_true(sum(is.na(my_erpdata)) ==  sum(is.na(my_erpdata)))

})





test_that("grand_average_erp should return correct grand average ERP matrix", { # description of test

  ele = 12 # specify electrode

  grand_average_erp_data <- compute_grand_average_erp(my_erpdata, electrode = ele)

  # output should be an array ?
  expect_true(is.matrix(grand_average_erp_data))


  # computed for all conditions ?
  expect_equal(nrow(grand_average_erp_data), length(unique(my_erpdata[,2])))

  # computed for all times ?
  expect_equal(ncol(grand_average_erp_data), length(unique(my_erpdata[,3])))

  # no NAs
  expect_true(sum(is.na(my_erpdata)) ==  sum(is.na(my_erpdata)))

})


test_that("computed ERP - ERSP correlation", { # description of test

  e = 12 # electrode

  f = 10 # frequency

  t = 100 # time

  res <- correlate_erp_ersp(my_erpdata, electrode = e, time_erp = t, my_erspdata, frequency = f)

  # correct shape
  expect_true(is.matrix(res[[1]])) # correlation matrix
  expect_true(is.matrix(res[[2]])) # erp
  expect_true(is.matrix(res[[3]])) # ersp
  expect_true(is.matrix(res[[4]])) # p-values

  # correlations computed for all condition?
  expect_equal(nrow(res[[1]]), length(unique(my_erpdata[,2])), length(unique(my_erspdata[,2])))

  # credible correlation and p values (values ranging from -1 to 1)
  expect_true(all(res[[1]] > -1 & res[[1]] < 1))
  expect_true(all(res[[4]] > -1 & res[[4]] < 1))

})


#res <- erp_ersp_cor(my_erpdata, electrode = e, time_erp = t, my_erspdata, frequency = f)

# correlations computed for all condition?


#run tests
#devtools::test()
