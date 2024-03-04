calculate_fwd_vol_funds <- function(weight_in,
                                    volatility_in,
                                    correlation_in,
                                    method_in = "Regional based") {

  weight_table <- data.table::dcast.data.table(weight_in,
                                               Region ~ Fund,
                                               value.var = "Weight")

  # for each vector of fund and each vector kY year (k=1,2,3,4,5,6)
  # calculate a value via main formula
  weight_vectors <- weight_table[base::match(rownames(correlation_in),
                                             weight_table$Region),
                                 -"Region"]
  sdev <- volatility_in[base::match(rownames(correlation_in),
                                    volatility_in$Region),
                        -"Region"]

  fwd_vol_funds <- do.call(rbind,
                           lapply(weight_vectors,
                                  FUN = function(weight_vector) {

                                    do.call(
                                      cbind,
                                      lapply(sdev,
                                             FUN = function(sdev_vector) {
                                               w <- weight_vector * sdev_vector
                                               # main formula
                                               sqrt(
                                                 w %*% correlation_in  %*% w
                                               )
                                             })
                                    )
                                  }))

  fwd_vol_funds <- as.data.frame(fwd_vol_funds)
  # make sure the old cols are 1:6 Y
  colnames(fwd_vol_funds) <- c(paste0(c(1:5), "Y"), "mean3Y_5Y")
  fwd_vol_funds$Fund <- colnames(weight_vectors)
  fwd_vol_funds$Methodology <- method_in

  fwd_vol_funds
}
