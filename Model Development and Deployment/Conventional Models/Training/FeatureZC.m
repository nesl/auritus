function [y] = FeatureZC(ar)
x = ar;
[a,b] = size(x);
y = zeros(a,1);
for i = 1:a
    c = 0; 
    for j = 1:b-1
        if ((x(i,j) < 0 && x(i,j+1) > 0) || (x(i,j) > 0 && x(i,j+1) < 0))
            c = c+1;
        end
    end
    y(i,1) = c;
end
clear x;
end


