function sigema = parameterSigema(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray)

minSigema = theta(1,1);
maxSigema = theta(1,2);
S = theta(1,3);
k = theta(1,4);
T = theta(1,5);
maxTimes = theta(1,6);
beta = theta(1,7);
Lambda = theta(1,8);
d = theta(1,9:end);
picNum = 7;

[~,m] = size(data);
% �ֱ����˥��������0-1ʱ��k-means�㷨��hop���㷨��CoDDA�㷨��NMIֵ
% �������۱�׼��NMI �ǹ�һ������Ϣ����Χ��[0,1]����ֵԽ��˵�����Խ׼ȷ
% kmeans_parameterSigema = zeros(m,maxSigema);
% hop_parameterSigema = zeros(m,maxSigema);
% CoDDA_parameterSigema = zeros(m,maxSigema);
NMI_kmeans_parameterSigema = zeros(maxSigema,maxTimes);
NMI_hop_parameterSigema = zeros(maxSigema,maxTimes);
NMI_CoDDA_parameterSigema = zeros(maxSigema,maxTimes);

theta = [beta,Lambda,k,T,picNum,d];
% times = 1;
for i = 1:maxTimes
    for sigema = minSigema:maxSigema
        X1 = sampleIMAGES(data,S,sigema*0.1); % ��ȡ���ƶȾ���

%         kmeans_parameterSigema(:,sigema) = k_means(data,k,coordinate,realresult,1,colorArray);
        NMI_kmeans_parameterSigema(sigema,i) = NMI_kmeans_parameterSigema(sigema,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        
%         hop_parameterSigema(:,sigema) = k_means(X1,k,coordinate,realresult,2,colorArray);
        NMI_hop_parameterSigema(sigema,i) = NMI_hop_parameterSigema(sigema,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);

%         CoDDA_parameterSigema(:,sigema) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);
        NMI_CoDDA_parameterSigema(sigema,i) = NMI_CoDDA_parameterSigema(sigema,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);
        times = (sigema-minSigema+1) * i;
        fprintf('(��%d��) ʵ��%d/%d: ˥������ʵ�顡��������%d/%d�ε���...',round,cur_experment,num_experment,times,maxTimes * (maxSigema - minSigema + 1));
        
        fprintf('NMI_kmeans=%1.2f\tNMI_hop=%1.2f\tNMI_CoDDA=%1.2f\n',...
    NMI_kmeans_parameterSigema(sigema,i),NMI_hop_parameterSigema(sigema,i),NMI_CoDDA_parameterSigema(sigema,i));
        
        
        
    end
    
	
end
% ˥������ʵ������ʾ
figure(9)
x = minSigema*0.1:0.1:maxSigema*0.1; % x��ķ�Χ��minSigema ~ maxSigema
y1 = sum(NMI_kmeans_parameterSigema(minSigema:maxSigema,:),2)/maxTimes; % k��ֱֵ�Ӿ���
y2 = sum(NMI_hop_parameterSigema(minSigema:maxSigema,:),2)/maxTimes; % hop����
y3 = sum(NMI_CoDDA_parameterSigema(minSigema:maxSigema,:),2)/maxTimes; % ��CoDDA�㷨�Ż�����k��ֵ����
plot(x,y1,'*-r',x,y2,'^-g',x,y3,'v-b');
legend('k-means','hop','CoDDA');

% plot(x,y1(minSigema:maxSigema,1),'*-r',x,y2(minSigema:maxSigema,1),'^-g');
% legend('k-means','hop');
ylabel('NMI');
xlabel('˥������');

filename = ['pic\',num2str(m),'-˥������-',num2str(minSigema),'-',num2str(maxSigema),'-',num2str(maxTimes),'times-',...
    '-S-',num2str(S),'-beta-',num2str(beta),'-lambda-',num2str(Lambda),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
saveas(9,filename,'tif');


% % ����xls�ļ�
fprintf('save NMI values to xls...');
filename = 'result\parameter_nmi.xlsx';

for i = minSigema:maxSigema
    [~, ~, row] = xlsread(filename);
    [rowN, ~]=size(row);
    sheet=1;
    xlsRange=['A',num2str(rowN+1)];
    xlswrite(filename,[m,{'Sigma'}, y1(i,1),y2(i,1),y3(i,1),S,i,T,beta,Lambda],sheet,xlsRange);
    xlsRange=['K',num2str(rowN+1)];
    datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
    xlswrite(filename,{datetime_str},sheet,xlsRange);
end

fprintf('compete!\n');





[~,sigema] = max(sum(NMI_CoDDA_parameterSigema,2)/maxTimes);
sigema = sigema *0.1;

end