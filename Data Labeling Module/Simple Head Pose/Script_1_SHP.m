% Run this script to generate graphical plot of head-pose data (gyroscope x-y-z)

curfile = readmatrix('10/RAW_0.txt'); %input raw earable file here
curfile = curfile(all(~isnan(curfile),2),:); % for nan - rows
d = datetime(curfile(:,1),'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MMM-yyyy HH:mm:ss.SSSS','TimeZone','UTC');
d.TimeZone='-08:00'; %input timezone in UTC format here to generate timestamps
temp = zeros(length(d),1);
for i = 1:length(d)
    temp(i,1) = milliseconds(d(i,1) - d(1,1));
end
curfile(:,8) = temp;
curfile(:,9) = temp/1000.0;
clear ans temp i 
subplot 311
plot(curfile(:,9),curfile(:,5));
title('GyrX');
grid minor
subplot 312
plot(curfile(:,9),curfile(:,6));
title('GyrY');
grid minor
subplot 313
plot(curfile(:,9),curfile(:,7));
title('GyrZ');
grid minor
