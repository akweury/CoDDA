function Lambda = parameterLambda(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray)
minLambda = theta(1,1);
maxLambda = theta(1,2);
sigema = theta(1,3);
S = theta(1,4);
k = theta(1,5);
T = theta(1,6);
maxTimes = theta(1,7);
beta = theta(1,8);
Lambda = theta(1,9);
d = theta(1,10:end);

picLambda = 12;

[~,m] = size(data);

% kmeans_parameterLambda = zeros(m,maxLambda);
% hop_parameterLambda = zeros(m,maxLambda);
% CoDDA_parameterLambda = zeros(m,maxLambda);

NMI_kmeans_parameterLambda = zeros(maxLambda,maxTimes);
NMI_hop_parameterLambda = zeros(maxLambda,maxTimes);
NMI_CoDDA_parameterLambda = zeros(maxLambda,maxTimes);



% times = 1;
for i = 1:maxTimes
    parfor Lambda = minLambda:maxLambda
        X1 = sampleIMAGES(data,S,sigema); % 获取相似度矩阵
        theta = [beta,Lambda*0.00001,k,T,7,d];
        
%         kmeans_parameterLambda(:,Lambda) = k_means(data,k,coordinate,realresult,1,colorArray);
%         hop_parameterLambda(:,Lambda) = k_means(X1,k,coordinate,realresult,2,colorArray);
%         CoDDA_parameterLambda(:,Lambda) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);

        NMI_kmeans_parameterLambda(Lambda,i) = NMI_kmeans_parameterLambda(Lambda,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        NMI_hop_parameterLambda(Lambda,i) = NMI_hop_parameterLambda(Lambda,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);
        NMI_CoDDA_parameterLambda(Lambda,i) = NMI_CoDDA_parameterLambda(Lambda,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);
        
        times = (Lambda-minLambda + 1) * i;
        fprintf('(第%d轮) 实验%d/%d: 权重衰减项实验第%d/%d次迭代...\n',round,cur_experment,num_experment,times,maxTimes * (maxLambda - minLambda + 1));
        
    end
end

% 权重衰减项实验结果显示
figure(picLambda)
x = minLambda*0.00001:0.00001:maxLambda*0.00001; % x轴的范围是minLambda ~ maxLambda
y1 = sum(NMI_kmeans_parameterLambda(minLambda:maxLambda,:),2)/maxTimes; % k均值直接聚类
y2 = sum(NMI_hop_parameterLambda(minLambda:maxLambda,:),2)/maxTimes; % 带h跳的聚类
y3 = sum(NMI_CoDDA_parameterLambda(minLambda:maxLambda,:),2)/maxTimes; % 用CoDDA算法优化后用k均值聚类
plot(x,y1,'*-r',x,y2,'v-g',x,y3,'^-b');
legend('k-means','hop','CoDDA');
ylabel('NMI');
xlabel('权重衰减项实验');


filename = ['pic\',num2str(m),'-权重衰减项-',num2str(minLambda),'-',num2str(maxLambda),'-',num2str(maxTimes),'times-',...
    'S-',num2str(S),'-Sigema-',num2str(sigema),'-beta-',num2str(beta),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
saveas(picLambda,filename,'tif');


[~,Lambda] = max(sum(NMI_CoDDA_parameterLambda(minLambda:maxLambda,:),2)/maxTimes);
Lambda = Lambda*0.00001;

end