
pocmaj <- mudata::pocmaj

pocmaj$sample_id <- paste(gsub("-", "15-", tolower(pocmaj$core)), pocmaj$depth)

pocmaj_raw <- tibble::as_tibble(pocmaj[c("sample_id", "Ca", "Ti", "V")])

devtools::use_data(pocmaj_raw, overwrite = TRUE)
