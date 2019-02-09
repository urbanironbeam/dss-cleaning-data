# Codebook

## Source Data
All data is derived from this source:  

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Although it is sometimes recommended to keep the source data, I have not because it is bad practice to include large binary files in git repos. Instead I have include the download/extract portion of the scripts will verify the MD5 checksum of the zip file to ensure it the same as what was used to produce the resulting data sets included in this repo.  

Checksum: `d29710c9530a31f303801b6bc34bd895`

## Transformations

No transformations of values were done from what already existed in the source data however, the following was done to create the tidy data set:
1. Only the mean and std (standard deviation) values were included in the measurements
2. Fields for the 'subject' and 'activity' were added to the measurement table (see below for details)
..* in the source data the 'activity' value used numerical ids (1-6) in the tidy data the label names of these activities were used instead
3. The field names were modified: brackes removed and hyphens changed to underscores.
..* additionally it appear there was a typo in the source data field names in a few cases so occurences "fBodyBody" were changed to "fBody"

## Units 
To be honest, the units confused the heck out of me... but I tried, I really did.  The the source data README.md it indicates the raw measurements were in 'standard gravity units' for the acceleration measurements, and 'radians/sec' for the gyroscopic measurements.  However, sampled the values their are all between -1 and 1, so they have been normalized.  So my best effort at satisfying the requirement to identify the units is to provide the verbatum description of measurements from the source.  

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

## Field Details
The table below has one row for each field in the tidy data set, and describes the mean of that field.  The meaning of the columns below as as follows:
* **Field Name** - the name of field in the tidy data set.
* **Domain** - the domain type of the measurement either *time* or  *frequency*, see the [Unit](#Units) section above.
* **Mean** - either *mean* indicating the value is an average (specifically mean), or *std* to indicate it is a measure of standard deviation
* **Axis** - most fields are a measure for a particular directional axis, values *X*, *Y*, and *Z* indicate which directional azis, *NA* indicates it is not a directional measurement.
* **Description** - is description of what is measured by this field.
** Note - blank lines indicate the description is the same as next non-blank description above (done to make it clearer how the measurements are grouped together).  

There are two additional fields in the data set not included in the table, they are:
* **subject** - a numerical ID (values 1 - 30) identifying the subject (person) the measurement was for.  Note this was not explicitly required by in assignment.
* **activity** - the activity (*WALKING*, *WALKING_UPSTAIRS*, *WALKING_DOWNSTAIRS*, *SITTING*, *STANDING*, or *LAYING*)
) the subject was observed doing when the measurement was taken.

### data-set-2.csv

The description of the field details about applies to the [first data set](data-set-1.csv).  However, the fields below have a different meaning for the [second data set](data-set-2.csv).  In the second data set, these values are all averages (mean) for the given field when they are grouped by *subject* and *activity*.  So in the second data set the field name are all suffixed with "_avg".


