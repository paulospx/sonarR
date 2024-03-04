#' lintr/sonar qube
#
#' to easily detect security vulnerabilities in your code via lintr and/or SonarQube
#' this is a function named 'run_lintr_check' that lints your code
#' produces a JSON file which contains the linting issues of your code and which can be loaded into SonarQube
#'
#' You can learn more about sonarR authoring:
#'
#'  -https://github.com/paulospx/sonarR
#'
run_lintr_check <- function(path_in = ".", exclusions_in = NULL, mapping = NULL, prepare_for_sonar_qube = FALSE, output_file_name = NULL, allow_with = TRUE) {

  lintr_in <- data.table::as.data.table(lintr::lint_dir(path = path_in, exclusions = exclusions_in, pattern = ".R"))

  if (is.null(mapping)) {
    mapping <- read_lintr_mapping()
  }
  check_lintr_mapping(mapping)
  mapping <- data.table::data.table(mapping)[ , .(linter, type, effortMinutes, severity, ruleId)]

  lintr_out <-
    merge(
      lintr_in,
      mapping,
      by = "linter",
      all.x = TRUE,
      suffixes = c("_linter_own", "")
    )
  if (allow_with) {
    lintr_out <- lintr_out[linter != "object_usage_linter", ]
  }
  lintr_out[is.na(type), type := "CODE_SMELL"][is.na(effortMinutes), effortMinutes := 10][is.na(severity), severity := "INFO"][is.na(ruleId), ruleId := "rule999"]

  lintr_out[, engineId := "test"]
  # startLine and endLine always the same from line_number
  # startColumn always 0, endColumn length of line unless empty then 1
  lintr_out[, startLine := line_number][, endLine := line_number][, startColum := 0][, endColumn := nchar(line)][endColumn == 0, endColumn := 1]

  if (prepare_for_sonar_qube && !is.null(output_file_name)) {

    result <- list(
      issues =
        vctrs::data_frame(
          engineId = lintr_out[, engineId],
          ruleId = lintr_out[, ruleId],
          severity = lintr_out[, severity],
          type = lintr_out[, type],
          primaryLocation = vctrs::data_frame(
            message = lintr_out[, message],
            filePath = lintr_out[, filename],
            textRange = lintr_out[, .(startLine, endLine, startColum, endColumn)]
          ),
          effortMinutes = lintr_out[, effortMinutes]
        )
    )

    sonar_qube_json <- jsonlite::toJSON(result, pretty = TRUE)

    base::write(sonar_qube_json, output_file_name)

  }

  lintr_out

}

