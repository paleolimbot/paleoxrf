
<!-- README.md is generated from README.Rmd. Please edit that file -->
paleoxrf
========

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

Reading XRF Data
----------------

The package provides a few functions to read XRF data output from several types of machines, such as the [Olympus Vanta](http://www.olympus-ims.com/en/vanta/). The function reads the raw output of the machines, rather than a "cleaned up" version from other spreadsheet software.

``` r
test_file_oly <- system.file(
  "xrf_files/olympus_vanta_test.csv", 
  package = "paleoxrf"
)

read_olympus_vanta(test_file_oly)
#> # A tibble: 16 x 79
#>    xrf_info date       time  reading label info  units Mg_conc Al_conc
#>    <chr>    <date>     <tim>   <dbl> <chr> <chr> <chr>   <dbl>   <dbl>
#>  1 Olympus… 2017-08-17 09:31       1 1C    <NA>  ppm        NA      NA
#>  2 Olympus… 2017-08-17 09:37       2 2     srm2… ppm         0    8089
#>  3 Olympus… 2017-08-17 11:17      19 19    orea… ppm         0       0
#>  4 Olympus… 2017-08-17 11:19      20 20    orea… ppm         0  104451
#>  5 Olympus… 2017-08-17 11:21      21 21    orea… ppm     14254   80686
#>  6 Olympus… 2017-08-17 11:24      22 22    sio2… ppm         0       0
#>  7 Olympus… 2017-08-17 11:26      23 23    orea… ppm         0   88201
#>  8 Olympus… 2017-08-17 11:29      24 24    orea… ppm     16489   65884
#>  9 Olympus… 2017-08-17 11:35      25 25    orea… ppm         0   66288
#> 10 Olympus… 2017-08-17 11:38      26 26    orea… ppm     27308   76011
#> 11 Olympus… 2017-08-17 11:42      27 27    orea… ppm     20624   53361
#> 12 Olympus… 2017-08-17 11:44      28 28    orea… ppm         0   69717
#> 13 Olympus… 2017-08-17 11:47      29 29    orea… ppm     13111   69115
#> 14 Olympus… 2017-08-17 11:49      30 30    orea… ppm     15233   83512
#> 15 Olympus… 2017-08-17 11:51      31 31    orea… ppm     12128   72752
#> 16 Olympus… 2017-08-17 11:54      32 32    orea… ppm      8993   68590
#> # … with 70 more variables: Si_conc <dbl>, P_conc <dbl>, S_conc <dbl>,
#> #   K_conc <dbl>, Ca_conc <dbl>, Ti_conc <dbl>, V_conc <dbl>,
#> #   Cr_conc <dbl>, Mn_conc <dbl>, Fe_conc <dbl>, Co_conc <dbl>,
#> #   Ni_conc <dbl>, Cu_conc <dbl>, Zn_conc <dbl>, As_conc <dbl>,
#> #   Se_conc <dbl>, Rb_conc <dbl>, Sr_conc <dbl>, Y_conc <dbl>,
#> #   Zr_conc <dbl>, Nb_conc <dbl>, Mo_conc <dbl>, Ag_conc <dbl>,
#> #   Cd_conc <dbl>, Sn_conc <dbl>, Sb_conc <dbl>, W_conc <dbl>,
#> #   Au_conc <dbl>, Hg_conc <dbl>, Pb_conc <dbl>, Bi_conc <dbl>,
#> #   Th_conc <dbl>, U_conc <dbl>, LE_conc <dbl>, Mg_sd <dbl>, Al_sd <dbl>,
#> #   Si_sd <dbl>, P_sd <dbl>, S_sd <dbl>, K_sd <dbl>, Ca_sd <dbl>,
#> #   Ti_sd <dbl>, V_sd <dbl>, Cr_sd <dbl>, Mn_sd <dbl>, Fe_sd <dbl>,
#> #   Co_sd <dbl>, Ni_sd <dbl>, Cu_sd <dbl>, Zn_sd <dbl>, As_sd <dbl>,
#> #   Se_sd <dbl>, Rb_sd <dbl>, Sr_sd <dbl>, Y_sd <dbl>, Zr_sd <dbl>,
#> #   Nb_sd <dbl>, Mo_sd <dbl>, Ag_sd <dbl>, Cd_sd <dbl>, Sn_sd <dbl>,
#> #   Sb_sd <dbl>, W_sd <dbl>, Au_sd <dbl>, Hg_sd <dbl>, Pb_sd <dbl>,
#> #   Bi_sd <dbl>, Th_sd <dbl>, U_sd <dbl>, LE_sd <dbl>
```

``` r
test_file_pan <- system.file(
  "xrf_files/panalytical_test.txt", 
  package = "paleoxrf"
)

read_panalytical_txt(test_file_pan)
#> # A tibble: 26 x 166
#>    ident date_time           Na_Iraw Na_Inet Na_conc Na_unit Mg_Iraw
#>    <chr> <dttm>                <dbl>   <dbl>   <dbl> <chr>     <dbl>
#>  1 poc-… 2019-01-10 14:45:47   -5.86   -5.86  4.07e3 ppm        8.73
#>  2 poc-… 2019-01-10 14:51:41  -26.7   -26.7   3.74e3 ppm      -56.8 
#>  3 poc-… 2019-01-10 14:56:32  -12.1   -12.1   3.97e3 ppm      -15.8 
#>  4 poc-… 2019-01-10 15:02:26  -60.8   -60.8   3.16e3 ppm      -52.0 
#>  5 poc-… 2019-01-10 15:08:10  -14.3   -14.3   3.92e3 ppm       22.0 
#>  6 poc-… 2019-01-10 15:14:01  -64.0   -64.0   3.18e3 ppm        8.65
#>  7 poc-… 2019-01-10 15:19:13 -162.   -162.    1.63e3 ppm     -403.  
#>  8 poc-… 2019-01-10 15:24:47 -265.   -265.   -7.94e0 ppm      274.  
#>  9 poc-… 2019-01-10 15:29:36  -11.4   -11.4   3.98e3 ppm        9.63
#> 10 poc-… 2019-01-10 15:34:26   -3.63   -3.63  4.11e3 ppm       11.2 
#> # … with 16 more rows, and 159 more variables: Mg_Inet <dbl>,
#> #   Mg_conc <dbl>, Mg_unit <chr>, Al_Iraw <dbl>, Al_Inet <dbl>,
#> #   Al_conc <dbl>, Al_unit <chr>, Si_Iraw <dbl>, Si_Inet <dbl>,
#> #   Si_conc <dbl>, Si_unit <chr>, P_Iraw <dbl>, P_Inet <dbl>,
#> #   P_conc <dbl>, P_unit <chr>, S_Iraw <dbl>, S_Inet <dbl>, S_conc <dbl>,
#> #   S_unit <chr>, Cl_Iraw <dbl>, Cl_Inet <dbl>, Cl_conc <dbl>,
#> #   Cl_unit <chr>, K_Iraw <dbl>, K_Inet <dbl>, K_conc <dbl>, K_unit <chr>,
#> #   Ca_Iraw <dbl>, Ca_Inet <dbl>, Ca_conc <dbl>, Ca_unit <chr>,
#> #   Sc_Iraw <dbl>, Sc_Inet <dbl>, Sc_conc <dbl>, Sc_unit <chr>,
#> #   Ti_Iraw <dbl>, Ti_Inet <dbl>, Ti_conc <dbl>, Ti_unit <chr>,
#> #   V_Iraw <dbl>, V_Inet <dbl>, V_conc <dbl>, V_unit <chr>, Cr_Iraw <dbl>,
#> #   Cr_Inet <dbl>, Cr_conc <dbl>, Cr_unit <chr>, Mn_Iraw <dbl>,
#> #   Mn_Inet <dbl>, Mn_conc <dbl>, Mn_unit <chr>, Fe_Iraw <dbl>,
#> #   Fe_Inet <dbl>, Fe_conc <dbl>, Fe_unit <chr>, Co_Iraw <dbl>,
#> #   Co_Inet <dbl>, Co_conc <dbl>, Co_unit <chr>, Ni_Iraw <dbl>,
#> #   Ni_Inet <dbl>, Ni_conc <dbl>, Ni_unit <chr>, Cu_Iraw <dbl>,
#> #   Cu_Inet <dbl>, Cu_conc <dbl>, Cu_unit <chr>, Zn_Iraw <dbl>,
#> #   Zn_Inet <dbl>, Zn_conc <dbl>, Zn_unit <chr>, Ga_Iraw <dbl>,
#> #   Ga_Inet <dbl>, Ga_conc <dbl>, Ga_unit <chr>, As_Iraw <dbl>,
#> #   As_Inet <dbl>, As_conc <dbl>, As_unit <chr>, Rb_Iraw <dbl>,
#> #   Rb_Inet <dbl>, Rb_conc <dbl>, Rb_unit <chr>, Sr_Iraw <dbl>,
#> #   Sr_Inet <dbl>, Sr_conc <dbl>, Sr_unit <chr>, Y_Iraw <dbl>,
#> #   Y_Inet <dbl>, Y_conc <dbl>, Y_unit <chr>, Zr_Iraw <dbl>,
#> #   Zr_Inet <dbl>, Zr_conc <dbl>, Zr_unit <chr>, Nb_Iraw <dbl>,
#> #   Nb_Inet <dbl>, Nb_conc <dbl>, Nb_unit <chr>, Mo_Iraw <dbl>, …
```
