clear, clc %清除变量
close all
filename = 'D:\1 科研项目\2 凝血点\数据9.11\9.xls';
range = 'A2:E3000';
effnum = 2000;
begin = 1*ones(1,5);
[act, fib, tt, aptt, pt] = loaddata(filename, range, effnum, begin);
data = tt;
P = findpoint(data);




