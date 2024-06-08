
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VarDecomp

<!-- badges: start -->

[![R-CMD-check](https://github.com/gabewinter/VarDecomp/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/gabewinter/VarDecomp/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/gabewinter/VarDecomp/branch/main/graph/badge.svg)](https://app.codecov.io/gh/gabewinter/VarDecomp?branch=main)
<!-- badges: end -->

VarDecomp can be used for variance decomposition, model fit checks and
output visualizations of brms models.

## Installation

You can install the development version of VarDecomp like so:

``` r
devtools::install_github("gabewinter/VarDecomp")
```

## Documentation

Full documentation website on: <https://gabewinter.github.io/VarDecomp>

## Example

``` r
library(VarDecomp)

md = dplyr::starwars

mod = brms_model(Chainset = "long", 
           Response = "mass", 
           FixedEffect = c("sex","height"), 
           RandomEffect = "species", 
           RandomSlope = "height", 
           Family = "gaussian", 
           Data = md, 
          Seed = 0405)
#> [1] "No problem 🤩"
#> Warning: Rows containing NAs were excluded from the model.
#> Compiling Stan program...
#> Start sampling

var_decomp(mod)
#> New names:
#> • `sex` -> `sex...1`
#> • `sex` -> `sex...3`
#> # A tibble: 16 × 6
#>    variable                 mean   median     sd lower_HPD upper_HPD
#>    <chr>                   <dbl>    <dbl>  <dbl>     <dbl>     <dbl>
#>  1 Intercept             -53.2    -53.5   13.2     -79.2     -27.5  
#>  2 sexhermaphroditic    1301.    1301.    20.0    1260.     1339.   
#>  3 sexmale                19.5     19.4    6.48      6.54     32.1  
#>  4 sexnone                28.9     28.8   14.1       3.16     57.2  
#>  5 height                  0.631    0.632  0.073     0.491     0.776
#>  6 species_height          0.082    0.075  0.05      0         0.176
#>  7 cor_species_height     -0.364   -0.545  0.573    -1         0.758
#>  8 sigma                  14.5     14.4    1.93     10.9      18.2  
#>  9 R2_height               0.816    0.82   0.049     0.719     0.909
#> 10 R2_sexmale              0.004    0.004  0.001     0.001     0.006
#> 11 R2_sexnone              0.002    0.002  0.001     0         0.004
#> 12 R2_sexhermaphroditic    0.023    0.023  0.003     0.018     0.028
#> 13 R2_FixedEffects         0.845    0.848  0.05      0.747     0.937
#> 14 R2_species_height       0.014    0.008  0.019     0         0.049
#> 15 R2_species             -0.06    -0.06   0.007    -0.074    -0.048
#> 16 R2_residual             0.216    0.212  0.049     0.133     0.318
```
