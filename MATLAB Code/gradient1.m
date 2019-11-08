function yapp1 = gradient1(x0)
for i = 1:length(x0)
    if i == 1
        yapp1(i,1) = x0(2) - x0(1);
    elseif i == length(x0)
        yapp1(i,1) = x0(i) - x0(i-1);
    else
        yapp1(i,1) = (x0(i+1) - x0(i-1)) / 2;
    end
end
end