%Automatic labeler used for processing head-pose data (origin-target A, target A to target B, target B to origin)

labMat = [7,3,1,6,2,5,3,4,9,8,10,18,18,13,14,11,22,17,19,12,21,25,15,27,27,10,27,19,10,19,16,17,20,21,6,4,14,22,25,27,11,18];

subject = 1; %alter subject number here
t = zeros(size(cursor_info,2),1);
for i = 1:size(cursor_info,2)
    t(size(cursor_info,2)-i+1,1) = cursor_info(i).Position(1);
end
pos=arrayfun(@(x) find(curfile(:,9)==x,1),t);
curfile(1:pos(2),1:7) = 0;
curfile(pos(end-2):end,1:7) = 0;
pos = pos(3:end-2);
t = t(3:end-2);
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
filename = strcat('sliced_HP_OTTO/',num2str(subject),'/',num2str(subject),'_','OTTO','.csv');
writematrix(filemat, filename);
clear;

