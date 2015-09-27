# datasciencecoursera - explenation of run_analysis.R for the Getting and Cleaning data course project
datasciencecoursera

The script first loads the six activity labels and the features of the data.
After loading the features, all means and stdv's are searched using the grep function to only subset on those columns.
The features_mean_and_stdv is used to subset only the means and stdv's.
The function read.table is used to load for train and test data the:
- Sensor data (accelerations)
- The activities (6 in total)
- The different subjects that did the tests. (30 in total)
The above three data is joined using the function cbind (for binding on columns) for train and test data.
Then the train and test is appended using rbind (for binding on rows).

SUbsequently, the column names are changed to subject, acitivity and the desired features (with mean and stdv in the name).

Then the data is categorized and sorted, with the melt function, on the subjects and activities.
Finally, for each subject and activity the means are calculated and written to a file tidy.txt using respectivelly dcast and write.table.


