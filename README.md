# sonarR

R Linting Scanner for SonarQube.

This package adds support for the R language into SonarQube. It uses output from the `lintr` tool, which is processed by the plugin and uploaded into the SonarQube server. The plugin reports issues found by `lintr` (by processing its output) and has planned features such as syntax highlighting, code coverage, and code statistics.

Linting helps maintain code quality and consistency, making it an essential part of any software development process.

## Features

- Scan R code for linting issues.
- Generate a JSON report compatible with SonarQube.
- Easy integration with your R projects DevOps pipelines

## Table of Contents

- [Installation](https://chat.openai.com/c/fa4a5101-e9db-4f60-b66c-4c234b377455#installation)
- [Usage](https://chat.openai.com/c/fa4a5101-e9db-4f60-b66c-4c234b377455#usage)
- [Configuration](https://chat.openai.com/c/fa4a5101-e9db-4f60-b66c-4c234b377455#configuration)
- [Contributing](https://chat.openai.com/c/fa4a5101-e9db-4f60-b66c-4c234b377455#contributing)
- [License](https://chat.openai.com/c/fa4a5101-e9db-4f60-b66c-4c234b377455#license)

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
   # Install dependencies script
   ```

## Usage

1. Run the scanner on your R project directory.

   ```bash
   sonarScan("R", "linting_report.json")
   ```

2. The tool will scan your R code in the `/R` folder and generate a JSON report named `linting_report.json`.

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
