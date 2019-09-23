function smoothy = smoothdata(data, span) %#codegen
n = length(data);
smoothy = zeros(1921,1);
for i = 1:n
    s = 0;
    if i<(span+1)/2
        for j = 1:i
            s = s + data(i-1+j);
        end
        smoothy(i) = s/j;
    elseif i>n-(span-1)/2
        for j = i:n
            s = s + data(j);
        end
        smoothy(i) = s/(n-i+1);
    else
        for j = 1:(span-1)/2
            s = s +  data(i-j) + data(i+j);         
        end
        s = s + data(i);
        smoothy(i) = s/span;
    end
end
end