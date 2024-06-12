# sonarR

R Linting Scanner for SonarQube.

This package adds support for the R language into SonarQube. It uses the output from the `lintr` tool, which is processed by the plugin and uploaded into the SonarQube server. The plugin reports issues found by `lintr` (by processing its output) and has planned features such as syntax highlighting, code coverage, and code statistics.

Linting Rules: 
-  https://lintr.r-lib.org/reference/linters.html

Format of the JSON produced:
- https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/importing-external-issues/generic-issue-import-format/

Linting helps maintain code quality and consistency, making it an essential part of any software development process.

## Features

- Scan R code for linting issues.
- Generate a JSON report compatible with SonarQube.
- Easy integration with your R project's DevOps pipelines

## Table of Contents

- [Installation](#Installation)
- [Usage](#Usage)
- [Configuration](#Configuration)
- [Contributing](#Contributing)
- [License](#License)

## Installation

1. Clone this repository or download the source code.

   ```bash
   git clone https://github.com/paulospx/sonarR.git
   ```

2. Navigate to the project directory.

   ```bash
   cd sonarR
   ```

3. Install the required dependencies.

   ```bash
   Rscript -e 'install.packages("data.table")'
   Rscript -e 'install.packages("lintr")'
   Rscript -e 'install.packages("devtools")'
   Rscript -e 'install.packages("roxygen2")'
   ```

## Usage

1. Run the scanner on your R project directory.

   ```bash
   sonarR::scan(dir="R",outFile = "result.json")
   ```

2. The tool will scan your R code in the `/R` folder and generate a JSON report named `linting_report.json`.

It uses the following mapping to adjust the data to SonarQube. 
The mapping table generates the issue type, effort and severity required to ingest the information into SonarQube.

| linter                           | type       | effortMinutes | severity | softwareQuality | ruleId  |
| -------------------------------- | ---------- | ------------- | -------- | --------------- | ------- |
| indentation_linter               | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule1   |
| absolute_path_linter             | CODE_SMELL | 5             | HIGH  | RELIABILITY     | rule2   |
| nonportable_path_linter          | CODE_SMELL | 5             | HIGH  | MAINTAINABILITY | rule3   |
| pipe_continuation_linter         | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule4   |
| assignment_linter                | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule5   |
| camel_case_linter                | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule6   |
| closed_curly_linter              | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule7   |
| commas_linter                    | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule8   |
| commented_code_linter            | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule9   |
| cyclocomp_linter                 | CODE_SMELL | 5             | HIGH    | RELIABILITY     | rule10  |
| equals_na_linter                 | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule11  |
| extraction_operator_linter       | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule12  |
| function_left_parentheses_linter | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule13  |
| implicit_integer_linter          | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule14  |
| infix_spaces_linter              | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule15  |
| line_length_linter               | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule16  |
| no_tab_linter                    | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule17  |
| object_length_linter             | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule18  |
| object_name_linter               | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule19  |
| open_curly_linter                | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule20  |
| paren_brace_linter               | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule21  |
| semicolon_terminator_linter      | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule22  |
| seq_linter                       | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule23  |
| single_quotes_linter             | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule24  |
| spaces_inside_linter             | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule25  |
| spaces_left_parentheses_linter   | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule26  |
| todo_comment_linter              | CODE_SMELL | 5             | LOW    | RELIABILITY     | rule27  |
| trailing_blank_lines_linter      | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule28  |
| trailing_whitespace_linter       | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule29  |
| T_and_F_symbol_linter            | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule30  |
| undesirable_function_linter      | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule31  |
| undesirable_operator_linter      | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule32  |
| unneeded_concatenation_linter    | CODE_SMELL | 5             | LOW    | MAINTAINABILITY | rule33  |
| yoda_test_linter                 | CODE_SMELL | 5             | LOW    | SECURITY        | rule105 |
| any_duplicated_linter            | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule35  |
| any_is_na_linter                 | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule36  |
| backport_linter                  | BUG        | 10            | MEDIUM   | SECURITY        | rule37  |
| boolean_arithmetic_linter        | BUG        | 10            | MEDIUM   | SECURITY        | rule38  |
| brace_linter                     | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule39  |
| class_equals_linter              | BUG        | 10            | MEDIUM   | SECURITY        | rule40  |
| condition_message_linter         | BUG        | 10            | MEDIUM   | SECURITY        | rule41  |
| conjunct_test_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule42  |
| consecutive_assertion_linter     | BUG        | 10            | MEDIUM   | SECURITY        | rule43  |
| duplicate_argument_linter        | BUG        | 10            | MEDIUM   | SECURITY        | rule44  |
| empty_assignment_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule45  |
| expect_comparison_linter         | BUG        | 10            | MEDIUM   | SECURITY        | rule46  |
| expect_identical_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule47  |
| expect_length_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule48  |
| expect_named_linter              | BUG        | 10            | MEDIUM   | SECURITY        | rule49  |
| expect_not_linter                | BUG        | 10            | MEDIUM   | SECURITY        | rule50  |
| expect_null_linter               | BUG        | 10            | MEDIUM   | SECURITY        | rule51  |
| expect_s3_class_linter           | BUG        | 10            | MEDIUM   | SECURITY        | rule52  |
| expect_s4_class_linter           | BUG        | 10            | MEDIUM   | SECURITY        | rule53  |
| expect_true_false_linter         | BUG        | 10            | MEDIUM   | SECURITY        | rule54  |
| expect_type_linter               | BUG        | 10            | MEDIUM   | SECURITY        | rule55  |
| fixed_regex_linter               | BUG        | 10            | MEDIUM   | SECURITY        | rule56  |
| for_loop_index_linter            | BUG        | 10            | MEDIUM   | SECURITY        | rule57  |
| function_argument_linter         | BUG        | 10            | MEDIUM   | SECURITY        | rule58  |
| function_return_linter           | BUG        | 10            | MEDIUM   | SECURITY        | rule59  |
| if_not_else_linter               | BUG        | 10            | MEDIUM   | SECURITY        | rule60  |
| ifelse_censor_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule61  |
| implicit_assignment_linter       | BUG        | 10            | MEDIUM   | SECURITY        | rule62  |
| indentation_linter               | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule63  |
| inner_combine_linter             | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule64  |
| is_numeric_linter                | BUG        | 10            | MEDIUM   | SECURITY        | rule65  |
| keyword_quote_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule66  |
| length_levels_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule67  |
| length_test_linter               | BUG        | 10            | MEDIUM   | SECURITY        | rule68  |
| lengths_linter                   | BUG        | 10            | MEDIUM   | SECURITY        | rule69  |
| library_call_linter              | BUG        | 10            | MEDIUM   | SECURITY        | rule70  |
| literal_coercion_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule71  |
| matrix_apply_linter              | BUG        | 10            | MEDIUM   | SECURITY        | rule72  |
| missing_argument_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule73  |
| missing_package_linter           | BUG        | 10            | MEDIUM   | SECURITY        | rule74  |
| namespace_linter                 | BUG        | 10            | MEDIUM   | SECURITY        | rule75  |
| nested_ifelse_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule76  |
| numeric_leading_zero_linter      | BUG        | 10            | MEDIUM   | SECURITY        | rule77  |
| outer_negation_linter            | BUG        | 10            | MEDIUM   | SECURITY        | rule78  |
| package_hooks_linter             | BUG        | 10            | MEDIUM   | SECURITY        | rule79  |
| paren_body_linter                | BUG        | 10            | MEDIUM   | SECURITY        | rule80  |
| paste_linter                     | BUG        | 10            | MEDIUM   | SECURITY        | rule81  |
| pipe_call_linter                 | BUG        | 10            | MEDIUM   | SECURITY        | rule82  |
| pipe_consistency_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule83  |
| quotes_linter                    | BUG        | 10            | MEDIUM   | SECURITY        | rule84  |
| redundant_equals_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule85  |
| redundant_ifelse_linter          | BUG        | 10            | MEDIUM   | SECURITY        | rule86  |
| regex_subset_linter              | BUG        | 10            | MEDIUM   | SECURITY        | rule87  |
| repeat_linter                    | BUG        | 10            | MEDIUM   | SECURITY        | rule88  |
| routine_registration_linter      | BUG        | 10            | MEDIUM   | SECURITY        | rule89  |
| scalar_in_linter                 | BUG        | 10            | MEDIUM   | SECURITY        | rule90  |
| semicolon_linter                 | BUG        | 10            | MEDIUM   | SECURITY        | rule91  |
| sort_linter                      | BUG        | 10            | MEDIUM   | SECURITY        | rule92  |
| sprintf_linter                   | BUG        | 10            | MEDIUM   | SECURITY        | rule93  |
| string_boundary_linter           | BUG        | 10            | MEDIUM   | SECURITY        | rule94  |
| strings_as_factors_linter        | BUG        | 10            | MEDIUM   | SECURITY        | rule95  |
| system_file_linter               | BUG        | 10            | MEDIUM   | SECURITY        | rule96  |
| unnecessary_concatenation_linter | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule97  |
| unnecessary_lambda_linter        | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule98  |
| unnecessary_nested_if_linter     | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule99  |
| unnecessary_placeholder_linter   | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule100 |
| unreachable_code_linter          | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule101 |
| unused_import_linter             | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule102 |
| vector_logic_linter              | BUG        | 10            | MEDIUM   | SECURITY        | rule103 |
| whitespace_linter                | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule104 |
| other_no_specified_in_the_table  | BUG        | 10            | MEDIUM   | MAINTAINABILITY | rule34  |


3. You can now import this JSON report into SonarQube to monitor your R project's software quality.

## Configuration

You can configure the scanner by modifying the `config.json` file. You can customize options such as linting rules, file extensions, and more.

Example `config.json`:

```json
{
  "linting_rules": ["camel_case", "no_tabs", "max_line_length"],
  "file_extensions": [".R", ".Rmd"],
  "output_file": "linting_report.json"
}
```

## Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository on GitHub.
2. Clone your fork locally.
3. Create a new branch for your feature or bug fix.
4. Make your changes and commit them.
5. Push your changes to your fork on GitHub.
6. Create a pull request from your fork to this repository.

Please ensure that your code follows the linting rules specified in the `config.json` file.

## Issues

If you encounter any issues with the linting scanner, please check the [issue tracker](https://github.com/paulospx/sonarR/issues) to see if your issue has already been reported. If not, please [create a new issue](https://github.com/paulospx/sonarR/issues/new) and provide as much detail as possible.

## License

This project is licensed under the MIT License - see the [LICENSE](https://chat.openai.com/c/LICENSE) file for details.
