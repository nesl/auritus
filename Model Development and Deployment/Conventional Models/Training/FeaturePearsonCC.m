function [y] = FeaturePearsonCC(ar)
x = ar;
[a,b] = size(x);
y = zeros(a,1);
z = 1:b;
for i = 1:a
    v = corrcoef(z, x(i,:));
    y(i,1) = v(2,1);
end
clear x;
end

