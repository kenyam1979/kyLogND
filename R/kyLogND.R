#' @title Generate random numbers with log normal distribution
#' @description \code{rlnorm2} Generate random numbers with log normal distribution
#'
#' @param n Length of generated list
#' @param mean Mean of original distribution
#' @param sd Standard deviation of original distribution
#' @return A list of generated random number
#' @export
rlnorm2 <- function(n, mean = 1, sd = 1) {
  sdlog <- sqrt(log((sd/mean)^2 + 1))
  meanlog <- log(mean) - (sdlog^2) / 2
  rlnorm(n, meanlog = meanlog, sdlog = sdlog)
}
