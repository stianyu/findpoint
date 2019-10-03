clear;
clc;
dirname = 'D:\1 科研项目\2 凝血点\0923findpoint\DATA'; 
filelist = getallfiles(dirname);
%%
n = length(filelist);
range = 1999;
egnorenum = 49;
acrange = range - egnorenum;
ACT = zeros(acrange,n);FIB = zeros(acrange,n);TT = zeros(acrange,n);
APTT = zeros(acrange,n);PT = zeros(acrange,n);ct = zeros(4,n);
for i = 1:length(filelist)
    data = xlsread(filelist{i},'A2:F2000');
    ACT(:,i) = data(egnorenum+1:end,1);
    FIB(:,i) = data(egnorenum+1:end,2);
    TT(:,i) = data(egnorenum+1:end,3);
    APTT(:,i) = data(egnorenum+1:end,4);
    PT(:,i) = data(egnorenum+1:end,5);
    ct(:,i) = data(1:4,6)*10;
end
%%
save('ACT.mat','ACT')
save('FIB.mat','FIB')
save('TT.mat','TT')
save('APTT.mat','APTT')
save('PT.mat','PT')
index = find(ct == 0);
ct(index) = egnorenum + 1;
ct = ct - egnorenum;
save('ct.mat','ct')

%%
% FIB = normalize(FIB,2);
function normal = normalize(data, dim)
%normalization
mindata = min(data,[],dim);
maxdata = max(data,[],dim);
normal = (data - mindata)./(maxdata - mindata);
end
