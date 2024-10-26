% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/brms_cov_model.R
\name{brms_cov_model}
\alias{brms_cov_model}
\title{Run a brms model containing a covariance matrix}
\usage{
brms_cov_model(
  Data,
  Response,
  FixedEffect,
  ID,
  RandomEffect = NULL,
  RandomSlope = NULL,
  Matrix,
  Chainset = 1,
  Family = "gaussian",
  Seed = NULL,
  Trials = NULL,
  PriorSamples = TRUE
)
}
\arguments{
\item{Data}{A data frame containing the data - covariates should be centered to a the mean or to a meaningful zero (see Schielzeth H. 2010. Simple means to improve the interpretability of regression coefficients. Methods Ecol Evol. 1:103–113. doi:10.1111/j.2041-210X.2010.00012.x.).}

\item{Response}{String with the name of the column in Data containing the response variable (e.g. "mass").}

\item{FixedEffect}{String with the name of the column in Data containing the fixed effect variable (e.g. "height"). To add multiple fixed effects, use c() (e.g. c("height", "sex")).}

\item{ID}{String with the name of the column in Data containing the ID of correlated individuals/groups. The current package version allows the use of a single random effect, so no additional random effects are possible yet.}

\item{RandomEffect}{String with the name of the column in Data containing the random effect variable (e.g. "species"). To add multiple random effects, use c() (e.g. c("species", "date")).}

\item{RandomSlope}{Vector containing two values: first a string with the name of the column in Data containing the covariate to be added as a random slope, second the random effect to which the  random slope will be applied (e.g. RandomSlope = c("height", "species")). The current package version allows the use of a single random slope.}

\item{Matrix}{A matrix containing the IDs as row/column names and covariance values (ex. A pedigree relatedness matrix).}

\item{Chainset}{Defines the number of iterations. Start with Chainset = 1 and increase as needed until convergence. The value of Chainsetis multiplied by 15000 in warmup, 30000 in iterations and 15 in thin intervale. For quick tests use Chainset = 1 (warmup=10; iter=110; thin=10; chains=2)}

\item{Family}{String to define the family function in the brms model. Current supported families: "gaussian", "binomial", "poisson".}

\item{Seed}{Numeric and optional. Set a seed in order to repeat the results from the model when running it more than once.}

\item{Trials}{The total number of trials in a binomial model. The number of successes should be imputed on Response.}

\item{PriorSamples}{Logical value that defines if brmsfit will contain the priors used. Default is set to \code{FALSE}, which does not includ the priors in the brmsfit.}
}
\value{
Returns a brmsfit
}
\description{
Run a brms model containing a covariance matrix
}
\examples{
 
# Simulate the data directly into a tibble
md = tibble::tibble(
  ID = factor(sample(1:10, 1000, replace = TRUE)),
  var1 = rnorm(1000, mean = 0, sd = 1),
  var2 = rnorm(1000, mean = 5, sd = 2),
  resp = rnorm(1000, mean = 10, sd = 3))



## Create a covariance matrix (e.g., relatedness matrix)
cov_matrix = matrix(rnorm(10 * 10), 10, 10)
cov_matrix = cov_matrix \%*\% t(cov_matrix)  # Make it positive semi-definite
rownames(cov_matrix) = colnames(cov_matrix) = 1:10

## Ensure the covariance matrix is symmetric
cov_matrix = (cov_matrix + t(cov_matrix)) / 2


mod = brms_cov_model(Chainset = 3, 
           Response = "resp", 
           FixedEffect = c("var1", "var2"), 
           ID = "ID", 
           Matrix = cov_matrix,
           Family = "gaussian", 
           Data = md, 
           Seed = 0405)

}
