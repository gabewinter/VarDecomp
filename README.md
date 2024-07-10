
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
md = dplyr::starwars

mod = VarDecomp::brms_model(Chainset = 1, 
           Response = "mass", 
           FixedEffect = c("sex","height"), 
           RandomEffect = "species", 
           RandomSlope = "height", 
           Family = "gaussian", 
           Data = md, 
           Seed = 0405)
#> [1] "No problem 😄"
#> Warning: Rows containing NAs were excluded from the model.
#> Compiling Stan program...
#> Start sampling

VarDecomp::var_decomp(mod)
#> New names:
#> • `sex` -> `sex...1`
#> • `sex` -> `sex...3`
#> # A tibble: 15 × 6
#>    variable                 mean   median     sd lower_HPD upper_HPD
#>    <chr>                   <dbl>    <dbl>  <dbl>     <dbl>     <dbl>
#>  1 Intercept             -53.2    -53.5   13.2     -79.2     -27.5  
#>  2 sexhermaphroditic    1301.    1301.    20.0    1260.     1339.   
#>  3 sexmale                19.5     19.4    6.48      6.54     32.1  
#>  4 sexnone                28.9     28.8   14.1       3.16     57.2  
#>  5 height                  0.631    0.632  0.073     0.491     0.776
#>  6 species_height          0.082    0.075  0.05      0         0.176
#>  7 cor_species_height     -0.364   -0.545  0.573    -1         0.758
#>  8 R2_height               0.017    0.017  0.004     0.01      0.025
#>  9 R2_sexmale              0.003    0.002  0.002     0         0.006
#> 10 R2_sexnone              0.002    0.002  0.002     0         0.006
#> 11 R2_sexhermaphroditic    0.966    0.966  0.006     0.953     0.976
#> 12 R2_sum_fixed_effects    0.987    0.988  0.003     0.981     0.993
#> 13 R2_species_height       0.01     0.006  0.012     0         0.033
#> 14 R2_species              0.005    0.005  0.003     0         0.012
#> 15 R2_residual             0.007    0.007  0.002     0.004     0.011

VarDecomp::model_fit(mod, Group = "sex")
#> No divergences to plot.
#> Using all posterior draws for ppc type 'loo_pit_qq' by default.
#> Warning: Some Pareto k diagnostic values are too high. See help('pareto-k-diagnostic') for details.
#> Warning: Some Pareto k diagnostic values are too high. See help('pareto-k-diagnostic') for details.
#> Using all posterior draws for ppc type 'violin_grouped' by default.
#> $`R-hat and Effective sample size`
#> # A tibble: 1 × 2
#>    Rhat EffectiveSampleSize
#>   <dbl>               <dbl>
#> 1  1.01               1744.
#> 
#> $`Traceplots plot`
```

<img src="man/figures/README-example-1.png" width="100%" />

    #> 
    #> $`Posterior predictive check - Density overlay plot`

<img src="man/figures/README-example-2.png" width="100%" />

    #> 
    #> $`Posterior predictive check - LOO-PIT-QQ plot`

<img src="man/figures/README-example-3.png" width="100%" />

    #> 
    #> $`Posterior predictive check - Group density overlay plot`
    #> Warning: Groups with fewer than two datapoints have been dropped.
    #> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.

<img src="man/figures/README-example-4.png" width="100%" />
