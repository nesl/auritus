function [y] = FeatureMeanMovMad(ar)
x = ar;
[a,b] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = mean(movmad(x(i,:),b/5));
end
clear x;
end

