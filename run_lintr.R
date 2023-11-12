# sonarR
#
# this is a function named 'sonarScan' that lints your code located in the
# 'dir' folder and produces a JSON result file named in 'outFile'
# The output will contain the linting issues of your code that can be loaded
# into SonarQube
#h
# You can learn more about sonarR authoring:
#
#  -https://github.com/paulospx/sonarR
#

sonarScan <- function(dir = "R", outFile = "result_json_output.json") {
  lintr_in <- data.table::as.data.table(lintr::lint_dir("R"))

  mapping <-
    read.table(
      text = "linter       type effortMinutes severity ruleId
 1:              object_usage_linter CODE_SMELL             5    MINOR rule11
 2:             absolute_path_linter CODE_SMELL             5    MINOR  rule2
 3:          nonportable_path_linter CODE_SMELL             5    MINOR  rule3
 4:         pipe_continuation_linter CODE_SMELL             5    MINOR  rule4
 5:                assignment_linter CODE_SMELL             5    MINOR  rule5
 6:                camel_case_linter CODE_SMELL             5    MINOR  rule6
 7:              closed_curly_linter CODE_SMELL             5    MINOR  rule7
 8:                    commas_linter CODE_SMELL             5    MINOR  rule8
 9:            commented_code_linter CODE_SMELL             5    MINOR  rule9
10:                 cyclocomp_linter CODE_SMELL             5    MINOR rule10
11:                 equals_na_linter        BUG             5    MINOR  rule1
12:       extraction_operator_linter CODE_SMELL             5    MINOR rule12
13: function_left_parentheses_linter CODE_SMELL             5    MINOR rule13
14: function_left_parentheses_linter CODE_SMELL             5    MINOR rule14
15:          implicit_integer_linter CODE_SMELL             5    MINOR rule15
16:              infix_spaces_linter CODE_SMELL             5    MINOR rule16
17:               line_length_linter CODE_SMELL             5    MINOR rule17
18:                    no_tab_linter CODE_SMELL             5    MINOR rule18
19:             object_length_linter CODE_SMELL             5    MINOR rule19
20:               object_name_linter CODE_SMELL             5    MINOR rule20
21:                open_curly_linter CODE_SMELL             5    MINOR rule21
22:               paren_brace_linter CODE_SMELL             5    MINOR rule22
23:      semicolon_terminator_linter CODE_SMELL             5    MINOR rule23
24:                       seq_linter CODE_SMELL             5    MINOR rule24
25:             single_quotes_linter CODE_SMELL             5    MINOR rule25
26:             spaces_inside_linter CODE_SMELL             5    MINOR rule26
27:   spaces_left_parentheses_linter CODE_SMELL             5    MINOR rule27
28:              todo_comment_linter CODE_SMELL             5    MINOR rule28
29:      trailing_blank_lines_linter CODE_SMELL             5    MINOR rule29
30:       trailing_whitespace_linter CODE_SMELL             5    MINOR rule30
31:            T_and_F_symbol_linter CODE_SMELL             5    MINOR rule31
32:      undesirable_function_linter CODE_SMELL             5    MINOR rule32
33:      undesirable_operator_linter CODE_SMELL             5    MINOR rule33
34:    unneeded_concatenation_linter CODE_SMELL             5    MINOR rule34
35: other_non_specified_in_the_table CODE_SMELL             5    MINOR rule35",
      header = TRUE
    )

  lintr_out <-
    merge(
      lintr_in,
      mapping,
      by = "linter",
      all.x = TRUE,
      suffixes = c("_lint_own", "")
    )

  lintr_out[is.na(type), type := "CODE_SMELL"][is.na(effortMinutes), effortMinutes := 10][is.na(severity), severity := "INFO"][is.na(ruleId), ruleId := "rule999"]

  lintr_out[, engineId := "test"]
  # startLine and endLine always the same from line_number
  # startColumn always 0, endColumn length of line unless empty then 1
  lintr_out[, startLine := line_number][, endLine := line_number][, startColum := 0][, endColumn := nchar(line)][endColumn == 0, endColumn := 1]

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

  json_data <- jsonlite::toJSON(result, pretty = TRUE)
  write(json_data, outFile)
}
