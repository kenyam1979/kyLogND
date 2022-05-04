
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kyLogND

<!-- badges: start -->

<!-- badges: end -->

kyLogND is a set of utility functions to easily manipulate log normal
distribution.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kenyam1979/kyLogND")
```

## Utility functions in kyLogND

  - histLogND
  - normalityCheckLogND
  - rlnorm2
  - convertLogToMean
  - convertLogToSD

`histLogND` draws histograms of the original distribution and log
converted distribution with their mean and median.

``` r
library(kyLogND)

logND <- rlnorm2(1000)
histLogND(logND)
```

<img src="man/figures/README-example-1.png" width="100%" />

`normalityCheckLogND` checks the normality of log transformed
distribution using QQ-plot and Shaprio test.

``` r
normalityCheckLogND(logND)
```

<img src="man/figures/README-example2-1.png" width="100%" />

    #> 
    #>  Shapiro-Wilk normality test (null hypothesis: data is ND)
    #> 
    #> data:  data.log
    #> W = 0.99649, p-value = 0.02444
