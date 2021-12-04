function [y] = FeatureIntegration(ar,t)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    y(i,1) = trapz(t, x(i,:));
end
clear x;
end

