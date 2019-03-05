clear;clc;close all;

% addpath \\charlietp\code\CoDDA\data_strike
% addpath \\charlietp\code\\CoDDA\data_football
addpath ..\dataset\data_strike
addpath ..\dataset\data_football
addpath ..\CoDDA


%% strike实验集

%-----------------------参数---------------------------------------

% load strike.txt;    % 导入数据集的邻接矩阵
% load strikecoordinate.txt % 导入数据集的点坐标
% load realresult.txt; % 导入真实社区
% 
% k = 3; % 真实社区个数
% colorArray = [[1,0,0];[0,0,1];[0,1,0]]; % 各个社区的显示颜色
% 
% %***************************执行*************************************
% tic
% LPA(strike,strikecoordinate,realresult,k,colorArray);
% t = toc;

%-----------------------参数---------------------------------------

% load football_adjacency.txt;    % 导入数据集的邻接矩阵
% load football_coordinate.txt % 导入数据集的点坐标
% load football_community.txt; % 导入数据集的真实社区
% k = 12; % 社区个数
% colorArray = [[1,0,0];[0,0,1];[0,1,0];[0.0977,0.0977,0.4375];[0.18,0.54,0.34];[0.33,0.41,0.18];...
%     [1,0.6445,0];[0.82,0.41,0.12];[0.2183,0.2382,0.5430];[0.5430,0,0];[1,0.4102,0.7031];[0.8,0.1484,0.1484]];
% 
% %***************************执行*************************************
% maxIter = 1;
% F_name = zeros(maxIter,1);
% NMI = zeros(maxIter,1);
% Q = zeros(maxIter,1);
% for i = 1:maxIter
%     tic
%     [F_name(i,1),NMI(i,1),Q(i,1)] = LPA(football_adjacency,football_coordinate,football_community,k,colorArray);
%     t = toc;
% end
% F_name_max = max(F_name);
% F_name = sum(F_name)/maxIter;
% NMI_max = max(NMI);
% NMI = sum(NMI)/maxIter;
% Q_max = max(Q);
% Q = sum(Q)/maxIter;
% fprintf('Fname = %1.2f\tNMI = %1.2f\tQ = %1.2f\n',F_name,NMI,Q);
% fprintf('Fname_max = %1.2f\tNMI_max = %1.2f\tQ_max = %1.2f\n',F_name_max,NMI_max,Q_max);


load lj_adj.txt;    % 导入数据集的邻接矩阵
load lj_coordinate.txt % 导入数据集的点坐标
load lj_coms.txt; % 导入数据集的真实社区
k = 8; % 社区个数
colorArray = [[1,0,0];[0,0,1];[0,1,0];[0.0977,0.0977,0.4375];[0.18,0.54,0.34];[0.33,0.41,0.18];...
    [1,0.6445,0];[0.82,0.41,0.12]];

%***************************执行*************************************
maxIter = 1;
F_name = zeros(maxIter,1);
NMI = zeros(maxIter,1);
Q = zeros(maxIter,1);
for i = 1:maxIter
    tic
     [F_name(i,1),NMI(i,1),Q(i,1)] = LPA(lj_adj,lj_coordinate,lj_coms,k,colorArray);
    t =toc;
end
F_name_max = max(F_name);
F_name = sum(F_name)/maxIter;
NMI_max = max(NMI);
NMI = sum(NMI)/maxIter;
Q_max = max(Q);
Q = sum(Q)/maxIter;
fprintf('Fname = %1.2f\tNMI = %1.2f\tQ = %1.2f\n',F_name,NMI,Q);
fprintf('Fname_max = %1.2f\tNMI_max = %1.2f\tQ_max = %1.2f\n',F_name_max,NMI_max,Q_max);


