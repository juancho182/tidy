README

These are the instructions to run the script for the assignment.
Download the code from the repository (run_analysis.R)

In the same folder location, paste the following files from original data assignment:

activity_labels.txt
features.txt
subject_test.txt
subject_train.txt
x_test.txt
x_train.txt
y_test.txt
y_train.txt

All those files are needed by the script and they must be placed in the same directory than the R source code file.

When opening the run_analysis.R file in RStudio, make sure that the working directory is set to the folder containing the R source file (and therefore, all the files
mentiones above as well). You can change the working directory using the setwd command in the console.

Next step is to select all the code in the R source file and copy it.

Paste the code into the console.

The script will run and it will produce two variables:

1. combined_set: contains the tidy dataset with no average calculations
2. avg_set: contains the final tidy dataset with the average calculations

Use any of those two variables to view the contents or manipulate as needed.