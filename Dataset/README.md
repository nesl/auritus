# Dataset Usage Guide
There are three main folders in the dataset, namely ```Activity Detection```, ```Simple Head Pose``` and ```Complex Head Pose```. It also contains physiological information about participants in the file ```Participant_Info.csv```, target information for simple and complex head pose in the file ```HP_target_info.csv```, and the IRB approval in the file ```IRB_Approval.pdf```. Simple head pose corresponds to head movements from a origin marker to a target marker and back. Complex head pose corresponds to head movements from a origin marker to target marker A, target marker A to target marker B, and target marker B to origin. Since the dataset is large, we provide Google Drive links for the data in the three folders.
### Target Information

```HP_target_info.csv``` provides the azimuth angle (deg.), elevation angle (deg.) and distance (inches) of each head-pose target marker in the experimental testbed, quantified using a laser rangefinder. There are 27 targets (excluding the origin marker, labelled as 0)

### Participant Information
```Participant_Info.csv``` contains gender, age, weight, height and ear height from origin for all 45 participants. It also contains a column titled 'HP_ver', which says which targets were used in the simple head movements for each participant:
- A: 2, 7, 12, 24, 22, 26, 18, 19, 3, 17, 26, 10, 13
- B: 4, 1, 14, 25, 23, 22, 9, 21, 5, 6, 27, 16, 21

### Activity Detection
- This folder contains human activity data for 9 classes (walking, jogging, jumping, standing, sitting, tuning left, turning right, laying down, and falling) of basic ADL. 
- There are two subfolders in this folder, one contains sliced activity data, with each activity in separate ```.csv``` file, and the other contains raw continuous trajectories, with all the activities one after the other in one ```.csv``` file. 
- Each of these two subfolders are further divided into participant specific folders, with the folder names corresponding to participant ID (e.g., 1, 2, 3, ..... , 45).
- The sampling rate was set to 100 Hz, however, there is sampling rate jitter and missing data in the dataset due to packet drops and timestamp misalignment. A low-pass filter of 5 Hz was used, and the accelerometer and gyroscope ranges were set to +- 4g and +- 500 deg/s. The BLE advertisement and connection intervals were set to 45-55 mS and 20-30 mS.
- No ground truth is provided due to privacy concerns. However, for the continuous trajectories, each activity is separated by calibration nods (for subjects 16 to 45), which are visible in the gyroscope plot. More details are provided in the data labelling module.
##### File Structure
- The first three columns of each ```.csv``` file for sliced activities provide the accelerometer readings (in g), the next three columns provide gyroscope readings (in deg/s).
- The seventh column for sliced activities correspond to timestamp (in sec.)
- For sliced activities, the last character before each ```.csv``` file corresponds to the activity: F - Falling, J - Jumping, R - Running/Jogging, Si - Sitting, St: Standing, Tl: Turning Left, Tr: Turning Right, W: Walking.
- For continuous activities, the first column corresponds to UNIX timestamps, the last six columns correspond to accelerometer and gyroscope readings.

### Simple and Complex Head Pose
- The folders are split into participant specific folders, with the folder names corresponding to participant ID (e.g., 1, 2, 3, ..... , 45).
- Each folder contains four files.
- The same sampling rate, filter specifications, sensor bandwidth and BLE specifications were used as in the activity detection.

##### File Structure
- The ```.tak``` and ```.c3d``` files contain visual ground truth head-movements captured using Optitrack MoCap system (exported at 30 FPS). The ```.tak``` file can be opened in Motive:Tracker (https://optitrack.com/software/motive/). If you do not have Motive:Tracker, you can open the ```.c3d``` file using Mokka (http://biomechanical-toolkit.github.io/), which is available free of charge for Windows and MacOS. 
- The ```.csv``` file with the letters "TD" contains quantitative information (e.g. rotation in Euler angles) about ground truth head-movements, exported from the ```.tak``` file using Motive:Tracker. This is useful if you want to relabel the dataset yourself without visual aid. You can extract the same information from the ```.tak``` and ```.c3d``` files.
- **Simple Head Pose IMU Data**: For simple head pose, the remaining ```.csv``` file contains the head-movement information captured by the IMU in the earable. The first three columns provide the accelerometer readings (in g), the next three columns provide gyroscope readings (in deg/s). The seventh column correspond to timestamp (in sec.). The eighth column corresponds to each of 27 targets, while the ninth column corresponds to whether head movement is happening from origin to target (1) and target to origin (0). If eighth column is 0, then ninth column does not correspond to anything.
- **Complex Head Pose IMU Data**: For complex head pose, the remaining ```.csv``` file contains the head-movement information captured by the IMU in the earable. The first three columns provide the accelerometer readings (in g), the next three columns provide gyroscope readings (in deg/s). The seventh column correspond to timestamp (in sec.). The eighth and ninth column corresponds to each of 27 targets, while the tenth column corresponds to whether head movement is happening from origin to target A (1) target A to target B (2), and target B to origin (3). In particular, for the eighth and ninth columns, when head movement occurs from target A to target B, the columns contain ID of target A and target B, respectively. If eighth and ninth column is 0, then tenth column will be 0 (not correspond to anything.)



