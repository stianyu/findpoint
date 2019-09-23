function P = findpoint(data) %#codegen
%FINDPOINT find the inflection point.

% Step1: Smooth data using moving average filter
y = data;
num = length(y);
x = 1:num;
span = 19; % 
% smo_y2 = smooth(x, y, 0.1, 'rloess'); 
smo_y = smoothdata(y, span); % using moving average filter with a span of 
                              % 19 to smooth data, span should be a odd
                              % number.
% plot(x,smo_y,'k',x,smo_y2,'r')


% Step2: Make a difference
diff_smo_y = diff(smo_y);

% Draw plot of diff_smo_y 
% figure
% subplot(2, 1, 1)
% plot(x(1:length(diff_smo_y)), diff_smo_y, 'r', x(1:length(diff_smo_y)), ...
% zeros(length(diff_smo_y),1),'k')
% legend('5点差分','0点')

% Step3: According to the difference of data, judge the inflection point
% within three classification
point1 = zeros(1,0);point2 = zeros(1,0);point3 = zeros(1,0);
P1=0;P2=0;P3=0;P=0;
sign1=0;sign2=0;sign3=0;
for i = 2:length(diff_smo_y)-1
    % Situation a: If the inflection point is a valley, find the point close to 0
    if diff_smo_y(i-1)<=diff_smo_y(i) && diff_smo_y(i)<=0 && diff_smo_y(i)...
            <=diff_smo_y(i+1) && diff_smo_y(i+1)>=0
        point1 = [point1 i];
        sign1 = 1;
        P1 = point1(1); % Outliers in this case is that the first point is 
        % not the large-scale valley. Further research can be done using
        % filloutliers function.
    end
    % Situation b: If the inflection point 
    if diff_smo_y(i-1)<=diff_smo_y(i) && diff_smo_y(i)<=0
        if abs(diff_smo_y(i))<=0.02
            point2 = [point2, i];
            sign2 = 2;
            P2 = point2(1);
        else
            point3 = [point3, i];
            sign3 = 3;
        end
    end        
end
if sign3
    if length(point3)>=3
        [value_P,index_P] = findpeaks(diff_smo_y(point3));
        index_maxP = value_P==max(value_P);
        P3 = index_P(index_maxP);
    else
        P3 = point3(1);
    end
end
if sign2==2
%     disp('Suspicious points：')
%     disp(point1)
%     disp('Judgement: 2')
    P = P2;
elseif sign3==3
%     disp('Suspicious points：')
%     disp(point3)
%     disp('Judgement: 3')
    P = P3;
elseif sign1==1
%     disp('Suspicious points：')
%     disp(point1)
%     disp('Judgement: 1')
    P = P1;
end
fprintf('Infleciton Point：%d\n', P)
subplot(2, 1, 2)
plot(x, y, 'k', x, smo_y, 'r',x(P),y(P),'*')
legend('原始数据','10% robust local regression滤波','凝血点')
text(x(P),y(P),['(',num2str(x(P)),',',num2s tr(y(P)),')'],'color','b')
end


