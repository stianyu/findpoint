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
sTT = smoothdata(TT, 19, 1);
% CompareTwoFigure(TT,sTT,cttt)
%%
close all
y = diff(sTT);
% y2 = diff(TT);
% CompareTwoFigure(y2, y, cttt);
[m, n] = size(y);
w = 10;
A = zeros(m-w+1, n);
sqrtP = zeros(m-w+1, n);
S = zeros(m-w+1, n);
R = zeros(m-w+1, n);
for col = 1:n  % n列TT数据
    for row = 1:m-w+1  % 时间窗为w
        a = 0;
        p = 0;
        for i = row:row+w-1
            a = a + abs(y(i, col));
            p = p + abs(y(i, col))^2;
        end
        A(row, col) = a;
        sqrtP(row, col) = sqrt(p/w);
        S(row, col) = sqrt(abs(p/w - a^2));
        R(row, col) = max(y(row:row+w-1,col))-min(y(row:row+w-1,col));
    end
end
% CompareFourFearture(sTT, A, sqrtP, S, R, cttt)
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
    disp('两个变量大小不一样，无法生成比较图片')
end
end
function CompareFourFearture(sy, A, sqrtP, S, R, ct)
[m, n] = size(sy);
[p, q] = size(A);
x = 1:p;
if n~=q
    disp('传入参数的dim=2不符合，请检查')
else
    w = m - p;
    for i = 1:n
        subplot(2,1,1)
        plot(x,sy(1:end-w,i),ct(i),sy(ct(i),i),'*')
        subplot(2,1,2)
        plot(x,A(:,i),'r',x,sqrtP(:,i),'y',x,S(:,i),'k',x,R(:,i),'g')
        figure
    end
end
end