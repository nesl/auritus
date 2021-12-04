function [y] = FeatureMeanAutoCor(ar)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    v = xcorr(x(i,:));
    y(i,1) = mean(v);
end
clear x;
end

