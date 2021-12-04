function [y] = FeatureSlopeSC(ar)
x = ar;
c = 0; 
[a,b] = size(x);
y = zeros(a,1);
for i = 1:a
    for j = 1:b-2
        if ((sign(x(i,j+1) - x(i,j))) ~= (sign(x(i,j+2) - x(i,j+1))))
            c = c+1;
        end
    end
    y(i,1) = c;
    c = 0;
end
clear x;
end


