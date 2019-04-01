
#' Read Olympus Vanta, Panalytical XRF files
#'
#' The standard Olympus Vanta file presents all elemental concentrations in ppm, and
#' all errors as 1 standard deviation. The default Panalytical output format
#' specifies the unit for each measurement, and does not consider error. These
#' functions do their best to keep all available information in the output,
#' standardizing the columns xrf_info, date_time, and sample_id. Concentration
#' columns end in `conc`, standard deviation columns end in `sd`, and count
#' columns end in `Iraw` or `Inet`.
#'
#' @param path The location of the file
#' @param sample_id_col The column containing the sample identifier
#' @param tz Timezone of specified times
#'
#' @return A data.frame
#' @export
#'
#' @examples
#' read_olympus_vanta(system.file("xrf_files/olympus_vanta_test.csv", package = "paleoxrf"))
#' read_panalytical_txt(system.file("xrf_files/panalytical_test.txt", package = "paleoxrf"))
#'
read_olympus_vanta <- function(path, sample_id_col = "info", tz = "UTC") {
  sample_id_col <- enquo(sample_id_col)

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
      .default = readr::col_character(),
      Date = readr::col_date(),
      Time = readr::col_time(),
      no_col_name = readr::col_skip()
    )
  )

  oly$xrf_info <- "Olympus Vanta"
  oly$date_time <- lubridate::force_tz(lubridate::as_datetime(oly$Date, tz = "UTC") + oly$Time, tz)
  oly$sample_id <- dplyr::pull(oly, !!sample_id_col)

  oly <- oly %>%
    dplyr::mutate_at(dplyr::vars(ends_with("Concentration"), ends_with("Error 1s")), as.numeric) %>%
    dplyr::select("xrf_info", "date_time", "sample_id", dplyr::everything())

  # change suffixes on column names
  colnames(oly) <- colnames(oly) %>%
    stringr::str_replace("\\s*Concentration$", "_conc") %>%
    stringr::str_replace("\\s*Error 1s", "_sd")

  # return df
  oly
}

#' @rdname read_olympus_vanta
#' @export
read_panalytical_txt <- function(path, sample_id_col = "Ident", tz = "UTC") {
  sample_id_col <- enquo(sample_id_col)

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

  xrf_raw$xrf_info <- "Panalytical Epsilon 1"
  xrf_raw$sample_id <- dplyr::pull(xrf_raw, !!sample_id_col)
  xrf_raw$date_time <- lubridate::force_tz(lubridate::dmy_hms(xrf_raw$Time, tz = "UTC"), tz)

  # tidy columns
  xrf_raw <- xrf_raw %>%
    dplyr::filter(!stringr::str_detect(.data$Seq, "Ave|SDev")) %>%
    dplyr::mutate_at(dplyr::vars(ends_with("_C"), ends_with("_Iraw"), ends_with("_Inet")), as.numeric) %>%
    dplyr::select("xrf_info", "date_time", "sample_id", dplyr::everything())

  # change suffixes on column names
  colnames(xrf_raw) <- colnames(xrf_raw) %>%
    stringr::str_replace("_Unit$", "_unit") %>%
    stringr::str_replace("_C$", "_conc")

  xrf_raw
}
