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
for k = 1:n
    for i = 1:m
        s = 0;
        if i<(span+1)/2
            for j = 1:i
                s = s + data(i-j-1,k) + data(i+j-1,k);
            end
            smoothy(i,k) = (s - data(i,k))/(2*i-1);
        elseif i>m-(span-1)/2
            for j = 1:m-i
                s = s + data(i-j-1,k) + data(i+j-1,k);
            end
            smoothy(i,k) = (s - data(i,k))/((m-i)*2+1);
        else
            for j = 1:(span-1)/2
                s = s +  data(i-j,k) + data(i+j,k);         
            end
            s = s + data(i,k);
            smoothy(i,k) = s/span;
        end
    end
end
end