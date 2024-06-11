#install.packages("jsonlite")
#install.packages("data.table")
#library(jsonlite)
#library(data.table)

sonarScan1_3 <- function(dir = "R", outFile = "./sample-project/scan_002.json") {
  print("Scanning...")
  lintr_in <- data.table::as.data.table(lintr::lint_dir(dir))
  lintr_in[, startLine := line_number][, ruleId := linter][,description := message][, endLine := line_number][, startColum := 0][, endColumn := nchar(line)][endColumn == 0, endColumn := 1]

  rules_data <- fromJSON("./R/rules.json")
  rules_table <- as.data.table(json_data)
  rules_table[, linter := name][, id := linter]


  lintr_aux <- list(
    issues =
      vctrs::data_frame(
        ruleId = lintr_in[, linter],
        primaryLocation = vctrs::data_frame(
          message = lintr_in[, message],
          filePath = lintr_in[, filename],
          textRange = lintr_in[, .(startLine, endLine, startColum, endColumn)]
        )
      )
  )

  sonar_scan_result <- list(rules = rules_data, issues = lintr_aux$issues)
  pretty_json_data <-toJSON(sonar_scan_result, pretty = TRUE, auto_unbox = TRUE)
  write(pretty_json_data, outFile)
}

sonarScan1_3(dir = "sample-project", outFile = "/sample-project/scan-result.json")
