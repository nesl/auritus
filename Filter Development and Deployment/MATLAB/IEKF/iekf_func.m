function [error] = iekf_func(x,fs,IMU,accNED,angVelNED,orientationNED,numSamples)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    aFilter = imufilter('SampleRate',fs); 
    aFilter.GyroscopeNoise = x.GyroscopeNoise;
    aFilter.AccelerometerNoise = x.AccelerometerNoise;
    aFilter.GyroscopeDriftNoise     = x.GyroscopeDriftNoise;
    aFilter.LinearAccelerationNoise = x.LinearAccelerationNoise;
    aFilter.InitialProcessNoise     = aFilter.InitialProcessNoise*x.InitialProcessNoiseMult;
    orientationNondefault = zeros(numSamples,1,'quaternion');
    acc = zeros(numSamples,3);
    gyro = zeros(numSamples,3);
    for i = 1:numSamples
        [accelBody,gyroBody] = IMU(accNED(i,:),angVelNED(i,:),orientationNED(i,:));
        acc(i,:,:) = accelBody;
        gyro(i,:,:) = gyroBody;
        orientationNondefault(i) = aFilter(accelBody,gyroBody);
    end
    release(aFilter) 
    filt_ang = eulerd(orientationNondefault,'ZYX','frame');
    act_ang = eulerd(orientationNED,'ZYX','frame');


    az_MAE = mean(abs(filt_ang(:,1)-act_ang(:,1)));
    ele_MAE = mean(abs(filt_ang(:,2)-act_ang(:,2)));
    error = az_MAE + ele_MAE;
end

