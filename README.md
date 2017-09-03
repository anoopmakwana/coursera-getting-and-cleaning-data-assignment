# coursera-getting-and-cleaning-data-assignment

Solution to Coursera Getting And Cleaning data Course Assignment. This repository contains README.md file, run_analysis.R script which peforms all the operation to create the tidy dataset, and the CodeBook.md that describes the variables.

The R script, run_analysis.R, does the following:

----------------------------------------------------------------------------------------------------------------------------------------

- Downloads the dataset if it does not exist

- Load the activity and feature data

- Loads training and test datasets and merges them

- Converts the activity and subject columns into factors

- Creates a clean dataset that consists of the mean value of each variable for each subject and activity pair
