function S = parameterS(round,cur_experment,num_experment,data,theta,coordinate,realresult,colorArray)
minS = theta(1,1);
maxS = theta(1,2);
sigema = theta(1,3);
k = theta(1,4);
T = theta(1,5);
maxTimes = theta(1,6);
beta = theta(1,7);
Lambda = theta(1,8);
d = theta(1,9:end);
picNum = 7;
[~,m] = size(data);
% �ֱ����������ֵ��minS-maxSʱ��ֱ��k-means���࣬��h���ľ��࣬CoDDA���������㷨��NMIֵ������
% �������۱�׼����NMI �ǹ�һ������Ϣ����Χ��[0,1]����ֵԽ��˵�����Խ׼ȷ
% kmeans_parameterS = zeros(m,maxS);
% hop_parameterS = zeros(m,maxS);
% CoDDA_parameterS = zeros(m,maxS);

NMI_kmeans_parameterS = zeros(maxS,maxTimes);
NMI_hop_parameterS = zeros(maxS,maxTimes);
NMI_CoDDA_parameterS = zeros(maxS,maxTimes);


theta = [beta,Lambda,k,T,picNum,d];
% times = 1;
for i = 1:maxTimes
    for S = minS:maxS
        X1 = sampleIMAGES(data,S,sigema); % ��ȡ���ƶȾ���

%         kmeans_parameterS(:,S) = k_means(data,k,coordinate,realresult,1,colorArray);
%         hop_parameterS(:,S) = k_means(X1,k,coordinate,realresult,2,colorArray);
%         CoDDA_parameterS(:,S) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);

        NMI_kmeans_parameterS(S,i) = NMI_kmeans_parameterS(S,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        NMI_hop_parameterS(S,i) = NMI_hop_parameterS(S,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);
        NMI_CoDDA_parameterS(S,i) = NMI_CoDDA_parameterS(S,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);     
        times = (S-minS+1) * i;
        
        fprintf('(��%d��)ʵ��%d/%d: ������ֵʵ�顡��������%d/%d�ε���...',...
        round,cur_experment,num_experment,times, maxTimes * (maxS - minS + 1));
        
        fprintf('NMI_kmeans=%1.2f\tNMI_hop=%1.2f\tNMI_CoDDA=%1.2f\n',...
    NMI_kmeans_parameterS(S,i),NMI_hop_parameterS(S,i),NMI_CoDDA_parameterS(S,i));
        

        
        
        
    end
    
end




% ������ֵʵ������ʾ
figure(8)
x = minS:maxS; % x��ķ�Χ��minHop ~ maxHop
y1 = sum(NMI_kmeans_parameterS(minS:maxS,:),2)/maxTimes; % k��ֱֵ�Ӿ���
y2 = sum(NMI_hop_parameterS(minS:maxS,:),2)/maxTimes; % ��h���ľ���
y3 = sum(NMI_CoDDA_parameterS(minS:maxS,:),2)/maxTimes; % ��CoDDA�㷨�Ż�����k��ֵ����

plot(x,y1,'*-r',x,y2,'v-g',x,y3,'^-b');
legend('k-means','hop','CoDDA');

% plot(x,y1,'*-r',x,y2,'v-g');
% legend('k-means','hop');

ylabel('NMI');
xlabel('������ֵ');

% filename = ['pic\',num2str(m),'-������ֵ-',num2str(minS),'-',num2str(maxS),'-',num2str(maxTimes),'times-',...
%     '-sigema-',num2str(sigema),'-beta-',num2str(beta),'-lambda-',num2str(Lambda),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
% saveas(8,filename,'tif');

% ����xls�ļ�

fprintf('save NMI values to xls...');
filename = 'result\parameter_nmi.xlsx';

for i = minS:maxS
    [~, ~, row] = xlsread(filename);
    [rowN, ~]=size(row);
    sheet=1;
    xlsRange=['A',num2str(rowN+1)];
    xlswrite(filename,[m,{'S'}, y1(i,1),y2(i,1),y3(i,1),i,sigema,T,beta,Lambda],sheet,xlsRange);
    xlsRange=['K',num2str(rowN+1)];
    datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
    xlswrite(filename,{datetime_str},sheet,xlsRange);
end




fprintf('compete!\n');
[~,S] = max(sum(NMI_CoDDA_parameterS,2)/maxTimes);
end