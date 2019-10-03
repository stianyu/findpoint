function smoothy = smoothdata(data, span, dim) %#codegen
%MOVING AVERAGE FILTER. data could be a matrix, span should be a odd.
m = size(data, 1); n = size(data, 2);
if mod(span,2) == 0
    span = span - 1;
end
if dim == 2
    t = m;
    m = n;
    n = t;
end
smoothy = zeros(m, n);
for l = 1:n
    for i = 1:m
        s = 0;
        if i<(span+1)/2
            for j = 1:i
                s = s + data(i-1+j,l);
            end
            smoothy(i,l) = s/j;
        elseif i>m-(span-1)/2
            for j = i:m
                s = s + data(j,l);
            end
            smoothy(i,l) = s/(m-i+1);
        else
            for j = 1:(span-1)/2
                s = s +  data(i-j,l) + data(i+j,l);         
            end
            s = s + data(i,l);
            smoothy(i,l) = s/span;
        end
    end
end
end