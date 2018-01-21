run\_analysis.R
---------------

This code book is for a Data Science Course Module 3 assignment in R
that demonstrates the student's ability to collect, work with, and clean
a data set. Basically, this script aims to prepare tidy data that can be
used for later analysis. This script follows the following steps below:

Data Preperation and Acquisition
--------------------------------

The script will download the data from the source and checks if the file
and directories already exists. Else, it will download, extract (for the
case of zip files), and create the necessary director

Read and Merge the Data
-----------------------

The variables are as follows:

-   *subject\_test* - subject IDs for test variables
-   *subject\_train* - subject IDs for train variables
-   *x\_test* - values in test variables
-   *y\_test* - activity in test variables
-   *x\_train* - values in train variables
-   *y\_train* - activity in train variables
-   *activity\_labels* - decription of y\_test and y\_train
-   *features* - labels of the variables x\_test and x\_train

-   *x\_data* - joined x\_train and x\_test
-   *y\_data* - joined y\_train and y\_test
-   *subject\_data* - joined subject\_train and subject\_test

Extracts only the measurements mean and standard deviation for each measurement
-------------------------------------------------------------------------------

Create a vector of only mean and std labels, then use the vector to
subset x\_data

-   *meanandstd* - a vector containing only mean and std labels from the
    features variable
-   *x\_data* - after this step, this variable will only contain
    variables with mean and std

Change column labels of x\_data, y\_data, and subject\_data
-----------------------------------------------------------

Descriptive activity names were used to name the activities in the data
set and appropriately labels the data set with descriptive variable
names.

-   *featurenames* - a vector of features names without the "()"
-   *x\_data* - after this step, this variable will have its variables
    labeled as the *featurenames*
-   *subject\_data)* - this variable will have a label "subject"
-   *y\_data* - this variable will have a label "activity"
-   *data* - joined subject\_data, y\_data, and x\_data

Rename ID to acitivity name
---------------------------

Group the activity column of dataSet as "act", then rename each levels
with 2nd column of *activity\_labels*. Finally apply the renamed "act"
to data's activity column.

-   *act* - factored activity column of data

Output: Tidy Data
-----------------

From the result in the previous step a second, independently tidy data
set is created with the average of each variable for each activity and
each subject

-   *MeltedData* - melted data based on "subject" and "activity" from
    the variable *data*
-   *SecondDataSet* - the variable that contains the independently tidy
    data
