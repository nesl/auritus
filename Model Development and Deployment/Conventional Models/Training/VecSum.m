function [y] = VecSum(ar1,ar2,ar3)
x1 = ar1;
x2 = ar2;
x3 = ar3;
[a,b] = size(x1);
y = zeros(a,b);
for i = 1:a
    y(i,:) = sqrt(x1(i,:).^2 + x2(i,:).^2 + x3(i,:).^2);
end
clear x1;
clear x2;
clear x3;
end

