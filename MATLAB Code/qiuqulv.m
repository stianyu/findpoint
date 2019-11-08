clear;
clc;
close all
dirname = 'D:\1 ������Ŀ\2 ��Ѫ��\����\9.26����\9.26'; 
filelist = getallfiles(dirname);
%%
clc;close all
x0 = 1:1999;
% for j = 1:length(filelist)
%     j = 8;
%     ALL = xlsread(filelist{j}, 'A101:E2000');
    ALL = xlsread('C:\Users\sty_d\Desktop\47-1 2000��.xls', 'B2:B2000');
%     alldata = filloutliers(ALL(:,5), 'linear');
%     for i = 1:5
        %�������
        %x0,y0��֤������ɢ�㣬���Էǵȼ��
        i = 1;
        data = smoothdata(ALL(:,i), 19, 1);
%         data = smooth(x0, alldata(:,i), 0.1, 'rloess');
        y0 = data;
        yapp11 = gradient1(y0);
        yapp22 = gradient1(yapp11);
        yapp1 = gradient(y0);
        yapp2 = 4 * del2(y0);
        % yapp1 = gradient(y0)./ht; %matlab��ֵ����
        % yapp2 = del2(y0)./ht; %matlab��ֵ����
        k22 = abs(yapp22)./(1+yapp11.^2).^(3/2);
        k2 = abs(yapp2)./(1+yapp1.^2).^(3/2);
        delta_yapp1 = yapp11 - yapp1;
        delta_yapp2 = yapp22 - yapp2;
        delta_k2 = k22 - k2;
%         figure
%         plot(k2)
        figure
        subplot(3, 2, 4)
        plot(x0, yapp1,'k', x0, yapp11, 'r', x0, delta_yapp1,'g')
        title([num2str(j),'.xls��',num2str(i),'��һ�׵�'])
        subplot(3, 2, 5)
        plot(x0, yapp2,'k', x0, yapp22, 'r', x0, delta_yapp2,'g')
        title([num2str(j),'.xls��',num2str(i),'�ж��׵�'])
        feature = isOutlierlog(y0); 
        K2 = [];K22 = [];
        for l = 1:size(y0,1)
            if ~feature(l)
                K2(end+1, 1) = k2(l);
                K22(end+1, 1) = k2(l);
            end
        end
        [~,maxFlag] = max(K2);
        [~,maxFlag2] = max(K22);
        % [~,maxFlag] = max(k2);%�������λ��
        x_max = x0(maxFlag)
        y_max = y0(maxFlag);
        x_max2 = x0(maxFlag2)
        y_max2 = y0(maxFlag2);
        %����ͼ�� ��ע��������
        subplot(3, 2, 1)
        plot(x_max,y_max,'rp',x0,y0,'.-',x_max2,y_max2,'kp')
        title([num2str(j),'.xls��',num2str(i),'������'])
        subplot(3, 2, 2)
        plot(x0, k2,'k', x0, k22, 'r', x0, delta_k2,'g')
        title([num2str(j),'.xls��',num2str(i),'������'])
%     end
% end





