% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_summary.R
\name{model_summary}
\alias{model_summary}
\title{Model summaries with variance decomposition for brms models}
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
Model summaries with variance decomposition for brms models
}
\examples{

# Simulate data
md = tibble::tibble(
  group = factor(sample(1:10, 1000, replace = TRUE)),
  f_var = factor(sample(1:3, 1000, replace = TRUE)),
  n_var = rnorm(1000, mean = 0, sd = 1),
  resp = rnorm(1000, mean = 10, sd = 3))

# Run model
mod = brms_model(Response = "resp", 
                 FixedEffect = c("f_var","n_var"), 
                 RandomEffect = "group", 
                 Family = "gaussian", 
                 Data = md)

# Model summary

model_summary(mod)

}
