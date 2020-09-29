# grand average erp plot
#' plot_grand_average_erp
#' @description  The function \emph{grand_average_erp_plot} plots the grand average ERP.
#' @param my_erpdata Input Matrix with shape: subject x condition x time x electrodes.
#' @param grand_average_erp_data Input Matrix that contains the single-subject ERP for all conditions in a selected electrode. The matrix should be of shape condition x time.
#' @return A plot with the grand average ERP signal.
#' @export
plot_grand_average_erp <- function(my_erpdata, grand_average_erp_data) {

  #dev.off()
  colours <- c('blue', 'black')

  cond <- unique(my_erpdata[,2])
  time <- unique(my_erpdata[,3])


  for (i in 1:nrow(grand_average_erp_data)) { # number of conditions

    if (i ==1) {
      plot(grand_average_erp_data[i,], type = "l", col = colours[i], ylab = 'Amplitude', xlab = 'Time (ms)', xaxt = "n", main = paste('ERP Plot for ', length(cond), 'conditions'))
    }

    else if (i >= 2) {
      lines(grand_average_erp_data[i,], col = colours[i])

    }
  }
  legend('topleft', legend=cond, col=colours[1:i], lty=1, cex=0.8)

  # add correct timepoints (as in original data)
  desired_timepoints <- seq(from = time[1], to = time[length(time)], by = 400)

  index_time <- c()

  for (i in 1:length(desired_timepoints)) {

    j <- desired_timepoints[i]

    index_time[i] <- which(time == j)

  }
  axis(1, at = index_time, labels = desired_timepoints)
}
#plot_grand_average_erp(my_erpdata, grand_average_erp_data)
