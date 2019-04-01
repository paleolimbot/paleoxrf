context("test-read_xrf")

test_that("read vanta function output is stable", {

  vanta <- read_olympus_vanta(system.file("xrf_files/olympus_vanta_test.csv", package = "paleoxrf"))
  expect_is(vanta, "data.frame")
  expect_is(vanta$xrf_info, "character")
  expect_is(vanta$sample_id, "character")
  expect_is(vanta$date_time, "POSIXct")
  vanta %>% dplyr::select(dplyr::ends_with("_conc")) %>% purrr::map_lgl(is.numeric) %>% all() %>% expect_true()
  vanta %>% dplyr::select(dplyr::ends_with("_sd")) %>% purrr::map_lgl(is.numeric) %>% all() %>% expect_true()

  expect_setequal(
    colnames(vanta),
    c("xrf_info", "date_time", "sample_id", "Instrument Serial Num",
      "Reading #", "Date", "Time", "Method Name", "User Factor Name",
      "Test Label", "Collimation Status", "Latitude", "Longitude",
      "Units", "Mg Compound", "Mg Compound Level", "Mg Compound Error",
      "Mg_conc", "Mg_sd", "Al Compound", "Al Compound Level", "Al Compound Error",
      "Al_conc", "Al_sd", "Si Compound", "Si Compound Level", "Si Compound Error",
      "Si_conc", "Si_sd", "P Compound", "P Compound Level", "P Compound Error",
      "P_conc", "P_sd", "S Compound", "S Compound Level", "S Compound Error",
      "S_conc", "S_sd", "K Compound", "K Compound Level", "K Compound Error",
      "K_conc", "K_sd", "Ca Compound", "Ca Compound Level", "Ca Compound Error",
      "Ca_conc", "Ca_sd", "Ti Compound", "Ti Compound Level", "Ti Compound Error",
      "Ti_conc", "Ti_sd", "V Compound", "V Compound Level", "V Compound Error",
      "V_conc", "V_sd", "Cr Compound", "Cr Compound Level", "Cr Compound Error",
      "Cr_conc", "Cr_sd", "Mn Compound", "Mn Compound Level", "Mn Compound Error",
      "Mn_conc", "Mn_sd", "Fe Compound", "Fe Compound Level", "Fe Compound Error",
      "Fe_conc", "Fe_sd", "Co Compound", "Co Compound Level", "Co Compound Error",
      "Co_conc", "Co_sd", "Ni Compound", "Ni Compound Level", "Ni Compound Error",
      "Ni_conc", "Ni_sd", "Cu Compound", "Cu Compound Level", "Cu Compound Error",
      "Cu_conc", "Cu_sd", "Zn Compound", "Zn Compound Level", "Zn Compound Error",
      "Zn_conc", "Zn_sd", "As Compound", "As Compound Level", "As Compound Error",
      "As_conc", "As_sd", "Se Compound", "Se Compound Level", "Se Compound Error",
      "Se_conc", "Se_sd", "Rb Compound", "Rb Compound Level", "Rb Compound Error",
      "Rb_conc", "Rb_sd", "Sr Compound", "Sr Compound Level", "Sr Compound Error",
      "Sr_conc", "Sr_sd", "Y Compound", "Y Compound Level", "Y Compound Error",
      "Y_conc", "Y_sd", "Zr Compound", "Zr Compound Level", "Zr Compound Error",
      "Zr_conc", "Zr_sd", "Nb Compound", "Nb Compound Level", "Nb Compound Error",
      "Nb_conc", "Nb_sd", "Mo Compound", "Mo Compound Level", "Mo Compound Error",
      "Mo_conc", "Mo_sd", "Ag Compound", "Ag Compound Level", "Ag Compound Error",
      "Ag_conc", "Ag_sd", "Cd Compound", "Cd Compound Level", "Cd Compound Error",
      "Cd_conc", "Cd_sd", "Sn Compound", "Sn Compound Level", "Sn Compound Error",
      "Sn_conc", "Sn_sd", "Sb Compound", "Sb Compound Level", "Sb Compound Error",
      "Sb_conc", "Sb_sd", "W Compound", "W Compound Level", "W Compound Error",
      "W_conc", "W_sd", "Au Compound", "Au Compound Level", "Au Compound Error",
      "Au_conc", "Au_sd", "Hg Compound", "Hg Compound Level", "Hg Compound Error",
      "Hg_conc", "Hg_sd", "Pb Compound", "Pb Compound Level", "Pb Compound Error",
      "Pb_conc", "Pb_sd", "Bi Compound", "Bi Compound Level", "Bi Compound Error",
      "Bi_conc", "Bi_sd", "Th Compound", "Th Compound Level", "Th Compound Error",
      "Th_conc", "Th_sd", "U Compound", "U Compound Level", "U Compound Error",
      "U_conc", "U_sd", "LE Compound", "LE Compound Level", "LE Compound Error",
      "LE_conc", "LE_sd", "info")
  )

  # row order and column alignment
  expect_identical(
    vanta$Pb_conc,
    c(NA, 192, 0, 25, 0, 0, 14, 29, 12, 0, 11, 11, 35, 23, 22, 26)
  )

})

