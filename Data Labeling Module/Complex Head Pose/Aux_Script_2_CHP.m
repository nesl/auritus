%Automatic labeler used for processing head-pose data (origin-target A, target A to target B, target B to origin)
% (auxiliary, used by us for labeling from endpoints stored in a .mat file)

labMat = [7,3,1,6,2,5,3,4,9,8,10,18,18,13,14,11,22,17,19,12,21,25,15,27,27,10,27,19,10,19,16,17,20,21,6,4,14,22,25,27,11,18];
subject = 5; %alter subject number here
load(string(strcat('data endpoints/subject',{' '},num2str(subject),'/Range.mat')));
t = seqdouble(:,3);
for i = 1:size(t)
    [~,pos(i)]=min(abs(curfile(:,9)-t(i)));
end
pos = pos';
curfile(1:pos(1),1:7) = 0;
curfile(pos(end-1):end,1:7) = 0;
labels = zeros(size(curfile,1),3);
k = 1;
for i = 1:6:size(pos,1)-5
    temp(k) = i;
    k = k+1;
end
temp = temp';
k = 1;
counter = 1;
for i = 1:size(temp,1)  
    labels(pos(counter):pos(counter+1),3) = 1; %origin to target A
    labels(pos(counter):pos(counter+1),1) = labMat(k);
    labels(pos(counter):pos(counter+1),2) = labMat(k+1);
    
    labels(pos(counter+2):pos(counter+3),3) = 2;% target A to target B
    labels(pos(counter+2):pos(counter+3),1) = labMat(k);
    labels(pos(counter+2):pos(counter+3),2) = labMat(k+1);    
    
    labels(pos(counter+4):pos(counter+5),3) = 3;% target B to origin
    labels(pos(counter+4):pos(counter+5),1) = labMat(k);
    labels(pos(counter+4):pos(counter+5),2) = labMat(k+1);     
    k = k+2;
    if(i < size(temp,1))
        counter = temp(i+1); 
    end
end
curfile = curfile(pos(1):pos(end),:);
labels = labels(pos(1):pos(end),:);
curfile(:,9) = curfile(:,9)-curfile(1,9);
curfile(:,8) = [];
curfile(:,1) = [];
filemat = [curfile, labels];
if(~isfolder(strcat('sliced_HP_OTTO/',num2str(subject))))
    mkdir(strcat('sliced_HP_OTTO/',num2str(subject)))
end
filename = strcat('sliced_HP_OTTO/',num2str(subject),'/',num2str(subject),'_','OT1T2O','.csv');
writematrix(filemat, filename);
clear;

