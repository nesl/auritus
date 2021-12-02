%Automatic labeler used for processing simple head-pose data (origin-target-origin) from graphical labels (auxiliary, used by us for labeling from endpoints stored in a .mat file)

labMat = [2,7,12,24,22,26,18,19,3,17,26,10,13]; %You can specify which head-pose movements are present here. If some movement is not present, remove the corresponding variable name from the array, HP_Ver = A
%labMat = [4,1,14,25,23,22,9,21,5,6,27,16,21]; %HP_Ver = B
subject = 13; %alter subject number here
load(string(strcat('old/data endpoints/subject',{' '},num2str(subject),'/Range.mat')));
t = seqsingle(:,2);
for i = 1:size(t)
    [~,pos(i)]=min(abs(curfile(:,9)-t(i)));
end
curfile(1:pos(1),1:7) = 0;
curfile(pos(end-1):end,1:7) = 0;
labels = zeros(size(curfile,1),2);
k = 1;
counter = 1;
for i = 1:2:(size(pos,2)-1)
    labels(pos(i):pos(i+1),1) = labMat(k); 
    if(rem(counter,2) == 0)
        labels(pos(i):pos(i+1),2) = 0; %target to origin
        k = k+1;
    else
        labels(pos(i):pos(i+1),2) = 1; %origin to target
    end   
    counter = counter + 1;
end
curfile = curfile(pos(1):pos(end),:);
labels = labels(pos(1):pos(end),:);
curfile(:,9) = curfile(:,9)-curfile(1,9);
curfile(:,8) = [];
curfile(:,1) = [];
filemat = [curfile, labels];
if(~isfolder(strcat('sliced_HP/',num2str(subject))))
    mkdir(strcat('sliced_HP/',num2str(subject)))
end
filename = strcat('sliced_HP/',num2str(subject),'/',num2str(subject),'_','OTO','.csv');
writematrix(filemat, filename);
clear;
