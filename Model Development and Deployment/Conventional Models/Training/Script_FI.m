Feat = readmatrix('FeatMat.csv');
Feat(isnan(Feat))=0;
Lab = readmatrix('Labelmat.csv');
ix = randperm(size(Feat,1));
F = Feat(ix,:);
L = Lab(ix,:);
%L = (L==1:9); %(uncomment this when you want one-hot encoded labels (for
%MLP training only)
clear Feat ix Lab;