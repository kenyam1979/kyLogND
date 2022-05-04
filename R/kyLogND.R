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
#' @description \code{histLogND} draws histogram of original and log converted distribution.
#' Red vertical line shows the mean of the original distribution.
#' Blue vertical line shows the mean of log converted distribution.
#' Green vertical line shows the median of the distribution.
#'
#' @param data A list of log normal distribution
#' @export
histLogND <- function(data) {
  par(mfrow = c(1, 2))
  data.log <- log(data)
  mean = mean(data)
  mean.log = mean(data.log)
  med = median(data)
  med.log = median(data.log)

  # Draw histogram of original distribution
  hist(data)
  abline(v=mean, col="red")
  abline(v=exp(mean.log), col="blue")
  abline(v=med, col="green")
  mtext(sprintf("mean(r)=%.2f\nmean.log(b)=%.2f\nmedian(g)=%.2f",
                mean, exp(mean.log), med),
        side = 3, adj = 1, line=-3)

  # Draw histogram of log converted distribution
  hist(data.log)
  abline(v=log(mean), col="red")
  abline(v=mean.log, col="blue")
  abline(v=med.log, col="green")
  mtext(sprintf("mean(r)=%.2f\nmean.log(b)=%.2f\nmedian(g)=%.2f",
                log(mean), mean.log, med.log),
        side = 3, adj = 1, line=-3)

  par(mfrow = c(1, 1)) # resetting graphic param

}


#' @title Check normality of log converted distribution
#' @description \code{normalityCheckLogND} checks the normality of log converted distribution and draw QQ-plot.
#'
#' @param data A list of log normal distribution
#' @export
normalityCheckLogND <- function(data) {
  data.log <- log(data)
  qqnorm(y = data.log)
  qqline(y = data.log, col="blue")

  result <- shapiro.test(x=data.log)
  result$method <- "Shapiro-Wilk normality test (null hypothesis: data is ND)"
  result
}

#' @title Calculate interval estimate of mean with Bootstrap
#' @description \code{meanIntervalLogND} calculate interval estimate of mean.
#'
#' @importFrom boot boot
#' @param data A list of log normal distribution
#' @export
meanIntervalLogND <- function(data, R=1000, graphic=FALSE) {
  statFun <- function(x, idx) mean(x[idx])
  result <- boot(data, R=R, statistic=statFun)
  qtl <- quantile(result$t, probs=c(0.025, 0.5, 0.975))

  if (graphic) {
    hist(data)
    abline(v=qtl[2], col = "red")
    abline(v=qtl[1], col = "blue")
    abline(v=qtl[3], col = "blue")
  }
  qtl
}

