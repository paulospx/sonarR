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
run_lintr_check <- function(path_in = ".", exclusions_in = NULL, mapping = NULL, prepare_for_sonar_qube = FALSE, output_file_name = NULL) {

  lintr_in <- data.table::as.data.table(lintr::lint_dir(path = path_in, exclusions = exclusions_in, pattern = ".R"))

  if (is.null(mapping)) {
    mapping <- read.table(
      text = "           linter       type effortMinutes severity ruleId
              object_usage_linter CODE_SMELL             5    MINOR rule11
             absolute_path_linter CODE_SMELL             5    MINOR  rule2
          nonportable_path_linter CODE_SMELL             5    MINOR  rule3
         pipe_continuation_linter CODE_SMELL             5    MINOR  rule4
                assignment_linter CODE_SMELL             5    MINOR  rule5
                camel_case_linter CODE_SMELL             5    MINOR  rule6
              closed_curly_linter CODE_SMELL             5    MINOR  rule7
                    commas_linter CODE_SMELL             5    MINOR  rule8
            commented_code_linter CODE_SMELL             5    MINOR  rule9
                 cyclocomp_linter CODE_SMELL             5    MINOR rule10
                 equals_na_linter        BUG             5    MINOR  rule1
       extraction_operator_linter CODE_SMELL             5    MINOR rule12
 function_left_parentheses_linter CODE_SMELL             5    MINOR rule13
 function_left_parentheses_linter CODE_SMELL             5    MINOR rule14
          implicit_integer_linter CODE_SMELL             5    MINOR rule15
              infix_spaces_linter CODE_SMELL             5    MINOR rule16
               line_length_linter CODE_SMELL             5    MINOR rule17
                    no_tab_linter CODE_SMELL             5    MINOR rule18
             object_length_linter CODE_SMELL             5    MINOR rule19
               object_name_linter CODE_SMELL             5    MINOR rule20
                open_curly_linter CODE_SMELL             5    MINOR rule21
               paren_brace_linter CODE_SMELL             5    MINOR rule22
      semicolon_terminator_linter CODE_SMELL             5    MINOR rule23
                       seq_linter CODE_SMELL             5    MINOR rule24
             single_quotes_linter CODE_SMELL             5    MINOR rule25
             spaces_inside_linter CODE_SMELL             5    MINOR rule26
   spaces_left_parentheses_linter CODE_SMELL             5    MINOR rule27
              todo_comment_linter CODE_SMELL             5    MINOR rule28
      trailing_blank_lines_linter CODE_SMELL             5    MINOR rule29
       trailing_whitespace_linter CODE_SMELL             5    MINOR rule30
            T_and_F_symbol_linter CODE_SMELL             5    MINOR rule31
      undesirable_function_linter CODE_SMELL             5    MINOR rule32
      undesirable_operator_linter CODE_SMELL             5    MINOR rule33
    unneeded_concatenation_linter CODE_SMELL             5    MINOR rule34
 other_non_specified_in_the_table CODE_SMELL             5    MINOR rule35",    header = TRUE
    )
  }
  # TODO checks on mapping

  lintr_out <-
    merge(
      lintr_in,
      mapping,
      by = "linter",
      all.x = TRUE,
      suffixes = c("_linter_own", "")
    )

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
