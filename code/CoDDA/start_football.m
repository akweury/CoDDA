function start_football()
clear;clc;close all;

addpath ../dataset/data_football/

addpath ../mit_network_analysis_tools/

% 选择参数实验 1--执行  0--不执行
S_shuffle =             1;                  % 跳数阈值实验
sigema_shuffle =        1;                  % 衰减因子实验
T_shuffle =             1;                  % 稀疏自编码器层数实验
beta_shuffle =          0;                  % 惩罚因子权重实验
Lambda_shuffle =        0;                  % 权重衰减项


maxTimes =             100;                  % 迭代次数

S = 1; % 跳数阈值
sigema = 0.1; % 衰减因子
football_T = 1; % 深度稀疏自动编码器的层数

exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];


load football_adjacency.txt;    % 导入数据集的邻接矩阵
load football_coordinate.txt % 导入数据集的点坐标
load football_community.txt; % 导入数据集的真实社区

football_k = 12; % 社区个数
football_d = [180 128 64 32 16 8 4 2 1]; % 每层的节点数

beta = 0.01; % 惩罚因子权重
Lambda = 0.0001; % 权重衰减项

minS = 1; % 最小跳数阈值
maxS = 5; % 最大跳数阈值

minSigema = 1; % 最小衰减因子的十倍
maxSigema = 10; % 最大衰减因子的十倍

minT = 1; % 最小编码器层数
maxT = 5; % 最大编码器层数

minBeta = 1; % 最小惩罚因子权重
maxBeta = 20; % 最大惩罚因子权重

minLambda = 11; % 最小权重衰减项的10000倍
maxLambda = 20; % 最大权重衰减项的10000倍

pickmeans = 1; % Figure 1 k_means聚类结果
pichop = 2; % Figure 2 带h跳的聚类结果
picCoDDA = 7; % Figure 7 CoDDA聚类结果

picS = 8; % Figure 8 跳数阈值实验结果
picSigema = 9; % Figure 9 衰减因子实验结果
picBeta = 10; % Figure 10 惩罚因子权重实验结果
picT = 11; % Figure 11 编码器层数实验结果
picLambda = 12; % Figure 12 权重衰减项实验结果

% red,blue,green,MidnightBlue,SeaGreen,DarkOliveGreen,
% Orange,Chocolate,DarkSlateBlue,Red4,HotPint,Firebrick3
football_colorArray = [[1,0,0];[0,0,1];[0,1,0];[0.0977,0.0977,0.4375];[0.18,0.54,0.34];[0.33,0.41,0.18];...
    [1,0.6445,0];[0.82,0.41,0.12];[0.2183,0.2382,0.5430];[0.5430,0,0];[1,0.4102,0.7031];[0.8,0.1484,0.1484]];

theta = [S,sigema,beta,Lambda,picCoDDA,maxTimes...              % 1-6
    minS,maxS,...                     % 7-8
    minSigema,maxSigema,...      % 9-10
    minBeta,maxBeta,...            % 11-12
    minT,maxT,...                     % 13-14
    minLambda,maxLambda,...      % 15-16
    ];                                             % 20-end

%% football实验集

round = 1;
[S,sigema,T,beta,Lambda] = train(round,exper_shuffle,football_adjacency,football_coordinate,football_community,football_k,football_T,football_d,theta,football_colorArray); % 进行football实验
round = round + 1;


% 选择参数实验 1--执行  0--不执行
S_shuffle =             1;                  % 跳数阈值实验
sigema_shuffle =        1;                  % 衰减因子实验
T_shuffle =             1;                  % 稀疏自编码器层数实验
beta_shuffle =          0;                  % 惩罚因子权重实验
Lambda_shuffle =        0;                  % 权重衰减项

maxTimes =              100;                  % 迭代次数

exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];

theta = [S,sigema,beta,Lambda,picCoDDA,maxTimes...              % 1-6
    minS,maxS,...                     % 7-8
    minSigema,maxSigema,...      % 9-10
    minBeta,maxBeta,...            % 11-12
    minT,maxT,...                     % 13-14
    minLambda,maxLambda,...      % 15-16
    ];    

train(round,exper_shuffle,football_adjacency,football_coordinate,football_community,football_k,T,football_d,theta,football_colorArray); % 进行football实验

fprintf('########################football compete!########################\n');
fprintf('########################football compete!########################\n');
fprintf('########################football compete!########################\n');
end