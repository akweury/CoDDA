function [Fsame,NMI,Q,t] = CoDDA(maxIter,data,coordinate,realresult,k,T,d,theta,colorArray)


% -------基本参数----------------
data(data>0) = 1; % 检查数据集，确保内容为0-1邻接矩阵
S = theta(1,1); 
sigema = theta(1,2); % 衰减因子
beta = theta(1,3);
Lambda = theta(1,4); 
picNum = theta(1,5); % 显示图像的编号
[~,m] = size(data);


Fsame = zeros(maxIter,1);
NMI = zeros(maxIter,1);
Q = zeros(maxIter,1);
for i = 1:maxIter
    tic
    % 首先计算出原数据的相似度矩阵X1
    X1 = sampleIMAGES(data,S,sigema);

    % 对相似度矩阵利用不同的算法进行聚类
    theta = [beta,Lambda,k,T,picNum,d];

    % CoDDA = CoDDA_new(X1,coordinate,realresult,colorArray,theta);
    CoDDA_reault = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);
    t = toc;
    %% STEP 3: 聚类结果验证

    % 社区评价标准：Fname 是对社区结果与真实社区的交叉和近似程度的衡量指标，范围是[0,1],数值越大说明结果越准确
    % cls是结果社区，realresult是真实社区，k是聚类数目，目前暂定真实社区和结果社区的聚类数目都是k
    Fsame(i,1) = evaluationF_name(CoDDA_reault,realresult,k,k); 

    % 社区评价标准：NMI 是归一化互信息，范围是[0,1]数值越大说明结果越准确
    % NMI = evaluationNMI(CoDDA,realresult,k,k);
    NMI(i,1) = nmi(CoDDA_reault,realresult);
    % 社区质量评价标准：Q模块性是使用最广泛的衡量社区质量的评价标准之一
    % CoDDA是聚类结果，k是聚类社区数，strike是图的邻接矩阵
    % Q = modularity(CoDDA,k,data);
    modules = coms2modules(CoDDA_reault);
    Q(i,1) = modularity_metric(modules,data);
end

Fsame = sum(Fsame)/maxIter;
NMI = sum(NMI)/maxIter;
Q = sum(Q)/maxIter;
fprintf('\n(%d)CoDDA Result : F_name=%1.2f\tNMI=%1.2f\tQ=%1.2f\n',m,Fsame,NMI,Q);

% 保存文件
filename = 'result\evaluation.xlsx';
[~, ~, row] = xlsread(filename);
[rowN, ~]=size(row);
sheet=1;
xlsRange=['A',num2str(rowN+1)];
xlswrite(filename,[m,maxIter,Fsame,NMI,Q,t,S,sigema,T,beta,Lambda],sheet,xlsRange);
xlsRange=['L',num2str(rowN+1)];
datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
xlswrite(filename,{datetime_str},sheet,xlsRange);
end