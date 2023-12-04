# sonarR

R Linting Scanner for SonarQube.

This package adds support for the R language into SonarQube. It uses the output from the `lintr` tool, which is processed by the plugin and uploaded into the SonarQube server. The plugin reports issues found by `lintr` (by processing its output) and has planned features such as syntax highlighting, code coverage, and code statistics.

Linting Rules: 
-  https://lintr.r-lib.org/reference/linters.html


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
   Rscript -e "install.packages('data.table')"
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

| Linter                             | Issue Type | Effort Minutes | Severity |
| ---------------------------------- | ---------- | -------------- | -------- |
| `object_usage_linter`              | CODE_SMELL | 5              | MINOR    |
| `absolute_path_linter`             | CODE_SMELL | 5              | MINOR    |
| `nonportable_path_linter`          | CODE_SMELL | 5              | MINOR    |
| `pipe_continuation_linter`         | CODE_SMELL | 5              | MINOR    |
| `assignment_linter`                | CODE_SMELL | 5              | MINOR    |
| `camel_case_linter`                | CODE_SMELL | 5              | MINOR    |
| `closed_curly_linter`              | CODE_SMELL | 5              | MINOR    |
| `commas_linter`                    | CODE_SMELL | 5              | MINOR    |
| `commented_code_linter`            | CODE_SMELL | 5              | MINOR    |
| `cyclocomp_linter`                 | CODE_SMELL | 5              | MINOR    |
| `equals_na_linter`                 | CODE_SMELL | 5              | MINOR    |
| `extraction_operator_linter`       | CODE_SMELL | 5              | MINOR    |
| `function_left_parentheses_linter` | CODE_SMELL | 5              | MINOR    |
| `function_left_parentheses_linter` | CODE_SMELL | 5              | MINOR    |
| `implicit_integer_linter`          | CODE_SMELL | 5              | MINOR    |
| `infix_spaces_linter`              | CODE_SMELL | 5              | MINOR    |
| `line_length_linter`               | CODE_SMELL | 5              | MINOR    |
| `no_tab_linter`                    | CODE_SMELL | 5              | MINOR    |
| `object_length_linter`             | CODE_SMELL | 5              | MINOR    |
| `object_name_linter`               | CODE_SMELL | 5              | MINOR    |
| `open_curly_linter`                | CODE_SMELL | 5              | MINOR    |
| `paren_brace_linter`               | CODE_SMELL | 5              | MINOR    |
| `semicolon_terminator_linter`      | CODE_SMELL | 5              | MINOR    |
| `seq_linter`                       | CODE_SMELL | 5              | MINOR    |
| `single_quotes_linter`             | CODE_SMELL | 5              | MINOR    |
| `spaces_inside_linter`             | CODE_SMELL | 5              | MINOR    |
| `spaces_left_parentheses_linter`   | CODE_SMELL | 5              | MINOR    |
| `todo_comment_linter`              | CODE_SMELL | 5              | MINOR    |
| `trailing_blank_lines_linter`      | CODE_SMELL | 5              | MINOR    |
| `trailing_whitespace_linter`       | CODE_SMELL | 5              | MINOR    |
| `T_and_F_symbol_linter`            | CODE_SMELL | 5              | MINOR    |
| `undesirable_function_linter`      | CODE_SMELL | 5              | MINOR    |
| `undesirable_operator_linter`      | CODE_SMELL | 5              | MINOR    |
| `unneeded_concatenation_linter`    | CODE_SMELL | 5              | MINOR    |
| other non specified in the table   | CODE_SMELL | 5              | MINOR    |



3. You can now import this JSON report into SonarQube for monitoring your R project's software quality.

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
