# Getting and Cleaning Data Course Project - Tidy Data
## Codebook

### Renamed Variables
In general, my "run_analysis.r" script merely simplifies and reshapes the data contained 
in the UCI HAR dataset, consolidating the data contained across several .txt files in the 
original dataset into a single table in a single .txt file.

However, the original labels for the dataset's variables (as contained in the "features.txt"
file) were abbreviated for concision's sake at the expense of clarity. Thus, part of "run_analysis.r"'s
function is to replace the original name with an expanded, clearer label.

A simple for loop in the script passes through each variable's name, identifies the separate 
abbreviated segments, and replaces them with an entire word, indicating what was measured. 
Each word replacement is described in the list below, indicating what each measurement 
achieved. This file can be used in conjunction with "features_info.txt" to achieve a fuller 
understanding of the measurement's purpose.

* **Time:** replaces **t** at the start of a variable name; indicates this measurement was a 
time domain signal; mutually exclusive with Frequency
* **Frequency:** replaces **f** at the start of a variable name; indicates this measurement 
was a frequency domain signal; mutually exclusive with Time
* **Body:** replaces **Body** within a variable name; indicates an acceleration signal from 
the body; mutually exclusive with Gravity
* **Gravity:** replaces **Gravity** within a variable name; indicates an acceleration signal
from gravity; mutually exclusive with Body
* **Accelerometer:** replaces **Acc** within a variable name; indicates a measurement taken 
from the accelerometer; mutually exclusive with Gyroscope
* **Gyroscope:** replaces **Gyro** within a variable name; indicates a measurement taken from 
the gyroscope; mutually exclusive with Accelerometer
* **Jerk:** replaces **Jerk** within a variable name; indicates a jerk signal derived from
Body linear acceleration and angular velocity
* **Magnitude:** replaces **Mag** within a variable name; indicates the magnitude of a signal,
calculated using the Euclidean norm
* **Mean:** replaces **-mean()** within a variable name; indicates the mean measurement of the 
variable
* **Standard Deviation:** replaces **-std()** within a variable name; indicates the standard 
deviation of the variable
* **(X):** indicates the variable measurement on the X direction
* **(Y):** indicates the variable measurement on the Y direction
* **(Z):** indicates the variable measurement on the Z direction
