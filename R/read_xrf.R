
#' Read Olympus Vanta XRF files
#'
#' The standard Olympus Vanta file presents all elemental concentrations in ppm, and
#' all errors as 1 standard deviation.
#'
#' @param path The location of the file
#' @param extra_columns extra columns from the original file to include in the output
#'
#' @return A data.frame
#' @export
#'
#' @examples
#' read_olympus_vanta(system.file("xrf_files/olympus_vanta_test.csv", package = "paleoxrf"))
#'
read_olympus_vanta <- function(path, extra_columns = "info") {
  # read second line as column names
  . <- NULL; rm(.) # CMD hack
  oly_colnames <- readr::read_csv(path,
                                  skip = 1, n_max = 1, col_names = FALSE,
                                  col_types = readr::cols(.default = readr::col_character())) %>%
    t() %>% .[, 1, drop = TRUE] %>% unname()
  # replace last blank col name
  oly_colnames[is.na(oly_colnames)] <- "no_col_name"

  # read in csv
  oly <- readr::read_csv(path, col_names = oly_colnames, skip = 2,
                  col_types = readr::cols(
                    .default = readr::col_guess(),
                    `Instrument Serial Num` = readr::col_character(),
                    Date = readr::col_date(),
                    Time = readr::col_time(),
                    `Method Name` = readr::col_character(),
                    `Test Label` = readr::col_character(),
                    `User Factor Name` = readr::col_character(),
                    `Collimation Status` = readr::col_character(),
                    Units = readr::col_character(),
                    info = readr::col_character(),
                    no_col_name = readr::col_skip()
                  ))

  # add instrument information
  oly$xrf_info <- paste("Olympus Vanta", oly$`Instrument Serial Num`, oly$`Method Name`)

  # select relevant columns
  oly <- oly %>%
    select(.data$xrf_info, date = .data$Date, time = .data$Time, reading = .data$`Reading #`,
           label = .data$`Test Label`, one_of(extra_columns), units = .data$Units,
           ends_with("Concentration"), ends_with("Error 1s"))

  # change suffixes on column names
  colnames(oly) <- colnames(oly) %>%
    gsub("\\s*Concentration$", "", .) %>%
    gsub("\\s*Error 1s", "_sd", .)

  # return df
  oly
}
