% 1 = +ve, 0 = -ve
function [y] = FeatureDS(ar)
x = ar;
c = 0; %positive variable
d = 0; %negative variable
[a,b] = size(x);
y = zeros(a,1);
for i = 1:a
    for j = 1:b
        if (x(i,j) >= 0)
            c = c+1;
        else 
            d = d+1;
        end
    end
    if (c >= d)
        y(i,1) = 1;
    else
        y(i,1) = 0;
    end
    c = 0;
    d = 0;
end
clear x;
end

