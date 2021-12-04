function [y] = FeatureMean(ar)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = mean(x(i,:));
end
clear x;
end

