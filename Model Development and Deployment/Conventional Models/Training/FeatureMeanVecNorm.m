function [y] = FeatureMeanVecNorm(ar)
x = ar;
[a,~] = size(x);
y = zeros(a,1);
for i = 1:a
    z = sqrt(sum(x(i,:).^2));
    y(i,1) = mean(x(i,:)./z);              
end
clear x;
end

