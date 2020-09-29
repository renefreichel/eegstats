#' eegstats
#' @description This eegstats package serves the purpose of analyzing and visualizing ERPs and ERSPs in R.
#'
#
#' @description The package eegstats consists of various functions divided into four sections:
#'
#' @section Preparation:
#' \emph{reading_data} Reads in the data, checks whether the structure of the input matrix is correct. Also
#' checks whether the data has been pre-processed and whether outlier have been removed.
#'
#'
#' @section ERP:
#' \emph{compute_ind_average_erp} Computes the single-subject ERP for the selected electrode.
#' \emph{compute_grand_average_erp} Computes the grand average ERP for the selected electrode.
#'
#' @section ERP Plots:
#' \emph{plot_ind_average_erp} Plots the single-subject ERP for the selected electrode.
#'\emph{plot_grand_average_erp} Plots the grand average ERP for the selected electrode.
#'
#' @section ERSP:
#'\emph{compute_grand_average_ersp} Computes the grand average ERSP for the selected electrode.
#'
#' @section ERSP Plots:
#'\emph{plot_grand_average_ersp} Computes the grand average ERSP for the selected electrode.
#'
#'@section Correlate ERP - ERSP:
#'\emph{correlate_erp_ersp} Correlates a selected ERP and ERSP feature of interest
#'
#' @docType package
#'
#' @name eegstats
NULL
