userTime = 999;
a = arduino('/dev/tty.usbserial-A9M19JJ7', 'ProMini328_5V', 'Libraries', 'I2C'); %check device port from device manager
imu = mpu9250(a);
Fs = imu.SampleRate; %100 Hz
imufilt = imufilter('SampleRate',Fs);

%initialize orientation viewer and IMU
orientationScope = HelperOrientationViewer;
data = read(imu);
qimu = imufilt([0 0 0], [0 0 0]);
orientationScope(qimu);
imuOverruns = 0;

tic
while toc < userTime
    
    % Read from the IMU sensor.
    [data,overrun] = read(imu);
    if overrun > 0
        imuOverruns = imuOverruns + overrun;
    end
    data.AngularVelocity(:,1:2) = -data.AngularVelocity(:,1:2);
    % Fuse IMU sensor data to estimate the orientation of the sensor.
    qimu = imufilt(-data.Acceleration,data.AngularVelocity);
    orientationScope(qimu);
    pubVar = compact(qimu(10,:));
    stringA = "/usr/local/bin/mosquitto_pub -h arena-west1.conix.io -p 3003 -t realm/s/tutorialYoyo -m '{";
    stringB = sprintf('"object_id" : "camera_yoyo_yoyo", "action": "update", "type": "rig", "data": {"position": {"x":0,"y":0,"z":0},"rotation": {"x": %f, "y":%f ,"z":%f, "w":%f} }}',pubVar(1,1),pubVar(1,2),pubVar(1,3),pubVar(1,4));
    stringC = "'";
    stringCat = char(strcat(stringA,stringB,stringC));
    disp('New');
    disp(stringCat);
    [status,cmdout] = system(stringCat);
end
clear all;