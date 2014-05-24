gettingandcleaningdata-project
==============================


Daljeet Arora
daljeet_arora@yahoo.com


This readme presents the assumptions and steps used to generate a tidy dataset as per the requirements stated in the course project in 'Getting and Cleaning Data' course in Coursera.org. 

Refer to 'Getting and Cleaning Data' course in Coursera.org for more details.


###Objective of the course project:
The course project aims to create a tiny dataset from the given raw data that represents the mean of values of all the features for each subject & activity.


###Raw Data:

The data for the project represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The data represents the output of the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
	
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The obtained dataset has been processed and each record reprsents:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###The dataset includes the following files:

- 'README.md'

- 'run_analysis.R': Contains the processing logic that produces the tidy set

- 'tidy_set.csv': Tidy dataset

- 'codebook.md': Describes the variables, the data and transformations applied to define the tidy dataset 

The script uses the raw data present in different files. Refer to the Raw Data section for more details


###How the script works: 

The script run_analysis.R is based on the following steps:
(the same steps are for test data)

- reads in the data for training data for training set, training labels & subject
- combines the above data, column wise to get the complete data for training
- completed data for training and test are then combined row wise to get the merged data
- updates the merged dataset with column names for each of the features column
- extracts the columns contining only mean and standard deviation results
- replaces the activity codes with activity labels
- calculates the average of each of the columns from the above dataset
- finally the average dataset is output to a file tidy_dataset.csv

###License:
I provide full freedom to the use of this dataset in publications. You can reference to my name if you so desire.
