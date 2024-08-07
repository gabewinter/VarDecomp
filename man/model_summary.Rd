% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_summary.R
\name{model_summary}
\alias{model_summary}
\title{Variance decomposition for brms models}
\usage{
model_summary(brmsfit)
}
\arguments{
\item{brmsfit}{The output of a brms model. You can use VarDecomp::brms_model() to produce a brmsfit.}
}
\value{
Returns a data frame with the summaries of posterior estimates.
}
\description{
Variance decomposition for brms models
}
\examples{
\dontrun{

md = dplyr::starwars

# Centering variables
md = md \%>\% 
  dplyr::select(mass, sex, species) \%>\% 
  dplyr::mutate(mass = log(mass),
         sex = dplyr::recode(sex, "male" = 1, 
                      "female" = -1, 
                      "hermaphroditic" = 0,
                      "none" = as.numeric(NA)))
  
  
mod = brms_model(Chainset = 2,
                 Response = "mass", 
                 FixedEffect = "sex", 
                 RandomEffect = "species",
                 Family = "gaussian", 
                 Data = md)

model_summary(mod)

}
}
