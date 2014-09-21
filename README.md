<<<<<<< HEAD
Unless the working directory contains file called "projectData.ZIP",
the script will download a file from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
and then unzips it into directory called "UCI HAR Dataset".

The script then  reads the test and training text files, as well as other relevant files.
The clean function will then loop trough every line and transforms them into numeric vectors
which it will then bind into a data.frame

!!IMPORTANT!!
If you try to run the script, beware that the clean function will take VERY
long time to clean the train_x.txt file.

After that the script subsets the and leaves only the columns for mean 
and standard deviation, as well as clen the column names.

The last part of the script will make a tidy dataset giving the average
for every subject by every activity.


=======
tidydata
========

Repository for the Coursera data cleaning project
>>>>>>> 6d34a01238039f0377b0f1fa99ef124eeac4e804
