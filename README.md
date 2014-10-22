Getting-and-Cleaning-Data
=========================





* first we add the header to the data set. For doing this we read the table that contains the column names



* as we do not want all columns we extract the relevant columns
* select sql/like relevant columns



* we create two datasets - one that contains only the names and the other one that contains only the indexes of the columns


* then we load the observation data


* we subset from the data the relevant columns as we want only mean and std


* to the filtered data we add the column headers


* then we add the additional column that contains the subject who carried out the activity


* give a column name



* we merge the columns to the datasets


* now we add the column that contain the type of the activity


* give a column name


* again we merge the two datasets


* now we merge the two big data sets test and training


* now we need to convert the activity ids into real text labels
* add the activity names


*set column names


* match activity labels with data set


* there is a unnecessary column and therefore we drop it

* now we create the mean on all columns except the first two columns as they contain the activity and subject - we group 

* we need to re-name the first two columns as they changed there name from grouping


* data does not look so beautiful so we sort our output


*finally we write the output to a file