test_that("read panalytical function output is stable", {

  pan <- read_panalytical_txt(system.file("xrf_files/panalytical_test.txt", package = "paleoxrf"))
  expect_is(pan, "tbl_df")
  expect_is(pan$xrf_info, "character")
  expect_is(pan$sample_id, "character")
  expect_is(pan$date_time, "POSIXct")
  pan %>% dplyr::select(dplyr::ends_with("_conc")) %>% purrr::map_lgl(is.numeric) %>% all() %>% expect_true()
  pan %>% dplyr::select(dplyr::ends_with("_Inet")) %>% purrr::map_lgl(is.numeric) %>% all() %>% expect_true()
  pan %>% dplyr::select(dplyr::ends_with("_Iraw")) %>% purrr::map_lgl(is.numeric) %>% all() %>% expect_true()

  expect_setequal(
    colnames(pan),
    c("xrf_info", "date_time", "sample_id", "Nr", "Ident", "Seq",
      "Time", "Pos", "Na_Iraw", "Na_Inet", "Na_conc", "Na_unit", "Mg_Iraw",
      "Mg_Inet", "Mg_conc", "Mg_unit", "Al_Iraw", "Al_Inet", "Al_conc",
      "Al_unit", "Si_Iraw", "Si_Inet", "Si_conc", "Si_unit", "P_Iraw",
      "P_Inet", "P_conc", "P_unit", "S_Iraw", "S_Inet", "S_conc", "S_unit",
      "Cl_Iraw", "Cl_Inet", "Cl_conc", "Cl_unit", "K_Iraw", "K_Inet",
      "K_conc", "K_unit", "Ca_Iraw", "Ca_Inet", "Ca_conc", "Ca_unit",
      "Sc_Iraw", "Sc_Inet", "Sc_conc", "Sc_unit", "Ti_Iraw", "Ti_Inet",
      "Ti_conc", "Ti_unit", "V_Iraw", "V_Inet", "V_conc", "V_unit",
      "Cr_Iraw", "Cr_Inet", "Cr_conc", "Cr_unit", "Mn_Iraw", "Mn_Inet",
      "Mn_conc", "Mn_unit", "Fe_Iraw", "Fe_Inet", "Fe_conc", "Fe_unit",
      "Co_Iraw", "Co_Inet", "Co_conc", "Co_unit", "Ni_Iraw", "Ni_Inet",
      "Ni_conc", "Ni_unit", "Cu_Iraw", "Cu_Inet", "Cu_conc", "Cu_unit",
      "Zn_Iraw", "Zn_Inet", "Zn_conc", "Zn_unit", "Ga_Iraw", "Ga_Inet",
      "Ga_conc", "Ga_unit", "As_Iraw", "As_Inet", "As_conc", "As_unit",
      "Rb_Iraw", "Rb_Inet", "Rb_conc", "Rb_unit", "Sr_Iraw", "Sr_Inet",
      "Sr_conc", "Sr_unit", "Y_Iraw", "Y_Inet", "Y_conc", "Y_unit",
      "Zr_Iraw", "Zr_Inet", "Zr_conc", "Zr_unit", "Nb_Iraw", "Nb_Inet",
      "Nb_conc", "Nb_unit", "Mo_Iraw", "Mo_Inet", "Mo_conc", "Mo_unit",
      "Cd_Iraw", "Cd_Inet", "Cd_conc", "Cd_unit", "In_Iraw", "In_Inet",
      "In_conc", "In_unit", "Sn_Iraw", "Sn_Inet", "Sn_conc", "Sn_unit",
      "Sb_Iraw", "Sb_Inet", "Sb_conc", "Sb_unit", "Te_Iraw", "Te_Inet",
      "Te_conc", "Te_unit", "Ba_Iraw", "Ba_Inet", "Ba_conc", "Ba_unit",
      "La_Iraw", "La_Inet", "La_conc", "La_unit", "Ce_Iraw", "Ce_Inet",
      "Ce_conc", "Ce_unit", "Ta_Iraw", "Ta_Inet", "Ta_conc", "Ta_unit",
      "W_Iraw", "W_Inet", "W_conc", "W_unit", "Pb_Iraw", "Pb_Inet",
      "Pb_conc", "Pb_unit", "Bi_Iraw", "Bi_Inet", "Bi_conc", "Bi_unit",
      "Th_Iraw", "Th_Inet", "Th_conc", "Th_unit", "U_Iraw", "U_Inet",
      "U_conc", "U_unit")
  )

  # checks row ordering and column alignment
  expect_identical(
    pan$Pb_conc,
    c(73.875, 61.952, 82.966, 55.606, 94.041, 43.551, 80.548, 85.885,
      44.492, 36.459, 45.371, 102.599, 60.61, 67.475, 49.301, 43.999,
      56.302, 40.48, 20.399, 42.088, 57.161, 86.223, 98.057, 78.651
    )
  )
})



