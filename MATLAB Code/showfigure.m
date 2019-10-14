close all
clear all
load('ct.mat')
load('TT.mat')
egnorenum = 49;
TT = TT(egnorenum+1:end,:);
index = find(ct == 1);
ct(index) = egnorenum + 1;
ct = ct - egnorenum;
cttt = ct(2,:);
%%
% for i = 1:size(TT,2)
%     plot(1:length(TT),TT(:,i),cttt(i),TT(cttt(i),i),'*')
%     figure
% end
%%
% close all
y = TT;
sTT = smoothdata(y, 19, 1);
% sTT2 = smooth(TT(:,2), 19);
% CompareTwoFigure(sTT,sTT2,cttt)
%%
sTTfout=filloutliers(y);
%%
close all
y = diff(sTT);
% y2 = diff(TT);
% CompareTwoFigure(y2, y, cttt);
[m, n] = size(y);
w = 10;
rest = mod(m, w);
numw = (m - rest) / w;
A = zeros(numw+1, n);
sqrtP = zeros(numw+1, n);
S = zeros(numw+1, n);
R = zeros(numw+1, n);
for col = 1:n  % n��TT����
    for row = 1:numw  % ʱ�䴰Ϊw
        a = 0;
        p = 0;
        for i = 1:w
            a = a + abs(y((row-1)*10+i, col));
            p = p + abs(y((row-1)*10+i, col))^2;
        end
        A(row, col) = a;
        sqrtP(row, col) = sqrt(p/w);
        S(row, col) = sqrt(abs(p/w - a^2));
        R(row, col) = max(y((row-1)*10+1:(row-1)*10+w,col))-min(y((row-1)*10+1:(row-1)*10+w,col));
    end
    a = 0;
    p = 0;
    for i = 1:rest
        a = a + abs(y(numw*10+i, col));
        p = p + abs(y(numw*10+i, col))^2;
    end
    A(w+1, col) = a;
    sqrtP(w+1, col) = sqrt(p/w);
    S(w+1, col) = sqrt(abs(p/w - a^2));
    R(w+1, col) = max(y(numw*10+1:end, col)) - min(y(numw*10+rest:end, col));
end
CompareFourFearture(sTT, A, sqrtP, S, R, cttt)
%% 
function CompareTwoFigure(y1, y2, xx)
if size(y1,1) == size(y2,1)
    n = size(y1,1);
    x = 1:n;
    for i = 1:size(y1, 2)
        plot(x, y1(:,i), 'k', x, y2(:,i), 'r',xx(i), y1(xx(i),i), '*')
        figure
    end
else
    disp('����������С��һ�����޷����ɱȽ�ͼƬ')
end
end
function CompareFourFearture(sy, A, sqrtP, S, R, ct)
[m, n] = size(sy);
[p, q] = size(A);
x = 1:p;
if n~=q
    disp('������������������ϣ�����')
else
    w = m - p;
    for i = 1:n
        subplot(2,1,1)
        plot(1:m,sy(:,i),ct(i),sy(ct(i),i),'*')
        subplot(2,1,2)
        plot(x,A(:,i),'r',x,sqrtP(:,i),'y',x,S(:,i),'k',x,R(:,i),'g')
        figure
    end
end
end