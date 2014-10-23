What run_analysis.R does
=========================


The following steps show what the code does:


* first we add the header to the data set. For doing this we read the table that contains the column names
* as we do not want all columns we extract the relevant columns (mean and standard deviation)
* use "select" sql/like relevant columns
* out of the reduced data set that contains the column names and column indexes we create two datasets - one that contains only the names and the other one that contains only the indexes of the columns
* then we load the observation data
* we subset from the data the relevant columns as we want only mean and std. to do this we use from the colum data set the indexes of the relevant columns
* to the filtered data we add the column headers
* then we add the additional column that contains the subject who carried out the activity
* we give a column name to the data set 
* we merge the columns to the two datasets (test and traing)
* now we add the column that contain the type of the activity
* again we give the column a name
* again we merge the two datasets
* now we merge the two big data sets "test" and "training" so that we end up with one big dataset that contains all data we need
* now we need to convert the activity ids into real text labels (Walking, ...) for doing this we first load from txt file
* set column names of the two data sets
* join activity labels with data set
* now there is an unnecessary column - the id of the activity - and therefore we drop it
* now we create the mean on all columns except the first two columns as they contain the activity and subject - we group by these two parameters
* we need to re-name the first two columns as they changed their name from grouping
* the resulting data does not look so beautiful so we sort our output
* finally we write the output to a file - and we are done  :-)