read_lintr_mapping <- function(allow_with = TRUE) {
  data.table::data.table(read.table(
    text = "                linter          type effortMinutes severity ruleId
              absolute_path_linter    CODE_SMELL             5    MINOR  rule1
             any_duplicated_linter    CODE_SMELL             5    MINOR  rule2
                  any_is_na_linter    CODE_SMELL             5    MINOR  rule3
                 assignment_linter    CODE_SMELL             5    MINOR  rule4
                   backport_linter    CODE_SMELL             5    MINOR  rule5
         boolean_arithmetic_linter    CODE_SMELL             5    MINOR  rule6
                      brace_linter    CODE_SMELL             5    MINOR  rule7
               class_equals_linter    CODE_SMELL             5    MINOR  rule8
               closed_curly_linter VULNERABILITY             5    MINOR  rule9
                     commas_linter    CODE_SMELL             5    MINOR rule10
             commented_code_linter    CODE_SMELL             5    MINOR rule11
          condition_message_linter    CODE_SMELL             5    MINOR rule12
              conjunct_test_linter    CODE_SMELL             5    MINOR rule13
      consecutive_assertion_linter    CODE_SMELL             5    MINOR rule14
      consecutive_stopifnot_linter VULNERABILITY             5    MINOR rule15
                  cyclocomp_linter    CODE_SMELL             5    MINOR rule16
         duplicate_argument_linter           BUG             5    MINOR rule17
           empty_assignment_linter    CODE_SMELL             5    MINOR rule18
                  equals_na_linter           BUG             5    MINOR rule19
          expect_comparison_linter    CODE_SMELL             5    MINOR rule20
           expect_identical_linter    CODE_SMELL             5    MINOR rule21
              expect_length_linter    CODE_SMELL             5    MINOR rule22
               expect_named_linter    CODE_SMELL             5    MINOR rule23
                 expect_not_linter    CODE_SMELL             5    MINOR rule24
                expect_null_linter    CODE_SMELL             5    MINOR rule25
            expect_s3_class_linter    CODE_SMELL             5    MINOR rule26
            expect_s4_class_linter    CODE_SMELL             5    MINOR rule27
          expect_true_false_linter    CODE_SMELL             5    MINOR rule28
                expect_type_linter    CODE_SMELL             5    MINOR rule29
        extraction_operator_linter    CODE_SMELL             5    MINOR rule30
                fixed_regex_linter    CODE_SMELL             5    MINOR rule31
             for_loop_index_linter    CODE_SMELL             5    MINOR rule32
          function_argument_linter    CODE_SMELL             5    MINOR rule33
  function_left_parentheses_linter    CODE_SMELL             5    MINOR rule34
            function_return_linter    CODE_SMELL             5    MINOR rule35
              ifelse_censor_linter    CODE_SMELL             5    MINOR rule36
        implicit_assignment_linter    CODE_SMELL             5    MINOR rule37
           implicit_integer_linter    CODE_SMELL             5    MINOR rule38
                indentation_linter    CODE_SMELL             5    MINOR rule39
               infix_spaces_linter    CODE_SMELL             5    MINOR rule40
              inner_combine_linter    CODE_SMELL             5    MINOR rule41
                 is_numeric_linter    CODE_SMELL             5    MINOR rule42
                    lengths_linter    CODE_SMELL             5    MINOR rule43
                line_length_linter    CODE_SMELL             5    MINOR rule44
           literal_coercion_linter    CODE_SMELL             5    MINOR rule45
               matrix_apply_linter    CODE_SMELL             5    MINOR rule46
           missing_argument_linter           BUG             5    MINOR rule47
            missing_package_linter           BUG             5    MINOR rule48
                  namespace_linter           BUG             5    MINOR rule49
              nested_ifelse_linter    CODE_SMELL             5    MINOR rule50
                     no_tab_linter VULNERABILITY             5    MINOR rule51
           nonportable_path_linter    CODE_SMELL             5    MINOR rule52
       numeric_leading_zero_linter    CODE_SMELL             5    MINOR rule53
              object_length_linter    CODE_SMELL             5    MINOR rule54
                object_name_linter    CODE_SMELL             5    MINOR rule55
               object_usage_linter           BUG             5    MINOR rule56
                 open_curly_linter VULNERABILITY             5    MINOR rule57
             outer_negation_linter    CODE_SMELL             5    MINOR rule58
              package_hooks_linter           BUG             5    MINOR rule59
                 paren_body_linter    CODE_SMELL             5    MINOR rule60
                paren_brace_linter VULNERABILITY             5    MINOR rule61
                      paste_linter    CODE_SMELL             5    MINOR rule62
                  pipe_call_linter    CODE_SMELL             5    MINOR rule63
          pipe_continuation_linter    CODE_SMELL             5    MINOR rule64
                     quotes_linter    CODE_SMELL             5    MINOR rule65
           redundant_equals_linter           BUG             5    MINOR rule66
           redundant_ifelse_linter    CODE_SMELL             5    MINOR rule67
               regex_subset_linter    CODE_SMELL             5    MINOR rule68
       routine_registration_linter    CODE_SMELL             5    MINOR rule69
                  semicolon_linter    CODE_SMELL             5    MINOR rule70
       semicolon_terminator_linter VULNERABILITY             5    MINOR rule71
                        seq_linter    CODE_SMELL             5    MINOR rule72
              single_quotes_linter VULNERABILITY             5    MINOR rule73
                       sort_linter    CODE_SMELL             5    MINOR rule74
              spaces_inside_linter    CODE_SMELL             5    MINOR rule75
    spaces_left_parentheses_linter    CODE_SMELL             5    MINOR rule76
                    sprintf_linter           BUG             5    MINOR rule77
            string_boundary_linter    CODE_SMELL             5    MINOR rule78
         strings_as_factors_linter    CODE_SMELL             5    MINOR rule79
                system_file_linter    CODE_SMELL             5    MINOR rule80
             T_and_F_symbol_linter    CODE_SMELL             5    MINOR rule81
               todo_comment_linter    CODE_SMELL             5    MINOR rule82
       trailing_blank_lines_linter    CODE_SMELL             5    MINOR rule83
        trailing_whitespace_linter    CODE_SMELL             5    MINOR rule84
       undesirable_function_linter    CODE_SMELL             5    MINOR rule85
       undesirable_operator_linter    CODE_SMELL             5    MINOR rule86
  unnecessary_concatenation_linter    CODE_SMELL             5    MINOR rule87
         unnecessary_lambda_linter    CODE_SMELL             5    MINOR rule88
      unnecessary_nested_if_linter    CODE_SMELL             5    MINOR rule89
    unnecessary_placeholder_linter    CODE_SMELL             5    MINOR rule90
     unneeded_concatenation_linter VULNERABILITY             5    MINOR rule91
           unreachable_code_linter    CODE_SMELL             5    MINOR rule92
              unused_import_linter           BUG             5    MINOR rule93
               vector_logic_linter    CODE_SMELL             5    MINOR rule94
                 whitespace_linter    CODE_SMELL             5    MINOR rule95
                  yoda_test_linter    CODE_SMELL             5    MINOR rule96", header = TRUE)
  )
}

check_lintr_mapping <- function(mapping) {

  if (!"data.frame" %in% class(mapping)) {
    base::message(paste0("Error. Your lintr-SonarQube mapping is not a data.frame."))
    stop(call. = FALSE)
  }
  missing_columns <- base::setdiff(c("linter", "type", "effortMinutes", "severity", "ruleId"), names(mapping))
  if (length(missing_columns) > 0) {
    base::message(paste0("Error. The following columns missing in your lintr-SonarQube mapping: ", paste(missing_columns, collapse = ", ")))
    stop(call. = FALSE)
  }

  check_ok <- TRUE
  invalid_sonar_type <- base::setdiff(mapping[, type], c("BUG",
                                                         "VULNERABILITY",
                                                         "CODE_SMELL"))
  if (length(invalid_sonar_type) > 0) {
    base::message(paste0("Error. Invalid entries for type in your lintr-SonarQube mapping: ", paste(invalid_sonar_type, collapse = ", ")))
    check_ok <- FALSE
  }

  invalid_sonar_effort <- base::suppressWarnings({
    mapping$effortMinutes[is.na(as.numeric(mapping[, effortMinutes]))]
  })
  if (length(invalid_sonar_effort) > 0) {
    base::message(paste0("Error. Invalid entries for effortMinutes in your lintr-SonarQube mapping: ", paste(invalid_sonar_effort, collapse = ", ")))
    check_ok <- FALSE
  }

  invalid_sonar_severity <- base::setdiff(mapping[, severity], c("BLOCKER",
                                                                 "CRITICAL",
                                                                 "MAJOR",
                                                                 "MINOR",
                                                                 "INFO"))
  if (length(invalid_sonar_severity) > 0) {
    base::message(paste0("Error. Invalid entries for severity in your lintr-SonarQube mapping: ", paste(invalid_sonar_severity, collapse = ", ")))
    check_ok <- FALSE
  }

  if (!check_ok) {
    stop(call. = FALSE)
  }
}
