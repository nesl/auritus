% Run this script to generate graphical plot of activity data (gyroscope x)

curfile = readmatrix('12/RAW_2.txt'); %input raw earable file here
curfile = curfile(all(~isnan(curfile),2),:); % for nan - rows
d = datetime(curfile(:,1),'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MMM-yyyy HH:mm:ss.SSSS','TimeZone','UTC');
d.TimeZone='-08:00';
temp = zeros(length(d),1);
for i = 1:length(d)
    temp(i,1) = milliseconds(d(i,1) - d(1,1));
end
curfile(:,8) = temp;
curfile(:,9) = temp/1000;
clear ans temp i 
plot(curfile(:,9),curfile(:,5))
xticks(curfile(1,9):10:curfile(end,9));
