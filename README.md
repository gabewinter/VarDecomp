
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
library(tidyverse)

md = tibble(
  sex = sample(rep(c(-0.5, 0.5), each = 500)),
  species = sample(rep(c("species1","species2","species3","species4","species5"), each = 200))) %>% 

## Create a variables 
  dplyr::mutate(height = rnorm(1000, mean = 170, sd = 10),
                mass = 5 + 0.5 * height + rnorm(1000, mean = 0, sd = 5)) %>% 
  dplyr::mutate(height = height - mean(height),
                mass = log(mass))


mod = brms_model(Chainset = 2,
                 Response = "mass", 
                 FixedEffect = c("sex","height"), 
                 Family = "gaussian", 
                 Data = md)

model_fit(mod, Group = "sex")

model_summary(mod)

plot_intervals(mod)

PS = var_decomp(mod)

plot_R2(PS)
```
