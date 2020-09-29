# Time Frequency Plot: ERSP
#' plot_grand_average_ersp
#' @description  The function \emph{grand_average_ersp_plot} plots the grand average ERSP as a time frequency plot.
#' @param my_erspdata Input Matrix with shape: subject ID x condition x timex frequency (from only one electrode).
#' @param grand_average_ersp_data A matrix that contains the grand average ERSP for all conditions and all frequencies of one electrode.
#' The matrix will be of shape condition x time x frequency.
#' @param ncond A numeric value that specifies which condition should be plotted (e.g. 1 for condition 1)
#' @return A time - frequency plot with the grand average ERSP signal.
#' @example grand_average_ersp_plot(my_erpdata, grand_average_ersp_data, n_cond = 1)

#' @export
plot_grand_average_ersp <- function(my_erspdata, grand_average_ersp_data, n_cond) {

  cond <- unique(my_erpdata[,2])
  time <- unique(my_erpdata[,3])

  # get the right label for the heatmap
  labrow_label = seq(from = time[1], to = time[length(time)], by = 1)

  # add correct timepoints (as in original data)
  desired_timepoints <- seq(from = time[1], to = time[length(time)], by = 400,)

  index_time <- c()

  for (i in 1:length(desired_timepoints)) {

    j <- desired_timepoints[i]

    index_time[i] <- which(time == j)

  }

  labrow_label <- NA
  labrow_label[index_time] <- desired_timepoints

  # make the heatmap
  data <- t(as.matrix(grand_average_ersp_data[n_cond,,]))
  heatmap(data, Colv = NA, Rowv = NA, ylab = 'Frequency', xlab = 'Time (ms)', xaxt = "n", labCol = labrow_label)
}


# Call function
 plot_grand_average_ersp(my_erpdata, grand_average_ersp_data, n_cond = 1)