| Field Name            | Domain     | Mean | Axis | Description
|-----------------------|------------|------|------|-----------------------------------------------------|
| tBodyAcc_mean_X       | time       | mean | X    | Body acceleration
| tBodyAcc_mean_Y       | time       | mean | Y    | 
| tBodyAcc_mean_Z       | time       | mean | Z    | 
| tBodyAcc_std_X        | time       | std  | X    | 
| tBodyAcc_std_Y        | time       | std  | Y    | 
| tBodyAcc_std_Z        | time       | std  | Z    | 
| tGravityAcc_mean_X    | time       | mean | X    | Acceleration due to gravity
| tGravityAcc_mean_Y    | time       | mean | Y    | 
| tGravityAcc_mean_Z    | time       | mean | Z    | 
| tGravityAcc_std_X     | time       | std  | X    | 
| tGravityAcc_std_Y     | time       | std  | Y    | 
| tGravityAcc_std_Z     | time       | std  | Z    | 
| tBodyAccJerk_mean_X   | time       | mean | X    | Body acceleration jerk
| tBodyAccJerk_mean_Y   | time       | mean | Y    | 
| tBodyAccJerk_mean_Z   | time       | mean | Z    | 
| tBodyAccJerk_std_X    | time       | std  | X    | 
| tBodyAccJerk_std_Y    | time       | std  | Y    | 
| tBodyAccJerk_std_Z    | time       | std  | Z    | 
| tBodyGyro_mean_X      | time       | mean | X    | Body rotation
| tBodyGyro_mean_Y      | time       | mean | Y    | 
| tBodyGyro_mean_Z      | time       | mean | Z    | 
| tBodyGyro_std_X       | time       | std  | X    | 
| tBodyGyro_std_Y       | time       | std  | Y    | 
| tBodyGyro_std_Z       | time       | std  | Z    | 
| tBodyGyroJerk_mean_X  | time       | mean | X    | Body rotational jerk
| tBodyGyroJerk_mean_Y  | time       | mean | Y    | 
| tBodyGyroJerk_mean_Z  | time       | mean | Z    | 
| tBodyGyroJerk_std_X   | time       | std  | X    | 
| tBodyGyroJerk_std_Y   | time       | std  | Y    | 
| tBodyGyroJerk_std_Z   | time       | std  | Z    | 
| tBodyAccMag_mean      | time       | mean | NA   | Magnitude of body acceleration
| tBodyAccMag_std       | time       | std  | NA   | 
| tGravityAccMag_mean   | time       | mean | NA   | Magnitude of acceleration due to gravity
| tGravityAccMag_std    | time       | std  | NA   | 
| tBodyAccJerkMag_mean  | time       | mean | NA   | Magnitude of body acceleration jerk
| tBodyAccJerkMag_std   | time       | std  | NA   | 
| tBodyGyroMag_mean     | time       | mean | NA   | Magnitude of body rotation
| tBodyGyroMag_std      | time       | std  | NA   | 
| tBodyGyroJerkMag_mean | time       | mean | NA   | Magnitude of body rotational jerk
| tBodyGyroJerkMag_std  | time       | std  | NA   | 
| fBodyAcc_mean_X       | frequency  | mean | X    | Body acceleration
| fBodyAcc_mean_Y       | frequency  | mean | Y    | 
| fBodyAcc_mean_Z       | frequency  | mean | Z    | 
| fBodyAcc_std_X        | frequency  | std  | X    | 
| fBodyAcc_std_Y        | frequency  | std  | Y    | 
| fBodyAcc_std_Z        | frequency  | std  | Z    | 
| fBodyAccJerk_mean_X   | frequency  | mean | X    | Body acceleration jerk
| fBodyAccJerk_mean_Y   | frequency  | mean | Y    | 
| fBodyAccJerk_mean_Z   | frequency  | mean | Z    | 
| fBodyAccJerk_std_X    | frequency  | std  | X    | 
| fBodyAccJerk_std_Y    | frequency  | std  | Y    | 
| fBodyAccJerk_std_Z    | frequency  | std  | Z    | 
| fBodyGyro_mean_X      | frequency  | mean | X    | Body rotation
| fBodyGyro_mean_Y      | frequency  | mean | Y    | 
| fBodyGyro_mean_Z      | frequency  | mean | Z    | 
| fBodyGyro_std_X       | frequency  | std  | X    | 
| fBodyGyro_std_Y       | frequency  | std  | Y    | 
| fBodyGyro_std_Z       | frequency  | std  | Z    | 
| fBodyAccMag_mean      | frequency  | mean | NA   | Magnitude of body acceleration
| fBodyAccMag_std       | frequency  | std  | NA   | 
| fBodyAccJerkMag_mean  | frequency  | mean | NA   | Magnitude of body acceleration jerk
| fBodyAccJerkMag_std   | frequency  | std  | NA   | 
| fBodyGyroMag_mean     | frequency  | mean | NA   | Magnitude of body rotaion
| fBodyGyroMag_std      | frequency  | std  | NA   | 
| fBodyGyroJerkMag_mean | frequency  | mean | NA   | Magnitude of body rotaional jerk
| fBodyGyroJerkMag_std  | frequency  | std  | NA   | 
