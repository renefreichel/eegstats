# 8. ERSP / ERP correlation
#' correlate_erp_ersp
#' @description  The function \emph{erp_ersp_cor} correlates a selected ERP and ERSP component.
#' @param my_erspdata Input Matrix with shape: subject ID x condition x time x frequency (from only one electrode).
#' @param erpdata Input Matrix with shape: subject ID x condition x time x electrode
#' @param electrode A character that specifies the number of electrode that should be used for ERP calculation.
#' @param frequency A numeric value that specifies the desired frequency.
#' @param time_erp A numeric value that specifies the time of the ERP (e.g. 20) in ms
#' @return A correlation matrix with the correlations between the specified erp and ersp for all conditions.
#' @return A correlation plot thatr illustrates the ERP / ERSP correlations for all conditions.
#' @export
correlate_erp_ersp <- function(erpdata, electrode, time_erp, my_erspdata, frequency) {

  # input should be only one electrode
  if (length(electrode) != 1) {
    stop('Data from only one electrode should be provided as input.')
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


  #dev.off()
  cond <- unique(my_erpdata[,2])

  erp <- matrix(NA, length(unique(erpdata[,1])), length(cond))   # subject x cond

  ersp <- matrix(NA, length(unique(my_erspdata[,1])), length(cond))   # subject x cond

  cors <- matrix(NA, nrow = length(cond), ncol = length(cond))

  # get ERPs and ERSPs
  for (c in 1:length(cond)) { # cond

    erp[,c] <- my_erpdata[erpdata[,1] == erpdata[,1] & erpdata[,3] == time_erp
                          &  erpdata[,2] ==  cond[c], electrode_index]

    ersp[,c] <- my_erspdata[my_erspdata[,1] == my_erspdata[,1] & my_erspdata[,3] == time_erp
                            &  my_erspdata[,2] == cond[c], frequency]
  }

  # correlations
  cors <- as.matrix(cor(erp,ersp))

  # get p-values
  pvals <- matrix(NA, nrow = length(cond), ncol = length(cond))
  for (i in 1:length(cond)) {
    for (j in 1:length(cond)) {

      pvals[i,j] <- cor.test(erp[,i],ersp[,j])$p.value

    }
  }

  #
  if (length(cond) == 2) {
    rownames(cors) <- c(paste('ERP Cond.', cond[1]), paste('ERP Cond.', cond[2]))
    colnames(cors) <- c(paste('ERSP Cond.', cond[1]), paste('ERSP Cond.', cond[2]))
  }
  #return((list(cor(erp[,1], ersp[,1]), cor(erp[,2], ersp[,2]), erp, ersp)))

  d <- corrplot::corrplot(cors, method = 'number', p.mat = pvals, insig = 'pch', pch = 4)
  par(d, cex = 1.2)

  return(list(cors, erp, ersp, pvals))

}


# Apply function
# electrode = 'Cz'
# time_erp = 100
# frequency = 10
# correlate_erp_ersp(my_erpdata, electrode, time_erp, my_erspdata, frequency)
# correlate_erp_ersp(my_erpdata, time_erp, my_erspdata = my_erpdata, electrode = 'Cz', frequency )
