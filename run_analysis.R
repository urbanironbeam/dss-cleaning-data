#
# This script file functions for downloading/extracting source data, extracting the 
# desired content, generating 2 tidied data sets, and then outputting the data sets
# to file as a CSVs.
#
# Link to assignment: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
#

library(dplyr)
library(tidyr)
library(tools)

#
# Downloads a source data, extracts it, and sets working dir to be in the extracted folder.
#
# Notes
#   1) Function assumes that if "source-data.zip" exists in current working dir, then 
#       data has been downloaded and extracted already, and in this case it will not
#       download or extract again.
#
download_and_extract_data_and_set_wd <- function() {
    
    source_data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    source_zip_file <- "source-data.zip"
    extracted_data_dir <- "UCI HAR Dataset"
    expected_md5_checksum_of_zip <- "d29710c9530a31f303801b6bc34bd895"
    working_dir <- getwd()
    
    if( !file.exists(source_zip_file) ) {
        
        download_result <- download.file(source_data_url, source_zip_file)
        stopifnot(0==download_result)
        
        # If we have just downloaded the source data, we expect the 
        # extracted content not to exist yet, so terminate otherwise
        stopifnot( !dir.exists(extracted_data_dir))
        
        # Unzip the data now
        unzip(source_zip_file,exdir=working_dir)
    }
    
    # If the source file doesn't have the expected checksum, it means it has 
    # changed from when this script was written
    actual_checksum <- md5sum(source_zip_file)
    if( actual_checksum != expected_md5_checksum_of_zip) {
        warning_msg <- "Source data zip file MD5 checksum expected to be '%s' but was '%s'"
        warning(sprintf(warning_msg, expected_md5_checksum_of_zip, actual_checksum))
    }
    
    # update working dir to be in the extacted data folder
    working_dir <- file.path(working_dir,extracted_data_dir)
    setwd(working_dir)
}

# Returns a data frame with 3 variables...
# 
#   index       - which is the column ID of a variable in the source data
#   raw_name    - the field name exactly as specified in the 'features.txt' file
#   tidy_name   - a cleaned-up version of the field name
#
# The resulting data frame will only include the fields for Mean and 
# Standard-deviation (std).
#
# Notes
#   1) Assignment states: "Extracts only the measurements on the mean and 
#       standard deviation for each measurement".  This function assume this 
#       only includes fields containing exactly "-mean()" or "-std()" not 
#       those with names that include things like "-meanFrequency()".
#   2) tidy_name values: this function preserves the original camelCase used
#       for the name of them measurement from the source data, this is 
#       debately, but I believe it is actually more readable than converting 
#       to lower_with_underscores, and it makes it easier to understand in
#       context of original data.
#
get_field_data <- function() {
    # Get the indices and names
    
    field_data <- read.table("features.txt", col.names = c("index","raw_name")) 
    
    # Include only field names containing: "-mean()" or "-std()"
    field_data <- dplyr::filter(field_data, grepl("-mean\\(\\)|-std\\(\\)", raw_name))

    # Clean field names
    #   - Replace dashes with underscores, and eliminate the brackets
    #   - Preserve the original camelCase used for the name of them measurement,
    #       this is debately, but I believe it is actually more readable than
    #       converting to lower_with_underscores, and it makes it easier to understand
    #       in context of original data.
    field_data$tidy_name = gsub("-mean\\()","_mean", field_data$raw_name)
    field_data$tidy_name = gsub("-std\\()","_std", field_data$tidy_name)
    field_data$tidy_name = gsub("-","_", field_data$tidy_name)
    
    # Looks like there was a typo in the original data with, so changing "fBodyBody" to "fBody"
    field_data$tidy_name = gsub("fBodyBody","fBody", field_data$tidy_name)
    
    return(field_data)
}


#
# Returns the relative path of the file contain a list of ids for the data-set
#
# data_set  - must be: "train" or "test"
# data_type - must be: "subject", "x", or "y"
# 
get_file_path <- function(data_set,data_type) {
    file_name <- sprintf("%s_%s.txt",data_type, data_set)
    file_path <- file.path(data_set,file_name)  # The folder name users the data_set name
    return(file_path)
}

# Gets a data frame containing the tidied version of the given data set. It does 
# this by reading the "subject", "y" (with activity IDs), and "x" data files. And 
# combines them into a tidy data frame.  
# 
# data_set        - must be: "train" or "test" 
# activity_labels - data frame mapping numerical activity ID, to the activity name
# field_data      - data frame with details about the fields in the source data
#
get_tidy_data_set <- function(data_set,activity_labels,field_data) {
    
    # Get the subject ID for each measurement
    subject_data <- read.table(get_file_path(data_set,"subject"), col.names = "id") 
    
    # Get the activity labels for the data-set
    activity_data <- read.table(get_file_path(data_set,"y"), col.names = "id") 
    activity_data$activity <- 
        activity_labels[match(activity_data$id, activity_labels$id),2] # Col 2 has the label names
    
    # Read the data from a data set
    data_raw <- read.table(get_file_path(data_set,"x")) 
    data_slim <- data_raw[,field_data$index]
    colnames(data_slim) <- field_data$tidy_name
    
    return(cbind(
        subject  = subject_data$id,
        activity = activity_data$activity, 
        data_slim))
}

#
# Helper function for creating the Code book
#
get_code_book_row <- function(fieldName) {
    
    domain <- if( grepl("^t",fieldName) ) "time" else "frequency"
    fieldNameParts <- strsplit(fieldName,"_")[[1]]
    axis <- if( length(fieldNameParts)== 3) fieldNameParts[3] else "NA"
    sprintf("| %-21s | %-10s | %-4s | %-4s | \n", fieldName, domain, fieldNameParts[2], axis)
}

#
# Helper function for creating the Code book
#
get_code_book_field_data <- function(field_data) {

    codebook_rows <- ""
    for(f in field_data$tidy_name) {
        cat(codebook_rows, get_code_book_row(f))
    }
    
    return(codebox_rows)
}

#
# Gets a data frame combining the tidied training and test data sets
# 
get_combined_data_set <- function() {
    
    download_and_extract_data_and_set_wd()
    
    field_data <- get_field_data()
    
    activity_labels <- read.table("activity_labels.txt", col.names = c("id","activity")) 
    
    # Get the individual (tidied) data-sets
    train_data_set <- get_tidy_data_set("train", activity_labels, field_data)
    test_data_set <- get_tidy_data_set("test", activity_labels, field_data)
    
    # Combine the data-sets
    combined_data_set <- rbind(train_data_set, test_data_set)
    
    return(combined_data_set)
}

data_set_1 <- get_combined_data_set()
data_set_2 <- data_set_1 %>% 
                group_by(subject,activity) %>% 
                summarise_all(funs(mean))

write.csv(data_set_1,"data_set_1.csv", row.names=FALSE)
write.csv(data_set_2,"data_set_2.csv", row.names=FALSE)

