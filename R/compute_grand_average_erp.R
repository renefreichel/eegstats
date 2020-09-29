
# 3. grand_average_erp
#' compute_grand_average_erp
#' @description  The function \emph{grand_average_erp} computes the grand average  ERP signal for all conditions and a given electrode.
#' @param erpdata Input Matrix with shape: subject x condition x time x electrodes.
#' @param electrode A numeric value that specifies the number of electrode that should be plotted
#' @details For more details, see Wikipedie page: \href{https://sccn.ucsd.edu/wiki/I.6:_Data_Averaging}{article}
#' @return A matrix that contains the grand average ERP for all conditions in a selected electrode. The matrix will be of shape condition x time.
#' @seealso Add example of similar functions [still to be done].
#' @export
compute_grand_average_erp <- function(erpdata, electrode) {

  # check whether electrode is in data
  if (sum(is.element(electrode, colnames(erpdata)) == 0)) {
    stop('At least one of the specified electrodes is not part of the data.')
  }

  # find index of electrode
  electrode_index <- matrix(NA)
  for (i in 1:length(electrode)) {
    electrode_index[i] <- which(colnames(erpdata)== electrode[i])
  }


  subjects <- unique(erpdata[,1])
  cond <- unique(erpdata[,2])
  time <- unique(erpdata[,3])


  # input should be only one electrode
  if (length(electrode) != 1) {
    stop('Data from only one electrode should be provided as input.')
  }

  if (sum(is.na(erpdata)) > 0) {
    warning('The input matrix contains missing data!')
  }

  #subjects <- unique(my_erpdata[,1])

  # compute grand average (GA):
  grand_average_erp_data <- array(NA, dim = c(length(subjects),length(cond),length(time)));
  for (s in 1:length(subjects)) { # all subjects

    for (c in 1:length(cond)) { # all conditions

      grand_average_erp_data[s,c,] <- my_erpdata[erpdata[,1] == subjects[s] & erpdata[,2] == cond[c],electrode] # compute GA

    }
  }
  grand_average_erp_data <- colMeans(grand_average_erp_data) #
  return(head(grand_average_erp_data))
}

#grand_average_erp_data <- compute_grand_average_erp(my_erpdata, electrode = 'Cz')
