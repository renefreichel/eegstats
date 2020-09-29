## ERSP data ----
# ERSP stands for event - related spectral dynamics. Instead of looking at the signal amplitude, here we
# focus on different frequency bands (e.g. alpha: 8 - 12 Hz). Usually the input for these type of
# analyses should have the form: subject ID x condition x time x electrodes x frequency.
# That's a typical shape of pre - processed EEG data.

# To make things a bit easier, we assume that the different electrodes in this dataset (my_erpdata)
# represent frequencies at one electrode. So here we assume that the 20 electrodesrepresent 20
# different frequencies that have been sampled at one electrode. So electrode 1 would be 5 Hz,
# electrode 2 would be 6 Hz until electrode 20 represents 25 Hz.

# grand average ersp
#' compute_grand_average_ersp
#' @description  The function \emph{grand_average_ersp} computes the grand average  ERSP signal for all conditions and all frequencies from one electrode.
#' @param my_erspdata Input Matrix with shape: subject ID x condition x timex frequency (from only one electrode).
#' @details For more details, see Wikipedie page: \href{https://sccn.ucsd.edu/wiki/Chapter_11:_Time/Frequency_decomposition}{article}
#' @return A matrix that contains the grand average ERSP for all conditions and all frequencies of one electrode. The matrix will be of shape condition x time x frequency.
#' @example grand_average_ersp_data <- grand_average_ersp(my_erpdata)
#' @export
compute_grand_average_ersp <- function(my_erspdata) {

  cond <- unique(my_erpdata[,2])
  time <- unique(my_erpdata[,3])

  grand_average_ersp_data <- array(NA, dim = c(length(cond),length(time), 20))
  for (c in 1:length(cond)) { # all conditions

    for (t in 1:length(time)) { # all timepoints

      grand_average_ersp_data[c, t,] <-  colMeans(my_erpdata[my_erpdata[,2] == cond[c] & my_erpdata[,3] == time[t], c(4:ncol(my_erpdata))])
    }
  }
  return(grand_average_ersp_data)
}

# call function
# grand_average_ersp_data <- compute_grand_average_ersp(my_erpdata)
