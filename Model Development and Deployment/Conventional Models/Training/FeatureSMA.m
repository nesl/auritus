function [y] = FeatureSMA(ar)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = sum(x(i,:));
end
clear x;
end

