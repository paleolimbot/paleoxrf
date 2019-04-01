
<!-- README.md is generated from README.Rmd. Please edit that file -->
paleoxrf
========

[![Travis build status](https://travis-ci.org/paleolimbot/paleoxrf.svg?branch=master)](https://travis-ci.org/paleolimbot/paleoxrf)

The goal of paleoxrf is to simplify reading data from Acadia's paleoenvironmental X-Ray Fluorescence laboratory.

Installation
------------

You can install **paleoxrf** from GitHub using the following code:

``` r
# install.packages("remotes")
remotes::install_github("paleolimbot/paleoxrf")
```

If all is well, you should be able to load the package:

``` r
library(paleoxrf)
```

The examples below use **dplyr** to manipulate the output of the read functions.

``` r
library(dplyr)
```

Reading XRF Data
----------------

The package provides a few functions to read XRF data output from several types of machines, such as the [Olympus Vanta](http://www.olympus-ims.com/en/vanta/). The function reads the raw output of the machines, rather than a "cleaned up" version from other spreadsheet software.

``` r
test_file_oly <- system.file(
  "xrf_files/olympus_vanta_test.csv", 
  package = "paleoxrf"
)

read_olympus_vanta(test_file_oly) %>%
  select(date_time, sample_id, ends_with("_conc"))
#> # A tibble: 16 x 38
#>    date_time           sample_id Mg_conc Al_conc Si_conc P_conc S_conc
#>    <dttm>              <chr>       <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1 2017-08-17 09:31:54 <NA>           NA      NA      NA     NA     NA
#>  2 2017-08-17 09:37:10 srm2781         0    8089   28813  16283  12764
#>  3 2017-08-17 11:17:07 oreas 22d       0       0  453164      0      0
#>  4 2017-08-17 11:19:22 oreas 25a       0  104451  227308    549    571
#>  5 2017-08-17 11:21:33 oreas 45e   14254   80686  199553    504    545
#>  6 2017-08-17 11:24:25 sio2 bla…       0       0  411490      0      0
#>  7 2017-08-17 11:26:57 oreas 45d       0   88201  215181    541    506
#>  8 2017-08-17 11:29:00 oreas 50…   16489   65884  264257    870  11349
#>  9 2017-08-17 11:35:08 oreas 903       0   66288  320528   1091   2695
#> 10 2017-08-17 11:38:20 oreas 24c   27308   76011  226228   1747      0
#> 11 2017-08-17 11:42:27 oreas 902   20624   53361  273023    598  10959
#> 12 2017-08-17 11:44:22 oreas 904       0   69717  321072    886    679
#> 13 2017-08-17 11:47:10 oreas 50…   13111   69115  266789   1032  11906
#> 14 2017-08-17 11:49:38 oreas 24b   15233   83512  294387    640   1510
#> 15 2017-08-17 11:51:43 oreas 50…   12128   72752  277049   1172   4759
#> 16 2017-08-17 11:54:34 oreas 50…    8993   68590  267792    970   7810
#> # … with 31 more variables: K_conc <dbl>, Ca_conc <dbl>, Ti_conc <dbl>,
#> #   V_conc <dbl>, Cr_conc <dbl>, Mn_conc <dbl>, Fe_conc <dbl>,
#> #   Co_conc <dbl>, Ni_conc <dbl>, Cu_conc <dbl>, Zn_conc <dbl>,
#> #   As_conc <dbl>, Se_conc <dbl>, Rb_conc <dbl>, Sr_conc <dbl>,
#> #   Y_conc <dbl>, Zr_conc <dbl>, Nb_conc <dbl>, Mo_conc <dbl>,
#> #   Ag_conc <dbl>, Cd_conc <dbl>, Sn_conc <dbl>, Sb_conc <dbl>,
#> #   W_conc <dbl>, Au_conc <dbl>, Hg_conc <dbl>, Pb_conc <dbl>,
#> #   Bi_conc <dbl>, Th_conc <dbl>, U_conc <dbl>, LE_conc <dbl>
```

``` r
test_file_pan <- system.file(
  "xrf_files/panalytical_test.txt", 
  package = "paleoxrf"
)

read_panalytical_txt(test_file_pan) %>%
  select(date_time, sample_id, ends_with("_conc"))
#> # A tibble: 24 x 43
#>    date_time           sample_id Na_conc Mg_conc Al_conc Si_conc P_conc
#>    <dttm>              <chr>       <dbl>   <dbl>   <dbl>   <dbl>  <dbl>
#>  1 2019-01-10 14:45:47 poc-18-1…  4.07e3   1959.  40729.  1.17e3  1178.
#>  2 2019-01-10 14:51:41 poc-18-1…  3.74e3    746.  34002.  1.56e3  1064.
#>  3 2019-01-10 14:56:32 poc-18-1…  3.97e3   1505.  41365.  1.87e3  1117.
#>  4 2019-01-10 15:02:26 poc-18-1…  3.16e3    787.  40286.  1.57e3   932.
#>  5 2019-01-10 15:08:10 poc-18-1…  3.92e3   2237.  48516.  2.24e3  1199.
#>  6 2019-01-10 15:14:01 poc-18-1…  3.18e3   1959.  41693.  8.78e2  1031.
#>  7 2019-01-10 15:19:13 poc-18-1…  1.63e3  -5664. -17729   6.48e1  1048.
#>  8 2019-01-10 15:24:47 poc-18-1… -7.94e0   6900. -64085. -1.69e4  1018.
#>  9 2019-01-10 15:29:36 poc-18-1…  3.98e3   1983.  40705.  1.16e3  1131.
#> 10 2019-01-10 15:34:26 poc-18-1…  4.11e3   2004.  42909.  2.02e3  1220.
#> # … with 14 more rows, and 36 more variables: S_conc <dbl>, Cl_conc <dbl>,
#> #   K_conc <dbl>, Ca_conc <dbl>, Sc_conc <dbl>, Ti_conc <dbl>,
#> #   V_conc <dbl>, Cr_conc <dbl>, Mn_conc <dbl>, Fe_conc <dbl>,
#> #   Co_conc <dbl>, Ni_conc <dbl>, Cu_conc <dbl>, Zn_conc <dbl>,
#> #   Ga_conc <dbl>, As_conc <dbl>, Rb_conc <dbl>, Sr_conc <dbl>,
#> #   Y_conc <dbl>, Zr_conc <dbl>, Nb_conc <dbl>, Mo_conc <dbl>,
#> #   Cd_conc <dbl>, In_conc <dbl>, Sn_conc <dbl>, Sb_conc <dbl>,
#> #   Te_conc <dbl>, Ba_conc <dbl>, La_conc <dbl>, Ce_conc <dbl>,
#> #   Ta_conc <dbl>, W_conc <dbl>, Pb_conc <dbl>, Bi_conc <dbl>,
#> #   Th_conc <dbl>, U_conc <dbl>
```
