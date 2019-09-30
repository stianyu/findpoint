clear;
clc;
dirname = 'D:\1 科研项目\2 凝血点\0923findpoint\DATA'; 
filelist = getallfiles(dirname);
%%
for i = 1:length(filenames)
    data = xlsread(filenames{i},'A2:F2000');
    time(i).ACT = data(:,1);
    time(i).FIB = data(:,2);
    time(i).TT = data(:,3);
    time(i).APTT = data(:,4);
    time(i).PT = data(:,5);
    time(i).clottingtime = data(1:4,5);
end
save('Sept11.mat','time')