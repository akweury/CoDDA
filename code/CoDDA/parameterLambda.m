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
        X1 = sampleIMAGES(data,S,sigema); % ��ȡ���ƶȾ���
        theta = [beta,Lambda*0.00001,k,T,7,d];
        
%         kmeans_parameterLambda(:,Lambda) = k_means(data,k,coordinate,realresult,1,colorArray);
%         hop_parameterLambda(:,Lambda) = k_means(X1,k,coordinate,realresult,2,colorArray);
%         CoDDA_parameterLambda(:,Lambda) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);

        NMI_kmeans_parameterLambda(Lambda,i) = NMI_kmeans_parameterLambda(Lambda,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        NMI_hop_parameterLambda(Lambda,i) = NMI_hop_parameterLambda(Lambda,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);
        NMI_CoDDA_parameterLambda(Lambda,i) = NMI_CoDDA_parameterLambda(Lambda,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);
        
        times = (Lambda-minLambda + 1) * i;
        fprintf('(��%d��) ʵ��%d/%d: Ȩ��˥����ʵ���%d/%d�ε���...\n',round,cur_experment,num_experment,times,maxTimes * (maxLambda - minLambda + 1));
        
    end
end

% Ȩ��˥����ʵ������ʾ
figure(picLambda)
x = minLambda*0.00001:0.00001:maxLambda*0.00001; % x��ķ�Χ��minLambda ~ maxLambda
y1 = sum(NMI_kmeans_parameterLambda(minLambda:maxLambda,:),2)/maxTimes; % k��ֱֵ�Ӿ���
y2 = sum(NMI_hop_parameterLambda(minLambda:maxLambda,:),2)/maxTimes; % ��h���ľ���
y3 = sum(NMI_CoDDA_parameterLambda(minLambda:maxLambda,:),2)/maxTimes; % ��CoDDA�㷨�Ż�����k��ֵ����
plot(x,y1,'*-r',x,y2,'v-g',x,y3,'^-b');
legend('k-means','hop','CoDDA');
ylabel('NMI');
xlabel('Ȩ��˥����ʵ��');


filename = ['pic\',num2str(m),'-Ȩ��˥����-',num2str(minLambda),'-',num2str(maxLambda),'-',num2str(maxTimes),'times-',...
    'S-',num2str(S),'-Sigema-',num2str(sigema),'-beta-',num2str(beta),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
saveas(picLambda,filename,'tif');


[~,Lambda] = max(sum(NMI_CoDDA_parameterLambda(minLambda:maxLambda,:),2)/maxTimes);
Lambda = Lambda*0.00001;

end