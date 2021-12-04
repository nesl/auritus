clear;
clc;
load y120p60r30.mat;
accNED = motion.Acceleration;
angVelNED = motion.AngularVelocity;
orientationNED = motion.Orientation;
numSamples = size(motion.Orientation,1);
t = (0:(numSamples-1)).'/fs;

IMU = imuSensor('accel-gyro','SampleRate',fs); 

IMU.Accelerometer = accelparams( ...
    'MeasurementRange',19.62, ...
    'Resolution',0.00059875, ...
    'ConstantBias',0.4905, ...
    'AxesMisalignment',2, ...
    'NoiseDensity',0.003924, ...
    'BiasInstability',0, ...
    'TemperatureBias', [0.34335 0.34335 0.5886], ...
    'TemperatureScaleFactor',0.02);
IMU.Gyroscope = gyroparams( ...
    'MeasurementRange',4.3633, ...
    'Resolution',0.00013323, ...
    'AxesMisalignment',2, ...
    'NoiseDensity',8.7266e-05, ...
    'TemperatureBias',0.34907, ...
    'TemperatureScaleFactor',0.02, ...
    'AccelerationBias',0.00017809, ...
    'ConstantBias',[0.3491,0.5,0]);

GyroscopeNoise = optimizableVariable('GyroscopeNoise',[0,1],'Type','real');
AccelerometerNoise = optimizableVariable('AccelerometerNoise',[0,1],'Type','real');
GyroscopeDriftNoise = optimizableVariable('GyroscopeDriftNoise',[0,1],'Type','real');
LinearAccelerationNoise = optimizableVariable('LinearAccelerationNoise',[0,1],'Type','real');
InitialProcessNoiseMult = optimizableVariable('InitialProcessNoiseMult',[1,20],'Type','real');

fun = @(x) iekf_func(x, fs, IMU, accNED, angVelNED, orientationNED, numSamples);
results = bayesopt(fun, [GyroscopeNoise, AccelerometerNoise,GyroscopeDriftNoise,LinearAccelerationNoise,InitialProcessNoiseMult],'MaxObjectiveEvaluations',50);


aFilter = imufilter('SampleRate',fs);
aFilter.GyroscopeNoise          = results.XAtMinEstimatedObjective.GyroscopeNoise;
aFilter.AccelerometerNoise      = results.XAtMinEstimatedObjective.AccelerometerNoise;
aFilter.GyroscopeDriftNoise     = results.XAtMinEstimatedObjective.GyroscopeDriftNoise;
aFilter.LinearAccelerationNoise = results.XAtMinEstimatedObjective.LinearAccelerationNoise;
aFilter.InitialProcessNoise     = aFilter.InitialProcessNoise*results.XAtMinEstimatedObjective.InitialProcessNoiseMult;

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
