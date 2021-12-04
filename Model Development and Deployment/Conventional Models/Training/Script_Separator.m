load('FeatMat.csv');
load('Labelmat.csv');
for k = 1:9
    j = 1;
    for i = 1:length(FeatMat)
        if(Labelmat(i)==k)
            Z(j,:) = FeatMat(i,:);
            L(j) = Labelmat(i);
            j = j+1;
        end
    end
    filename = strcat(string(k),'.csv');
    writematrix(Z, filename);
    filename = strcat(string(k),'L.csv');
    writematrix(L, filename);
end        