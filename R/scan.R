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
  lintr_in <- data.table::as.data.table(lintr::lint_dir(dir))

  mapping <-
    read.table(
      text = "linter	type	effortMinutes	severity	softwareQuality	ruleId
indentation_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule1
absolute_path_linter	CODE_SMELL	5	WARNING	RELIABILITY	rule2
nonportable_path_linter	CODE_SMELL	5	WARNING	MAINTAINABILITY	rule3
pipe_continuation_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule4
assignment_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule5
camel_case_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule6
closed_curly_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule7
commas_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule8
commented_code_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule9
cyclocomp_linter	CODE_SMELL	5	MAJOR	RELIABILITY	rule10
equals_na_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule11
extraction_operator_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule12
function_left_parentheses_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule13
implicit_integer_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule14
infix_spaces_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule15
line_length_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule16
no_tab_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule17
object_length_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule18
object_name_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule19
open_curly_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule20
paren_brace_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule21
semicolon_terminator_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule22
seq_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule23
single_quotes_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule24
spaces_inside_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule25
spaces_left_parentheses_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule26
todo_comment_linter	CODE_SMELL	5	MINOR	RELIABILITY	rule27
trailing_blank_lines_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule28
trailing_whitespace_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule29
T_and_F_symbol_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule30
undesirable_function_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule31
undesirable_operator_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule32
unneeded_concatenation_linter	CODE_SMELL	5	MINOR	MAINTAINABILITY	rule33
yoda_test_linter	CODE_SMELL	5	MINOR	SECURITY	rule105
any_duplicated_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule35
any_is_na_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule36
backport_linter	BUG	10	MEDIUM	SECURITY	rule37
boolean_arithmetic_linter	BUG	10	MEDIUM	SECURITY	rule38
brace_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule39
class_equals_linter	BUG	10	MEDIUM	SECURITY	rule40
condition_message_linter	BUG	10	MEDIUM	SECURITY	rule41
conjunct_test_linter	BUG	10	MEDIUM	SECURITY	rule42
consecutive_assertion_linter	BUG	10	MEDIUM	SECURITY	rule43
duplicate_argument_linter	BUG	10	MEDIUM	SECURITY	rule44
empty_assignment_linter	BUG	10	MEDIUM	SECURITY	rule45
expect_comparison_linter	BUG	10	MEDIUM	SECURITY	rule46
expect_identical_linter	BUG	10	MEDIUM	SECURITY	rule47
expect_length_linter	BUG	10	MEDIUM	SECURITY	rule48
expect_named_linter	BUG	10	MEDIUM	SECURITY	rule49
expect_not_linter	BUG	10	MEDIUM	SECURITY	rule50
expect_null_linter	BUG	10	MEDIUM	SECURITY	rule51
expect_s3_class_linter	BUG	10	MEDIUM	SECURITY	rule52
expect_s4_class_linter	BUG	10	MEDIUM	SECURITY	rule53
expect_true_false_linter	BUG	10	MEDIUM	SECURITY	rule54
expect_type_linter	BUG	10	MEDIUM	SECURITY	rule55
fixed_regex_linter	BUG	10	MEDIUM	SECURITY	rule56
for_loop_index_linter	BUG	10	MEDIUM	SECURITY	rule57
function_argument_linter	BUG	10	MEDIUM	SECURITY	rule58
function_return_linter	BUG	10	MEDIUM	SECURITY	rule59
if_not_else_linter	BUG	10	MEDIUM	SECURITY	rule60
ifelse_censor_linter	BUG	10	MEDIUM	SECURITY	rule61
implicit_assignment_linter	BUG	10	MEDIUM	SECURITY	rule62
indentation_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule63
inner_combine_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule64
is_numeric_linter	BUG	10	MEDIUM	SECURITY	rule65
keyword_quote_linter	BUG	10	MEDIUM	SECURITY	rule66
length_levels_linter	BUG	10	MEDIUM	SECURITY	rule67
length_test_linter	BUG	10	MEDIUM	SECURITY	rule68
lengths_linter	BUG	10	MEDIUM	SECURITY	rule69
library_call_linter	BUG	10	MEDIUM	SECURITY	rule70
literal_coercion_linter	BUG	10	MEDIUM	SECURITY	rule71
matrix_apply_linter	BUG	10	MEDIUM	SECURITY	rule72
missing_argument_linter	BUG	10	MEDIUM	SECURITY	rule73
missing_package_linter	BUG	10	MEDIUM	SECURITY	rule74
namespace_linter	BUG	10	MEDIUM	SECURITY	rule75
nested_ifelse_linter	BUG	10	MEDIUM	SECURITY	rule76
numeric_leading_zero_linter	BUG	10	MEDIUM	SECURITY	rule77
outer_negation_linter	BUG	10	MEDIUM	SECURITY	rule78
package_hooks_linter	BUG	10	MEDIUM	SECURITY	rule79
paren_body_linter	BUG	10	MEDIUM	SECURITY	rule80
paste_linter	BUG	10	MEDIUM	SECURITY	rule81
pipe_call_linter	BUG	10	MEDIUM	SECURITY	rule82
pipe_consistency_linter	BUG	10	MEDIUM	SECURITY	rule83
quotes_linter	BUG	10	MEDIUM	SECURITY	rule84
redundant_equals_linter	BUG	10	MEDIUM	SECURITY	rule85
redundant_ifelse_linter	BUG	10	MEDIUM	SECURITY	rule86
regex_subset_linter	BUG	10	MEDIUM	SECURITY	rule87
repeat_linter	BUG	10	MEDIUM	SECURITY	rule88
routine_registration_linter	BUG	10	MEDIUM	SECURITY	rule89
scalar_in_linter	BUG	10	MEDIUM	SECURITY	rule90
semicolon_linter	BUG	10	MEDIUM	SECURITY	rule91
sort_linter	BUG	10	MEDIUM	SECURITY	rule92
sprintf_linter	BUG	10	MEDIUM	SECURITY	rule93
string_boundary_linter	BUG	10	MEDIUM	SECURITY	rule94
strings_as_factors_linter	BUG	10	MEDIUM	SECURITY	rule95
system_file_linter	BUG	10	MEDIUM	SECURITY	rule96
unnecessary_concatenation_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule97
unnecessary_lambda_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule98
unnecessary_nested_if_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule99
unnecessary_placeholder_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule100
unreachable_code_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule101
unused_import_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule102
vector_logic_linter	BUG	10	MEDIUM	SECURITY	rule103
whitespace_linter	BUG	10	MEDIUM	MAINTAINABILITY	rule104
other_no_specified_in_the_table	BUG	10	MEDIUM	MAINTAINABILITY	rule34",
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
