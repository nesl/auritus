userTime = 180; %duration of demo
%binaural audio demo using MPU9250 and Arduino Nano
a = arduino('COM5', 'ProMini328_5V', 'Libraries', 'I2C'); %check device port from device manager
imu = mpu9250(a);
Fs = imu.SampleRate; %100 Hz
imufilt = imufilter('SampleRate',Fs);

%load necessary parts of ARIDataset and modify the parameters
ARIDataset = load('ReferenceHRTF.mat');
hrtfData = double(ARIDataset.hrtfData);
hrtfData = permute(hrtfData,[2,3,1]);
sourcePosition = ARIDataset.sourcePosition(:,[1,2]);
sourcePosition(:,1) = sourcePosition(:,1) - 180;

%load the audio file
[heli,sampleRate] = audioread('Heli_16ch_ACN_SN3D.wav');
heli = 12*heli(:,1); % keep only one channel
sigsrc = dsp.SignalSource(heli, ...
    'SamplesPerFrame',sampleRate/10, ...
    'SignalEndAction','Cyclic repetition');
deviceWriter = audioDeviceWriter('SampleRate',sampleRate);
FIR = cell(1,2);
FIR{1} = dsp.FIRFilter('NumeratorSource','Input port');
FIR{2} = dsp.FIRFilter('NumeratorSource','Input port');

%initialize orientation viewer and IMU
orientationScope = HelperOrientationViewer;
data = read(imu);
qimu = imufilt([0 0 0], [0 0 0]);
orientationScope(qimu);
imuOverruns = 0;
audioUnderruns = 0;
audioFiltered = zeros(sigsrc.SamplesPerFrame,2);

tic
while toc < userTime
    
    % Read from the IMU sensor.
    [data,overrun] = read(imu);
    if overrun > 0
        imuOverruns = imuOverruns + overrun;
    end
    data.AngularVelocity(:,1:2) = -data.AngularVelocity(:,1:2);
    % Fuse IMU sensor data to estimate the orientation of the sensor.
    qimu = imufilt(data.Acceleration,data.AngularVelocity);
    orientationScope(qimu);
    
    % Convert the orientation from a quaternion representation to pitch and yaw in Euler angles.
    ypr = eulerd(qimu,'zyx','frame');
    yaw = ypr(end,1);
    pitch = ypr(end,2);
    desiredPosition = [yaw,pitch];
    fprintf('Azimuth: %f, Elevation: %f\n',yaw,pitch);
    
        % Obtain a pair of HRTFs at the desired position.
    interpolatedIR = squeeze(interpolateHRTF(hrtfData,sourcePosition,desiredPosition));
    
    % Read audio from file   
    audioIn = sigsrc();
             
    % Apply HRTFs
    audioFiltered(:,1) = FIR{1}(audioIn, interpolatedIR(1,:)); % Left
    audioFiltered(:,2) = FIR{2}(audioIn, interpolatedIR(2,:)); % Right    
    audioUnderruns = audioUnderruns + deviceWriter(squeeze(audioFiltered)); 
end

release(sigsrc)
release(deviceWriter)
clear all;