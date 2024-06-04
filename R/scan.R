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
      text = "linter	 type	effortMinutes	severity	ruleId
object_usage_linter	CODE_SMELL	5	MINOR	rule1
absolute_path_linter	CODE_SMELL	5	WARNING	rule2
nonportable_path_linter	CODE_SMELL	5	WARNING	rule3
pipe_continuation_linter	CODE_SMELL	5	MINOR	rule4
assignment_linter	CODE_SMELL	5	MINOR	rule5
camel_case_linter	CODE_SMELL	5	MINOR	rule6
closed_curly_linter	CODE_SMELL	5	MINOR	rule7
commas_linter	CODE_SMELL	5	MINOR	rule8
commented_code_linter	CODE_SMELL	5	MINOR	rule9
cyclocomp_linter	CODE_SMELL	5	MAJOR	rule10
equals_na_linter	CODE_SMELL	5	MINOR	rule11
extraction_operator_linter	CODE_SMELL	5	MINOR	rule12
function_left_parentheses_linter	CODE_SMELL	5	MINOR	rule13
implicit_integer_linter	CODE_SMELL	5	MINOR	rule14
infix_spaces_linter	CODE_SMELL	5	MINOR	rule15
line_length_linter	CODE_SMELL	5	MINOR	rule16
no_tab_linter	CODE_SMELL	5	MINOR	rule17
object_length_linter	CODE_SMELL	5	MINOR	rule18
object_name_linter	CODE_SMELL	5	MINOR	rule19
open_curly_linter	CODE_SMELL	5	MINOR	rule20
paren_brace_linter	CODE_SMELL	5	MINOR	rule21
semicolon_terminator_linter	CODE_SMELL	5	MINOR	rule22
seq_linter	CODE_SMELL	5	MINOR	rule23
single_quotes_linter	CODE_SMELL	5	MINOR	rule24
spaces_inside_linter	CODE_SMELL	5	MINOR	rule25
spaces_left_parentheses_linter	CODE_SMELL	5	MINOR	rule26
todo_comment_linter	CODE_SMELL	5	MINOR	rule27
trailing_blank_lines_linter	CODE_SMELL	5	MINOR	rule28
trailing_whitespace_linter	CODE_SMELL	5	MINOR	rule29
T_and_F_symbol_linter	CODE_SMELL	5	MINOR	rule30
undesirable_function_linter	CODE_SMELL	5	MINOR	rule31
undesirable_operator_linter	CODE_SMELL	5	MINOR	rule32
unneeded_concatenation_linter	CODE_SMELL	5	MINOR	rule33
yoda_test_linter	CODE_SMELL	5	MINOR	rule105
any_duplicated_linter	BUG	5	MINOR	rule35
any_is_na_linter	BUG	5	MINOR	rule36
backport_linter	BUG	5	WARNING	rule37
boolean_arithmetic_linter	BUG	5	MINOR	rule38
brace_linter	BUG	5	MINOR	rule39
class_equals_linter	BUG	5	MINOR	rule40
condition_message_linter	BUG	5	MINOR	rule41
conjunct_test_linter	BUG	5	MINOR	rule42
consecutive_assertion_linter	BUG	5	MINOR	rule43
duplicate_argument_linter	BUG	5	MINOR	rule44
empty_assignment_linter	BUG	5	MINOR	rule45
expect_comparison_linter	BUG	5	MINOR	rule46
expect_identical_linter	BUG	5	MINOR	rule47
expect_length_linter	BUG	5	MINOR	rule48
expect_named_linter	BUG	5	MINOR	rule49
expect_not_linter	BUG	5	MINOR	rule50
expect_null_linter	BUG	5	MINOR	rule51
expect_s3_class_linter	BUG	5	MINOR	rule52
expect_s4_class_linter	BUG	5	MINOR	rule53
expect_true_false_linter	BUG	5	MINOR	rule54
expect_type_linter	BUG	5	MINOR	rule55
fixed_regex_linter	BUG	5	MINOR	rule56
for_loop_index_linter	BUG	5	MINOR	rule57
function_argument_linter	BUG	5	MINOR	rule58
function_return_linter	BUG	5	MINOR	rule59
if_not_else_linter	BUG	5	MINOR	rule60
ifelse_censor_linter	BUG	5	MINOR	rule61
implicit_assignment_linter	BUG	5	MINOR	rule62
indentation_linter	BUG	5	MINOR	rule63
inner_combine_linter	BUG	5	MINOR	rule64
is_numeric_linter	BUG	5	MINOR	rule65
keyword_quote_linter	BUG	5	MINOR	rule66
length_levels_linter	BUG	5	MINOR	rule67
length_test_linter	BUG	5	MINOR	rule68
lengths_linter	BUG	5	MINOR	rule69
library_call_linter	BUG	5	MINOR	rule70
literal_coercion_linter	BUG	5	MINOR	rule71
matrix_apply_linter	BUG	5	MINOR	rule72
missing_argument_linter	BUG	5	MINOR	rule73
missing_package_linter	BUG	5	MINOR	rule74
namespace_linter	BUG	5	MINOR	rule75
nested_ifelse_linter	BUG	5	MINOR	rule76
numeric_leading_zero_linter	BUG	5	MINOR	rule77
outer_negation_linter	BUG	5	MINOR	rule78
package_hooks_linter	BUG	5	MINOR	rule79
paren_body_linter	BUG	5	MINOR	rule80
paste_linter	BUG	5	MINOR	rule81
pipe_call_linter	BUG	5	MINOR	rule82
pipe_consistency_linter	BUG	5	MINOR	rule83
quotes_linter	BUG	5	MINOR	rule84
redundant_equals_linter	BUG	5	MINOR	rule85
redundant_ifelse_linter	BUG	5	MINOR	rule86
regex_subset_linter	BUG	5	MINOR	rule87
repeat_linter	BUG	5	MINOR	rule88
routine_registration_linter	BUG	5	MINOR	rule89
scalar_in_linter	BUG	5	MINOR	rule90
semicolon_linter	BUG	5	MINOR	rule91
sort_linter	BUG	5	MINOR	rule92
sprintf_linter	BUG	5	MINOR	rule93
string_boundary_linter	BUG	5	MINOR	rule94
strings_as_factors_linter	BUG	5	MINOR	rule95
system_file_linter	BUG	5	MINOR	rule96
unnecessary_concatenation_linter	BUG	5	MINOR	rule97
unnecessary_lambda_linter	BUG	5	MINOR	rule98
unnecessary_nested_if_linter	BUG	5	MINOR	rule99
unnecessary_placeholder_linter	BUG	5	MINOR	rule100
unreachable_code_linter	BUG	5	MAJOR	rule101
unused_import_linter	BUG	5	WARNING	rule102
vector_logic_linter	BUG	5	MINOR	rule103
whitespace_linter	BUG	5	MINOR	rule104
other_no_specified_in_the_table	BUG	5	MINOR	rule34",
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
