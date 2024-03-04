source(file.path(getwd(), "R/run_lintr_check.R"))

output_file_name <- "empty_file.json"
r_result <- run_lintr_check(path_in = file.path(getwd(), "tests/empty_file"), prepare_for_sonar_qube = TRUE, output_file_name = output_file_name)
r_result
testthat::expect_equal(nrow(r_result), 0)
testthat::expect_equal(
  jsonlite::read_json("tests/perfect_code_expected_result.json"),
  jsonlite::read_json(output_file_name)
)

output_file_name <- "perfect_code.json"
r_result <- run_lintr_check(path_in = file.path(getwd(), "tests/perfect_code"), prepare_for_sonar_qube = TRUE, output_file_name = output_file_name)
r_result
testthat::expect_equal(nrow(r_result), 0)
testthat::expect_equal(
  jsonlite::read_json("tests/perfect_code_expected_result.json"),
  jsonlite::read_json(output_file_name)
)

output_file_name <- "one_mistake.json"
r_result <- run_lintr_check(path_in = file.path(getwd(), "tests/one_mistake"), prepare_for_sonar_qube = TRUE, output_file_name = output_file_name)
testthat::expect_equal(nrow(r_result), 1)
testthat::expect_equal(
  jsonlite::read_json("tests/one_mistake_expected_result.json"),
  jsonlite::read_json(output_file_name)
)
