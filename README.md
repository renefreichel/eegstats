# eegstats
This project was initially just meant to be an assignment for a programming course on building R packages. However, I aim to further work on it to develop a useful R package with functions to visualize and analyze EEG data. Ideally, the package would be compatible with existing Matlab (EEEGLAB) data structures. 

I am still working on the package and it should not be used yet.

# Project
I am going to create the R package "eegstats" that will allow the user to perform statistical EEG analyses in R. The structure of this project is hierarchical. First, ERP and ERSP analyes will be introduced and second, those outputs will be used for more complex statistical analyses.The focal point of interest consitutes event - related potentials (ERPs) and event - related spectral dynamics (ERSPs). Thus, I will develop functions to analye both. 

ERP
 1. compute_ind_average_erp: allows users to compute the individual averaged ERP signal.
 2. plot_ind_average_erp: allows users to plot the individual averaged ERP signal.
 3. compute_grand_average_erp: allows users to compute the grand averaged ERP signal.
 4. plot_grand_average_erp: allows users to plot the grand averaged ERP signal.
 
ERSP
 5.compute_grand_average_ersp: allows users to compute the grand averaged ERSP.
 6.plot_grand_average_ersp: allows users to plot the grand averaged ERSP as a time - frequency plot.

These ERP / ERSP analyses were the primary goal of this package. Next, I will develop functions that incorporate the ERPs and ERSPs. More and more research focuses on the relation between ERPs and ERSPs to infer spectral dynamics (see Yordanova et al., 2001). I will develop a function that allows users to do this. For instance, one could enter a certain ERP (e.g. P3) and a certain ERSP of interest (e.g. Alpha: 8 - 12 Hz.). The function cor_erp_ersp will correlate those features and visualize the correlations in a correlation table.

 7. correlate_erp_ersp 
 
If there is time left, I could implement other functions, such as baseline and outlier correction. However, for the ERP and ERSP analyses I assume that all input data are already pre-processed. Moreover, the developed ERP / ERSP functions will be useful as there are  no existing packages in R that perform such ERP / ERSP correlation analyses. 

Depending on the progress of this project, I plan to implement more sophisticated analysis techniques, such as cluster based permutation statistics.

EEG analyses in R have long been neglected so it's finally time to program those as "the next step" (pun intended).

# Code
All functions will be programmed in R.

# Literature

Delorme, A., & Makeig, S. (2004). EEGLAB: an open source toolbox for analysis of single-trial EEG dynamics including independent component analysis. Journal of neuroscience methods, 134(1), 9-21.

Yordanova, J., Kolev, V., & Polich, J. (2001). P300 and alpha event-related desynchronization (ERD). Psychophysiology, 38(1), 143-152.
