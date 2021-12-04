function [y] = FeaturetimeWindow(t)
x = t;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = x(1,end)-x(1,1);
end
clear x;
end