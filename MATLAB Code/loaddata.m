function [act, fib, tt, aptt, pt] = loaddata(filename, range, effnum, begin)
alldata = xlsread(filename, range);
act = alldata(begin(1):effnum, 1);
fib = alldata(begin(2):effnum, 2);
tt = alldata(begin(3):effnum, 3);
aptt = alldata(begin(4):end, 4);
pt = alldata(begin(5):effnum, 5);
end
