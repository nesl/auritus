# Filter Development and Deployment Module

For prototyping and tuning head-pose filters with Bayesian optimization, we provide python and MATLAB scripts for complementary, Madgwick, Mahony and indirect extended Kalman filter. We recommend using the MATLAB IEKF script for prototyping IEKF, while using Python scripts to prototype Madgwick, Mahony and complementary filter. We also provide C implementations of the filters (Arduino and Mbed compatible) for all four filters for deployment on real-hardware
- The ```Python``` folder contains a ```requirements.txt``` file, where list of all Python dependencies are outlined. Note that the KF provided in Python is not IEKF, but EKF. We provide the Python scripts as Jupyter notebooks for easy prototyping and graph viewing.
- We provide simple head-movement data for tuning the filters. In ```Python```, the files are ```Acc.csv```, ```Gyro.csv``` and ```Or_GT.csv```. In ```MATLAB```, these three files are lumped into a ```.mat``` file.
- For the Madgwick filter and complementar filter, we tune the filter gains. For Mahony filter, we tune ```K_p```, though it is also possible to tune ```K_I```. For IEKF (in ```MATLAB```), we tune ```GyroscopeNoise```, ```AccelerometerNoise```, ```GyroscopeDriftNoise```, ```LinearAccelerationNoise``` and multiplier for ```InitialProcessNoise```. For EKF (in ```Python```). we tune ```GyroscopeNoise``` and ```AccelerometerNoise```.
- The C files have been tested in Arduino for Mbed-enabled and AVR-RISC microcontrollers. The Madgwick, Mahony and EKF filters are written to operate with MPU-9250 IMU breakout (https://learn.sparkfun.com/tutorials/mpu-9250-hookup-guide/all), while the complementary filter is written to operate with MPU-6050 IMU breakout (https://maker.pro/arduino/tutorial/how-to-interface-arduino-and-the-mpu-6050-sensor).

Useful documentation:

- AHRS Library for Python: https://ahrs.readthedocs.io/en/latest/
- Bayesian Optimization (ARM Mango): https://github.com/ARM-software/mango 
- Bayesian Optimization (MATLAB): https://www.mathworks.com/help/stats/bayesopt.html
- IEKF (MATLAB): https://www.mathworks.com/help/fusion/ref/ahrsfilter-system-object.html
- Madgwick and Mahony filters in C: https://github.com/sparkfun/SparkFun_MPU-9250_Breakout_Arduino_Library
- EKF for Attitude Estimation in C: https://github.com/pronenewbits/Arduino_AHRS_System
- Complementary Filter in C: https://github.com/stanleyhuangyc/Freematics/blob/master/firmware/datalogger/MPU6050.cpp

