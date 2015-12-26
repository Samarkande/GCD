
## "Code Book"

This code book gives information on data sets used for this project, as well steps in the R script ([run_analysis.R](https://github.com/Samarkande/GCD/blob/master/run_analysis.R)) to get the required output tidy data set ([mytidydata.txt](https://github.com/Samarkande/GCD/blob/master/mytidydata.txt)). 

### Data source

The R script takes the data set from  the ["Human Activity Recognition Using Smartphones"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) via this [*.zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) (UCI HAR Dataset repertory).


### Files and variables (in UCI HAR Dataset repertory)

* **```features.txt```**: Names of the 561 features
* **```activity_labels.txt```**: Names and IDs for each of the 6 activities
* **```X_train.txt```**: 7352 observations of the 561 features, for 21 of the 30 volunteers
* **```subject_train.txt```**: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in X_train.txt
* **```y_train.txt```**: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in X_train.txt
* **```X_test.txt```**: 2947 observations of the 561 features, for 9 of the 30 volunteers
* **```subject_test.txt```**: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in X_test.txt
* **```y_test.txt```**: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in X_test.txt


More information about files and variables are available in **README.txt** and **features_info.txt** of the repertory.

**Note:** Inertial Signals repertories are not used.   

### The processing steps (in the R script) 
 
1. All the needed files are read into data frames. Appropriate column names are assigned and the training/test data sets 
are combined into a single data set. Only features related to the mean and standard deviation measurements are taken into account. 
2. A tidy data set is created containing the mean of the above features according to subjects and their activities.
3. The output tidy data set is created in a *.txt format.

