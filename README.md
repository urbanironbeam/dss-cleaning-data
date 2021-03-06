# Getting and Cleaning Data Course Project

This repository is for the Coursera [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning) course project.  Big thanks to the University of California Irvine for provide the original data (please see [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Files 

1. [README.md](README.md) - this file, explaining the repo
2. [CodeBook.md](CodeBook.md) - a markdown file explaining what data are contained in [data_set_1.csv](data_set_1.csv) and [data_set_2.csv](data_set_2.csv)
3. [run_analysis.R](run_analysis.R) - an R script file used to generate the tidy data sets in [data_set_1.csv](data_set_1.csv) and [data_set_2.csv](data_set_2.csv)
4. [data_set_1.csv](data_set_1.csv) - the first data set (see [CodeBook.md](CodeBook.md) for details), combining the test and and training data sets from the source data.
5. [data_set_2.csv](data_set_2.csv) - the second data set (see [CodeBook.md](CodeBook.md) for details), providing averages (means) for each of the variables (grouped by subject and activity) in the first data set.

Note - this repo does not include the source data since it would be a bad practice to include a large binary file in a git repo, particularly since the source data is widely available.  However, the R script includes a verification of the checksum of the source data to verify the data are being reproduced consistently.

## Generating the Data Sets

Simply execute the [run_analysis.R](run_analysis.R) script.  

In your current working directory it will:
1. Download the source data to a file called `source-data.zip` (if not already in your working directory)
2. Extract the source data into a directory called `source-data`
3. Generate the first data set and serialize it as a comma seperated file: `data_set_1.csv'
3. Generate the second data set and serialize it as a comma seperated file: `data_set_2.csv'

Note - the data set CSVs included in this repo were generated on a Windows 10 machine using R version 3.5.2.
