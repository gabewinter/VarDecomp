# WARNING - Generated by {fusen} from dev/VarDecomp_package.Rmd: do not edit by hand

#' Plot probability density intervals for fixed effects of brms models
#'
#' @param brmsfit The output of a brms model. You can use VarDecomp::brms_model() to produce a brmsfit. 
#' @return Returns a density plot with z-transformed fixed effect estimates.
#' @export 
#' 
#' @examples
#'
#' # Simulate data
#' md = tibble::tibble(
#'   group = factor(sample(1:10, 1000, replace = TRUE)),
#'   f_var = factor(sample(1:3, 1000, replace = TRUE)),
#'   n_var = rnorm(1000, mean = 0, sd = 1),
#'   resp = rnorm(1000, mean = 10, sd = 3))
#'
#' # Run model
#' mod = brms_model(Response = "resp", 
#'                  FixedEffect = c("f_var","n_var"), 
#'                  RandomEffect = "group", 
#'                  Family = "gaussian", 
#'                  Data = md)
#'
#' # Plot fixed effects
#' plot_intervals(mod)
#'
#'

plot_intervals = function(brmsfit){

stopifnot("Input must be a brmsfit" = inherits(brmsfit, "brmsfit"))
  
  
#Extract fixed effects posterior samples from brmsfit
PS = as.data.frame(brmsfit) %>% 
  dplyr::select(dplyr::starts_with("b_")) %>% 
  dplyr::select(!dplyr::contains("Intercept")) %>% 
  dplyr::rename_with(~ stringr::str_remove(., "^b_"))

#Extract fixed effects observed data from brmsfit
Data = brmsfit$data 
Data = Data %>% 
  dplyr::filter(dplyr::if_all(1:ncol(Data),~ !is.na(.))) %>% 
  dplyr::select(-1) #Removing the response variable

#Extract family
Family = brmsfit$family[[1]][1]

  
## Create a dataframe with the values used by the model for fixed effects
if(Family == "binomial"){
  Data = Data %>%
  dplyr::select(-1)#Removing the trial variable
  }  

## Specific for covariates with of character class 
suppressWarnings({  
CharactersFE = Data %>%
  dplyr::select(-dplyr::one_of(colnames(PS))) 
  })
  
if(ncol(CharactersFE) == 0){
} else {
  
  for(i in colnames(CharactersFE)){
  unique_values = unique(CharactersFE[[i]])
  
    for (j in unique_values) {
    
      CharactersFE = CharactersFE %>% 
      dplyr::mutate(!!paste(j) := 
      dplyr::if_else(CharactersFE[[i]] == j, 1,0)) %>% 
      dplyr::rename(!!paste0(i, j) := paste(j))
    }
  
  CharactersFE = CharactersFE 
  }
  
  Data = dplyr::bind_cols(Data,CharactersFE) %>% 
    dplyr::select_if(~ is.numeric(.))
  }

# Standardize the slopes for the standard deviation of each covariate (Z transformation)
for(i in colnames(PS)){
  PS = PS %>% 
  dplyr::mutate(!!paste(i) := get(paste(i)) * sd(Data[[i]]))
}

# Turn to long format and order levels for the plot 

PS = PS %>%
  tidyr::pivot_longer(cols = tidyselect::everything(), 
  names_to = "FixedEffect",
  values_to = "Slope")


# Plot
ggplot2::ggplot(PS,ggplot2::aes(y = FixedEffect, x = Slope)) +  
  ggdist::stat_halfeye(.width = c(.5, .95))+
  ggplot2::geom_vline(xintercept=0,color = "red")+
  ggplot2::labs(x = "Fixed effects slopes")+
  ggplot2::theme_test()  
}

