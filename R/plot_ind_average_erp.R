# 2. ind_average_erp_plot
#' plot_ind_average_erp
#'
#' @description  The function \emph{ind_average_plot} plots the single-subject ERP.
#' @param erpdata Input Matrix with shape: subject x condition x time x electrodes.
#' @param ind_average_erp_data Input Matrix that contains the single-subject ERP for all conditions in a selected electrode. The matrix should be of shape condition x subject.
#' @return A plot with the sinlge subject - ERP.
#' @seealso Add example of similar functions [still to be done].
#' @export
plot_ind_average_erp <- function(erpdata, ind_average_erp_data) {

  #dev.off()
  colours <- c('red', 'green', 'blue', 'black', 'green')

  cond <- unique(erpdata[,2])
  time <- unique(erpdata[,3])

  par(mfrow = c(1, nrow(ind_average_erp_data)))
  for (s in 1:nrow(ind_average_erp_data)) {

    for (i in 1:ncol(ind_average_erp_data)) {

      if (i ==1) {
        plot(ind_average_erp_data[s,i,], type = "l", col = colours[i], ylim = c(-30,30),
             ylab = 'Amplitude', xlab = 'Time (ms)', xaxt = "n",
             main = paste('ERP subject',s, 'for ', length(cond), 'conditions'))
      }

      else if (i >= 2) {
        lines(ind_average_erp_data[s,i,], col = colours[i])

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
}

#plot_ind_average_erp(my_erpdata, ind_average_erp_data)
