
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
#' read_panalytical_txt(system.file("xrf_files/panalytical_test.txt", package = "paleoxrf"))
#'
read_olympus_vanta <- function(path, extra_columns = "info") {
  # read second line as column names
  . <- NULL; rm(.) # CMD hack
  oly_colnames <- readr::read_csv(
      path,
      skip = 1, n_max = 1, col_names = FALSE,
      col_types = readr::cols(.default = readr::col_character())
    ) %>%
    t() %>%
    .[, 1, drop = TRUE] %>%
    unname()
  # replace last blank col name
  oly_colnames[is.na(oly_colnames)] <- "no_col_name"

  # read in csv
  oly <- readr::read_csv(
    path,
    col_names = oly_colnames,
    skip = 2,
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
    )
  )

  # add instrument information
  oly$xrf_info <- paste("Olympus Vanta", oly$`Instrument Serial Num`, oly$`Method Name`)

  # select relevant columns
  oly <- oly %>%
    select(
      "xrf_info",
      date = "Date",
      time = "Time",
      reading = "Reading #",
      label = "Test Label",
      one_of(extra_columns),
      units = "Units",
      ends_with("Concentration"),
      ends_with("Error 1s")
    )

  # change suffixes on column names
  colnames(oly) <- colnames(oly) %>%
    gsub("\\s*Concentration$", "_conc", .) %>%
    gsub("\\s*Error 1s", "_sd", .)

  # return df
  oly
}

#' @rdname read_olympus_vanta
#' @export
read_panalytical_txt <- function(path) {
  # this line is the messy part...getting the column names from the
  # multi-line header and pasting them together

  # this reads the first two lines of the file as text
  col_names <- readr::read_tsv(
    path,
    col_types = readr::cols(.default = readr::col_character()),
    col_names = FALSE,
    skip = 0,
    n_max = 2
  ) %>%
    t() %>%
    as.data.frame(stringsAsFactors = FALSE) %>%
    tidyr::fill("V1", .direction = "down") %>%
    purrr::transpose() %>%
    purrr::map_chr(function(x) paste(stats::na.omit(unlist(x)), collapse = "_"))

  # the last column is a blank one, not whatever the last element was
  col_names[length(col_names)] <- "blank_column"

  # this uses the column names we just generated to read the file
  xrf_raw <- readr::read_tsv(
    path,
    col_names = col_names,
    skip = 2,
    col_types = readr::cols(
      .default = readr::col_character(),
      blank_column = readr::col_skip()
    )
  )

  # tidy columns
  xrf_raw <- xrf_raw %>%
    dplyr::mutate_at(dplyr::vars(ends_with("_C"), ends_with("_Iraw"), ends_with("_Inet")), as.numeric) %>%
    dplyr::mutate_at(dplyr::vars("Time"), lubridate::dmy_hms) %>%
    dplyr::select(-"Seq", -"Nr", -"Pos") %>%
    dplyr::rename(ident = "Ident", date_time = "Time")

  # change suffixes on column names
  colnames(xrf_raw) <- colnames(xrf_raw) %>%
    stringr::str_replace("_Unit$", "_unit") %>%
    stringr::str_replace("_C$", "_conc")

  xrf_raw
}
