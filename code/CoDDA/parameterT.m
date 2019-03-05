function T = parameterT(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray)
minT = theta(1,1);
maxT = theta(1,2);
sigema = theta(1,3);
S = theta(1,4);
k = theta(1,5);
T = theta(1,6);
maxTimes = theta(1,7);
beta = theta(1,8);
Lambda = theta(1,9);
d = theta(1,10:end);

picT = 11;

[~,m] = size(data);

% kmeans_parameterT = zeros(m,maxT);
% hop_parameterT = zeros(m,maxT);
% CoDDA_parameterT = zeros(m,maxT);

NMI_kmeans_parameterT = zeros(maxT,maxTimes);
NMI_hop_parameterT = zeros(maxT,maxTimes);
NMI_CoDDA_parameterT = zeros(maxT,maxTimes);



% times = 1;
for i = 1:maxTimes
    for T = minT:maxT
        X1 = sampleIMAGES(data,S,sigema); % ��ȡ���ƶȾ���
        theta = [beta,Lambda,k,T,7,d];
%         kmeans_parameterT(:,T) = k_means(data,k,coordinate,realresult,1,colorArray);
%         hop_parameterT(:,T) = k_means(X1,k,coordinate,realresult,2,colorArray);
%         CoDDA_parameterT(:,T) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);

        NMI_kmeans_parameterT(T,i) = NMI_kmeans_parameterT(T,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        NMI_hop_parameterT(T,i) = NMI_hop_parameterT(T,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);
        NMI_CoDDA_parameterT(T,i) = NMI_CoDDA_parameterT(T,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);
        
        times = (T - minT + 1) * i;
        fprintf('(��%d��) ʵ��%d/%d: ���ϡ���Զ�����������ʵ�顡��������%d/%d�ε���...',round,cur_experment,num_experment,times, maxTimes * (maxT - minT + 1));
        fprintf('NMI_kmeans=%1.2f\tNMI_hop=%1.2f\tNMI_CoDDA=%1.2f\n',...
    NMI_kmeans_parameterT(T,i),NMI_hop_parameterT(T,i),NMI_CoDDA_parameterT(T,i));

    end
    
end

% ���ϡ���Զ�����������ʵ������ʾ
figure(picT)
x = minT:maxT; % x��ķ�Χ��minT ~ maxT
y1 = sum(NMI_kmeans_parameterT,2)/maxTimes; % k��ֱֵ�Ӿ���
y2 = sum(NMI_hop_parameterT,2)/maxTimes; % ��h���ľ���
y3 = sum(NMI_CoDDA_parameterT,2)/maxTimes; % ��CoDDA�㷨�Ż�����k��ֵ����
plot(x,y1,'r',x,y2,'g',x,y3,'b',x,NMI_kmeans_parameterT,'r*',x,NMI_hop_parameterT,'gv',x,NMI_CoDDA_parameterT,'b^');
legend('k-means','hop','CoDDA');
ylabel('NMI');
xlabel('���ϡ���Զ�����������ʵ��');


filename = ['pic\',num2str(m),'-���ϡ���Զ�����������-',num2str(minT),'-',num2str(maxT),'-',num2str(maxTimes),'times-',...
    'S-',num2str(S),'-Sigema-',num2str(sigema),'-beta-',num2str(beta),'-lambda-',num2str(Lambda),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
saveas(picT,filename,'tif');



% % ����xls�ļ�
fprintf('save NMI values to xls...');
filename = 'result\parameter_nmi.xlsx';

for i = minT:maxT
    [~, ~, row] = xlsread(filename);
    [rowN, ~]=size(row);
    sheet=1;
    xlsRange=['A',num2str(rowN+1)];
    xlswrite(filename,[m,{'T'}, y1(i,1),y2(i,1),y3(i,1),S,sigema,i,beta,Lambda],sheet,xlsRange);
    xlsRange=['K',num2str(rowN+1)];
    datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
    xlswrite(filename,{datetime_str},sheet,xlsRange);
end

fprintf('compete!\n');


[~,T] = max(sum(NMI_CoDDA_parameterT,2)/maxTimes);

end