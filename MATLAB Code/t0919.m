clear, clc %�������
close all
filename = 'D:\1 ������Ŀ\2 ��Ѫ��\����9.11\9.xls';
range = 'A2:E3000';
effnum = 2000;
begin = 1*ones(1,5);
[act, fib, tt, aptt, pt] = loaddata(filename, range, effnum, begin);
data = tt;
P = findpoint(data);




