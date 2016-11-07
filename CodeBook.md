# Course Project Code Book

The dataset used in this project consists of two basic files:

1. activity_labels.txt
    <p>Consists of the id and label for each type of measured activity.</p>
    
2. features.txt
    <p>Consists of the id and label for each measured feature in the process.</p>

The dataset is also complemented by other files split into training and test data, each of them having:

1. subject_(test|train).txt
    <p>Consists of the ids of the subjects.</p>
    
2. X_(test|train).txt
    <p>Consists of the actual measured data for each subject and activity.</p>
    
3. y_(test|train).txt
    <p>Consists of the id of the activity associated to the set of measurements for a given record.</p>
    
### Regarding the data tidying process

The tidying process of the data consists of the following steps:

1. The activity_labels.txt table was loaded into the activities data frame.

2. The features.txt table was loaded into the features data frame.

3. A grep by mean or std was performed on the features' names in order to get the ids of the features relevant for the project and assign them to featuresIdx.

4. A get_data function was created to read the test/train data (using read.table) and filter it by the relevant features' indexes (using a regular filter by array index) and bind them with the activities and subjects tables (using cbind).

5. The train_data and test_data data frames were created using the get_data function, and subsequently merged with rbind, assigning to the data variable.

6. The activity and subject columns from the data variable were factorized and then an aggregate was performed on the data frame, calculating the mean by activity and subject.

7. After the aggregation the "subject" and "activity" columns were filled with NAs, so they were deleted using NULL assignment.

8. All the columns from the data frame were renamed so they could be less cryptic, applying the whole words that were abbreviated. Example: "fBodyBodyAccJerkMag.mean.." -> "Frequency Body Accelerometer Jerk Magnitude Mean"

9. The resulting table gets written to the tidy_data.txt file using write.table.