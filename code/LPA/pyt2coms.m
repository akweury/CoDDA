clear ;clc;close all;
addpath ..\CoDDA
load cls.txt;
load realresult.txt; % 导入数据集的真实社区
load strike.txt;    % 导入数据集的邻接矩阵
data = strike;
k = 3; % 社区个数
LPA = cls;
[~,m] = size(data);
t = length(unique(cls));
%% STEP : 聚类结果验证
% 社区评价标准：Fname 是对社区结果与真实社区的交叉和近似程度的衡量指标，范围是[0,1],数值越大说明结果越准确
% cls是结果社区，realresult是真实社区，k是聚类数目，目前暂定真实社区和结果社区的聚类数目都是k
F_name = evaluationF_name(LPA,realresult,k,t); 

% 社区评价标准：NMI 是归一化互信息，范围是[0,1]数值越大说明结果越准确
NMI = evaluationNMI(LPA,realresult,k,t);

% 社区质量评价标准：Q模块性是使用最广泛的衡量社区质量的评价标准之一
% CoDDA是聚类结果，k是聚类社区数，strike是图的邻接矩阵
Q = modularity(LPA,k,data);

filename = ['result\',num2str(m),'node-evaluation-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
fw = fopen(filename,'w+');
fprintf(fw,'节点数目: %4d\tF_name = %1.2f\tNMI = %1.2f\tQ = %1.2f\n\n',m,F_name,NMI,Q);
fclose(fw);