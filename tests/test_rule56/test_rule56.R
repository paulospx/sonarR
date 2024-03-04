add_new_columns <- function(run_specs) {
  dplyr::mutate(run_specs, new = LMMPointer)
  run_specs[, new := LMMPointer]
}
