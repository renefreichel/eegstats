#' reading_data
#' @description  The function \emph{reading_data} checks whether the shape of the input matrix is correct
#' and adds the electrode names to the datafile. This function should be run before running other eegstats
#' functions. If there are indications that the shape of the input file is not correct, warning messages
#' with relevant instructions will appear. The function also prints a short description of the dataset.
#' @param erpdata Input Matrix with shape: subject ID x condition x time x electrodes
#' @param electrode_names Vector of characters for the respective electrode names
#' @return A short description of the input data and potential concerns as warnings.
#' @export
reading_data <- function(erpdata, electrode_names) {

    n_warnings <- 0

  # 1. ensure data is properly pre-processed:
    # NAs
    if (sum(is.na(erpdata) > 0)) {
      warning('There is some missing data in your input. Make sure to pre-process it first.')
      n_warnings <- n_warnings + 1
    }

    # Inspection for first electrode: outlier (Are values that deviate more than 5 SD removed) ?

  possible_outlier <- 0 # initiate object: 0 outlier


  print('The outlier inspection might take up to one minute for a large number of electrodes!')

  for (e in 4:ncol(erpdata)) { # over all electrodes
      for (i in 1:length(erpdata[,e])) {
        threshold <- 5 * sd(erpdata[,e])

        if ((erpdata[i,e] > (mean(erpdata[,e]) + threshold))
            | (erpdata[i,e] < (mean(erpdata[,e]) - threshold))) {

              possible_outlier <- c(possible_outlier, i)
        }
      }
    #return(unique(possible_outlier))
  }
    # show warning if outlier were found
    if (length(possible_outlier) > 1) {
      warning(paste(paste('The data contains amplitude values at electrodes that deviate more than 5 standard deviations from the mean. For instance, for subject', my_erpdata[possible_outlier[2],1])),'. Make sure the data is pre-processed and outliers are removed!')
      n_warnings <- n_warnings + 1
    }

  #2. ensure data is the correct format:

    # input should be a data frame
    if (!is.data.frame(erpdata)) {
      warning('The input should be a data.frame of shape subject x condition x time x electrode!')
      n_warnings <- n_warnings + 1
    }

    # input should be in a long format
    if (length(unique(erpdata[,1])) == length(erpdata[,1])) {
      warning('There might be only one time point and or one condition in this dataset. Make sure
              that the dataset is in the right format!')
      n_warnings <- n_warnings + 1
    }

    # there need to be more than one condition
    if (length(unique(erpdata[,2])) == 1) {
      warning('There is only one condition. Make sure there are at least two conditions for later
              experimental comparisons!')
      n_warnings <- n_warnings + 1
    }

    # there need to be the same timepoints for all subjects
    if (length(unique(erpdata[,3])) == length(erpdata[,3])) {
      warning('There might be only one subject in the dataset or several subjects with different
              time points. Make sure the (measured) timepoints are the same across all subjects!')
      n_warnings <- n_warnings + 1
    }

  # 3. Add electrode names to data
  if (length(electrode_names) != length(4: ncol(erpdata))) {
    stop('The number of electrodes does not match the input matrix. Make sure the number of electrode names corresponds to the number of electrodes in the datafile!')
  }

  infos <- c('Subject', 'Condition', 'Time')
  colnames(erpdata) <- c(infos, electrode_names)

  # 4. Print descriptives
  n_subj = length(unique(erpdata[,1]))
  n_cond = length(unique(erpdata[,2]))
  n_time = length(unique(erpdata[,3]))
  n_elec = length(4:ncol(erpdata))

  print(sprintf("Short summary: This dataset contains EEG data for %s subjects, %s conditions at %s electrodes and %s timepoints. Double check that this is the correct before using other eegstats functions.", n_subj, n_cond,n_elec, n_time))

  if (n_warnings == 0) {
    print(sprintf("There are no %s concerns and the data seems to be in the right shape. Enjoy the eegstats functions!", n_warnings))
  } else if (n_warnings == 1) {
  print(sprintf("There is %s concern. See warning message", n_warnings))
  } else if (n_warnings >= 1) {
    print(sprintf("There are %s concerns. See warning messages:", n_warnings))
  }
 return(erpdata)


}

# Call function
electrode_names <- c('FCz','FPz','Cz','Fz','Pz','Oz','FC1','FC2','FC3','FC4','FC5','FC6','C1','C2','C3','P1','P2','P3', 'O1', 'O2')
my_erpdata <- reading_data(my_erpdata, electrode_names)

