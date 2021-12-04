function [y] = FeatureNorm(ar)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = norm(x(i,:));
end
clear x;
end

