function [y] = FeatureVar(ar)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = var(x(i,:));
end
clear x;
end

