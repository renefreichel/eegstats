# Single - Subject ERP
#' compute_ind_average_erp
#' @description  The function \emph{ind_average_erp} computes the single subject ERP signal for all conditions and a given electrode.
#' @param erpdata Input Matrix with shape: subject x condition x time x electrodes.
#' @param electrode A character that specifies the electrode that should be plotted.
#' @param subject A character or a vector of characters that contains the number of subject (e.g. 'SO1')
#' @details For more details, see Wikipedie page: \href{https://sccn.ucsd.edu/wiki/I.6:_Data_Averaging}{article}
#' @return A matrix that contains the single-subject ERP for all conditions in a selected electrode. The matrix will be of shape electrode x condition x subject.
#' @export
compute_ind_average_erp <- function(erpdata, electrode, subject) {

  # input should be only one electrode
  if (length(electrode) != 1) {
    stop('Data from only one electrode should be provided as input.')
  }

  # check for missing data
  if (sum(is.na(erpdata)) > 0) {
    warning('The input matrix contains missing data!')
  }

  # check whether electrode is in data
  if (sum(is.element(electrode, colnames(erpdata)) == 0)) {
    stop('At least one of the specified electrodes is not part of the data.')
  }

  # find index of electrode
  electrode_index <- matrix(NA)
  for (i in 1:length(electrode)) {
    electrode_index[i] <- which(colnames(erpdata)== electrode[i])
  }

  cond <- unique(erpdata[,2])
  time <- unique(erpdata[,3])


  # compute grand average (GA):
  ind_average_erp_data <- array(NA, dim = c(length(subject),length(cond),length(time)));
  for (s in 1:length(subject)) { # all subjects

    for (c in 1:length(cond)) { # all conditions

      ind_average_erp_data[s,c,] <- erpdata[erpdata[,1] == subject[s] & erpdata[,2] == cond[c],electrode] # compute GA

    }
  }
  return(ind_average_erp_data)
}

# ind_average_erp_data <- compute_ind_average_erp(my_erpdata, electrode = 'Cz', subject = c('S1', 'S2', 'S3'))
