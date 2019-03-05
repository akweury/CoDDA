function vibrate(data,coordinate,realresult,k,T,d,theta,colorArray)

S = theta(1,1); 
sigema = theta(1,2); % 衰减因子
beta = theta(1,3);
Lambda = theta(1,4); 
picNum = theta(1,5); % 显示图像的编号

[~,m]=size(data);
maxIter = 100;
CoDDA_array = zeros(maxIter,3); % values

parfor i = 1:maxIter
    % 首先计算出原数据的相似度矩阵X1
    X1 = sampleIMAGES(data,S,sigema);

    % 对相似度矩阵进行聚类
    theta = [beta,Lambda,k,T,picNum,d];
    CoDDA = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);
    CoDDA_array(i,:) = [evaluationF_name(CoDDA,realresult,k,k),nmi(CoDDA,realresult),...
        modularity_metric( coms2modules(CoDDA),data)];
%     F_name = evaluationF_name(CoDDA,realresult,k,k); 
%     NMI = nmi(CoDDA,realresult);
%     modules = coms2modules(CoDDA);
%     Q = modularity_metric(modules,data);

end
CoDDA_var = var(CoDDA_array);
fprintf('var_Fsame=%2.5f,var_NMI=%2.5f,var_Q=%2.5f\n',CoDDA_var(1,1),CoDDA_var(1,2),CoDDA_var(1,3));
theta=[S,sigema,T,beta,Lambda];
drawPlot(m,theta,CoDDA_array);

filename = 'result\variance.xlsx';
[~, ~, row] = xlsread(filename);
[rowN, ~]=size(row);
sheet=1;
xlsRange=['A',num2str(rowN+1)];
xlswrite(filename,[m,maxIter,CoDDA_var(1,1),CoDDA_var(1,2),CoDDA_var(1,3),S,sigema,T,beta,Lambda],sheet,xlsRange);
xlsRange=['K',num2str(rowN+1)];
datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
xlswrite(filename,{datetime_str},sheet,xlsRange);

filename = 'result\variance_evaulation.xlsx';
for i = 1:maxIter
    [~, ~, row] = xlsread(filename);
    [rowN, ~]=size(row);
    sheet=1;
    xlsRange=['A',num2str(rowN+1)];
    xlswrite(filename,[m,CoDDA_array(i,1),CoDDA_array(i,2),CoDDA_array(i,3),S,sigema,T,beta,Lambda],sheet,xlsRange);
    xlsRange=['J',num2str(rowN+1)];
    datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
    xlswrite(filename,{datetime_str},sheet,xlsRange);
end

end