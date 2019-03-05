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
% 分别计算衰减因子在0-1时，k-means算法，hop跳算法，CoDDA算法的NMI值
% 社区评价标准：NMI 是归一化互信息，范围是[0,1]，数值越大说明结果越准确
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
        X1 = sampleIMAGES(data,S,sigema*0.1); % 获取相似度矩阵

%         kmeans_parameterSigema(:,sigema) = k_means(data,k,coordinate,realresult,1,colorArray);
        NMI_kmeans_parameterSigema(sigema,i) = NMI_kmeans_parameterSigema(sigema,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        
%         hop_parameterSigema(:,sigema) = k_means(X1,k,coordinate,realresult,2,colorArray);
        NMI_hop_parameterSigema(sigema,i) = NMI_hop_parameterSigema(sigema,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);

%         CoDDA_parameterSigema(:,sigema) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);
        NMI_CoDDA_parameterSigema(sigema,i) = NMI_CoDDA_parameterSigema(sigema,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);
        times = (sigema-minSigema+1) * i;
        fprintf('(第%d轮) 实验%d/%d: 衰减因子实验　　　　第%d/%d次迭代...',round,cur_experment,num_experment,times,maxTimes * (maxSigema - minSigema + 1));
        
        fprintf('NMI_kmeans=%1.2f\tNMI_hop=%1.2f\tNMI_CoDDA=%1.2f\n',...
    NMI_kmeans_parameterSigema(sigema,i),NMI_hop_parameterSigema(sigema,i),NMI_CoDDA_parameterSigema(sigema,i));
        
        
        
    end
    
	
end
% 衰减因子实验结果显示
figure(9)
x = minSigema*0.1:0.1:maxSigema*0.1; % x轴的范围是minSigema ~ maxSigema
y1 = sum(NMI_kmeans_parameterSigema(minSigema:maxSigema,:),2)/maxTimes; % k均值直接聚类
y2 = sum(NMI_hop_parameterSigema(minSigema:maxSigema,:),2)/maxTimes; % hop聚类
y3 = sum(NMI_CoDDA_parameterSigema(minSigema:maxSigema,:),2)/maxTimes; % 用CoDDA算法优化后用k均值聚类
plot(x,y1,'*-r',x,y2,'^-g',x,y3,'v-b');
legend('k-means','hop','CoDDA');

% plot(x,y1(minSigema:maxSigema,1),'*-r',x,y2(minSigema:maxSigema,1),'^-g');
% legend('k-means','hop');
ylabel('NMI');
xlabel('衰减因子');

filename = ['pic\',num2str(m),'-衰减因子-',num2str(minSigema),'-',num2str(maxSigema),'-',num2str(maxTimes),'times-',...
    '-S-',num2str(S),'-beta-',num2str(beta),'-lambda-',num2str(Lambda),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
saveas(9,filename,'tif');


% % 保存xls文件
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