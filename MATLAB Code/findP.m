function P = findP(data)
%FINDP Here are step2 and step3 of findpoint.m
% Step2: Make a difference
diff_smo_y = diff(data);
% Step3: According to the difference of diff_smo_y, judge the inflection point
% within three classification
point1 = [];point2 = [];point3 = [];
P1=0;P2=0;P3=0;P=0;
sign1=0;sign2=0;sign3=0;
for i = 2:length(diff_smo_y)-1
    % Situation a: If the inflection point is a valley, find the point close to 0
    if diff_smo_y(i-1)<=diff_smo_y(i) && diff_smo_y(i)<=0 && diff_smo_y(i)...
            <=diff_smo_y(i+1) && diff_smo_y(i+1)>=0
        point1(end+1) = i;
        sign1 = 1;
        P1 = point1(1); % Outliers in this case is that the first point is 
        % not the large-scale valley. Further research can be done using
        % filloutliers function.
    end
    % Situation b: If the inflection point 
    if diff_smo_y(i-1)<=diff_smo_y(i) && diff_smo_y(i)<=0
        if abs(diff_smo_y(i))<=0.02
            point2(end+1) = i;
            sign2 = 2;
            P2 = point2(1);
        else
            point3(end+1) = i;
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
    disp('Suspicious points£º')
    disp(point1)
    disp('Judgement: 2')
    P = P2;
elseif sign3==3
    disp('Suspicious points£º')
    disp(point3)
    disp('Judgement: 3')
    P = P3;
elseif sign1==1
    disp('Suspicious points£º')
    disp(point1)
    disp('Judgement: 1')
    P = P1;
end
fprintf('Infleciton Point£º%d\n', P)
end

