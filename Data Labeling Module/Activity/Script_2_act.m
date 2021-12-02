%Automated labeler used for processing activity data from graphical labels.

subject = 30; %alter subject number here

%input activity time ranges here (observed from acc/gyr plot (ground truth:
%camera) %input [0 0] in a activity if it is missing.
W = [cursor_info(18).Position(1)  cursor_info(17).Position(1)]; %walking
R = [cursor_info(16).Position(1)  cursor_info(15).Position(1)]; %running/jogging
St = [cursor_info(14).Position(1)  cursor_info(13).Position(1)]; %standing
J = [cursor_info(12).Position(1)  cursor_info(11).Position(1)]; %jumping
Tl = [cursor_info(10).Position(1)  cursor_info(9).Position(1)]; %turning left
Tr = [cursor_info(8).Position(1)  cursor_info(7).Position(1)]; %turning right
Si = [cursor_info(6).Position(1)  cursor_info(5).Position(1)]; %sitting
L = [cursor_info(4).Position(1)  cursor_info(3).Position(1)]; %laying
F = [cursor_info(2).Position(1)  cursor_info(1).Position(1)]; %falling
RangeMat = [W;R;St;J;Tl;Tr;Si;L;F]; %You can specify which activities are present here. If some activity is not present, remove the corresponding variable name from the array

Varnames = {'W' 'R' 'St' 'J' 'Tl' 'Tr' 'Si' 'L' 'F'}; %Do the same here
for i = 1:length(RangeMat)
    if (RangeMat(i,2) - RangeMat(i,1) ~= 0)
        [~,lowerbound] = min(abs(curfile(:,9) - RangeMat(i,1)));
        [~,upperbound] = min(abs(curfile(:,9) - RangeMat(i,2)));
        temp = curfile(lowerbound:upperbound,2:9);
        timeval = temp(1,8);
        for j = 1:size(temp,1)
            temp(j,8) = temp(j,8) - timeval;
        end
        temp(:,7) = [];
        if(~isfolder(strcat('sliced/',num2str(subject))))
            mkdir(strcat('sliced/',num2str(subject)))
        end
        filename = strcat('sliced/',num2str(subject),'/',num2str(subject),'_',string(Varnames(1,i)),'.csv');
        writematrix(temp, filename); %directory is current directory;
    end
end
clear
