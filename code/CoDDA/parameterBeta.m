function beta = parameterBeta(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray)
minBeta = theta(1,1);
maxBeta = theta(1,2);
sigema = theta(1,3);
S = theta(1,4);
k = theta(1,5);
T = theta(1,6);
maxTimes = theta(1,7);
beta = theta(1,8);
Lambda = theta(1,9);
d = theta(1,10:end);

multiple = 0.01;

[~,m] = size(data);

% kmeans_parameterBeta = zeros(m,maxBeta);
% hop_parameterBeta = zeros(m,maxBeta);
% CoDDA_parameterBeta = zeros(m,maxBeta);

NMI_kmeans_parameterBeta = zeros(maxBeta,maxTimes);
NMI_hop_parameterBeta = zeros(maxBeta,maxTimes);
NMI_CoDDA_parameterBeta = zeros(maxBeta,maxTimes);



% times = 1;
for i = 1:maxTimes
    
    parfor beta = minBeta:maxBeta
        X1 = sampleIMAGES(data,S,sigema); % ��ȡ���ƶȾ���
        theta = [ minBeta*multiple,Lambda,k,T,7,d];
%         theta(1,1) = beta;
%         kmeans_parameterBeta(:,beta) = k_means(data,k,coordinate,realresult,1,colorArray);
%         hop_parameterBeta(:,beta) = k_means(X1,k,coordinate,realresult,2,colorArray);
%         CoDDA_parameterBeta(:,beta) = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);

        NMI_kmeans_parameterBeta(beta,i) = NMI_kmeans_parameterBeta(beta,i) + nmi(k_means(data,k,coordinate,realresult,1,colorArray),realresult);
        NMI_hop_parameterBeta(beta,i) = NMI_hop_parameterBeta(beta,i) + nmi(k_means(X1,k,coordinate,realresult,2,colorArray),realresult);
        NMI_CoDDA_parameterBeta(beta,i) = NMI_CoDDA_parameterBeta(beta,i) + nmi(CoDDAAlgo(X1,coordinate,realresult,colorArray,theta),realresult);
%         NMI_kmeans_parameterBeta(beta,i) = NMI_kmeans_parameterBeta(beta,i) + nmi(kmeans_parameterBeta(:,beta),realresult);
%         NMI_hop_parameterBeta(beta,i) = NMI_hop_parameterBeta(beta,i) + nmi(hop_parameterBeta(:,beta),realresult);
%         NMI_CoDDA_parameterBeta(beta,i) = NMI_CoDDA_parameterBeta(beta,i) + nmi(CoDDA_parameterBeta(:,beta),realresult);
        
        times = (beta-minBeta + 1) * i;
        fprintf('(��%d��) ʵ��%d/%d: ϡ��ͷ�����Ȩ��ʵ���%d/%d�ε���...\n',round,cur_experment,num_experment,times, maxTimes * (maxBeta - minBeta + 1));
        
    end
    
end


% ϡ��ͷ�����Ȩ��ʵ������ʾ
figure(10)
x = minBeta*multiple:multiple:maxBeta*multiple; % x��ķ�Χ��minBeta ~ maxBeta
% x = minBeta:maxBeta; % x��ķ�Χ��minBeta ~ maxBeta
y1 = sum(NMI_kmeans_parameterBeta,2)/maxTimes; % k��ֱֵ�Ӿ���
y2 = sum(NMI_hop_parameterBeta,2)/maxTimes; % ��h���ľ���
y3 = sum(NMI_CoDDA_parameterBeta,2)/maxTimes; % ��CoDDA�㷨�Ż�����k��ֵ����
plot(x,y1(minBeta:maxBeta,1),'*-r',x,y2(minBeta:maxBeta,1),'v-g',x,y3(minBeta:maxBeta,1),'^-b');
legend('k-means','hop','CoDDA');

% plot(x,y3(minBeta:maxBeta,1),'^-b');
% legend('CoDDA');

ylabel('NMI');
xlabel('ϡ��ͷ�����Ȩ��');

filename = ['pic\',num2str(m),'-ϡ��ͷ�����Ȩ��-',num2str(minBeta),'-',num2str(maxBeta),'-',num2str(maxTimes),'times-',...
    'S-',num2str(S),'sigema-',num2str(sigema),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];
saveas(10,filename,'tif');

[~,beta] = max(sum(NMI_CoDDA_parameterBeta,2)/maxTimes);

beta = beta * multiple;

end