#' @title Generate random numbers in log normal distribution
#' @description \code{rlnorm2} generates random numbers in log normal distribution
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


#' @title Convert log converted mean to the original mean
#' @description \code{convertLogToMean} converts log converted mean to the original mean
#'
#' @param meanlog Mean of log converted distribution
#' @param sdlog Standard deviation of log converted distribution
#' @return Mean of original distribution
#' @export
convertLogToMean <- function(meanlog = 1, sdlog = 1) {
  exp(meanlog + (sdlog^2) / 2)
}


#' @title Convert log converted SD to the original SD
#' @description \code{convertLogToSD} converts log converted SD to the original SD
#'
#' @param meanlog Mean of log converted distribution
#' @param sdlog Standard deviation of log converted distribution
#' @return SD of original distribution
#' @export
convertLogToSD <- function(meanlog = 1, sdlog = 1) {
  exp(2*meanlog + (sdlog^2)) * (exp(sdlog^2) - 1)
}


#' @title Compare histogram between original and log converted distribution
#' @description \code{histLogND} draw histogram of original and log %>%  converted distribution.
#' Red vertical line shows the mean of the original distribution.
#' Blue vertical line shows the mean of log converted distribution.
#'
#' @param data A list of log normal distribution]
#' @export
histLogND <- function(data) {
  par(mfrow = c(1, 2))
  data.log <- log(data)

  hist(data)
  abline(v=mean(data), col="red")
  abline(v=exp(mean(data.log)), col="blue")


  hist(data.log)
  abline(v=log(mean(data)), col="red")
  abline(v=mean(data.log), col="blue")
}

