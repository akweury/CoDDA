function start_strike()

clear;clc;close all;

addpath ../dataset/data_strike/

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
strike_T = 1; % 深度稀疏自动编码器的层数

exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];


load strike.txt;    % 导入数据集的邻接矩阵
load strikecoordinate.txt % 导入数据集的点坐标
load realresult.txt; % 导入真实社区
pickmeans = 1; % Figure 1 k_means聚类结果
pichop = 2; % Figure 2 带h跳的聚类结果
picCoDDA = 7; % Figure 7 CoDDA聚类结果
picS = 8; % Figure 8 跳数阈值实验结果
picSigema = 9; % Figure 9 衰减因子实验结果
picBeta = 10; % Figure 10 惩罚因子权重实验结果
picT = 11; % Figure 11 编码器层数实验结果
picLambda = 12; % Figure 12 权重衰减项实验结果


strike_k = 3; % 社区个数

strike_d = [24 16 8 4 2 1]; % 每层的节点数



beta = 0.02; % 惩罚因子权重
Lambda = 0.0001; % 权重衰减项

minS = 1; % 最小跳数阈值
maxS = 5; % 最大跳数阈值

minSigema = 1; % 最小衰减因子 *10
maxSigema = 10; % 最大衰减因子 *10

minT = 1; % 最小编码器层数
maxT = 3; % 最大编码器层数

minBeta = 1; % 最小稀疏限制权重因子 *100
maxBeta = 10; % 最大稀疏限制权重因子 *100

minLambda = 1; % 最小权重衰减项　*100,000
maxLambda = 20; % 最大权重衰减项 *100,000

strike_colorArray = [[1,0,0];[0,0,1];[0,1,0]]; % 各个社区的显示颜色

theta = [S,sigema,beta,Lambda,picCoDDA,maxTimes...              % 1-6
    minS,maxS,...                     % 7-8
    minSigema,maxSigema,...      % 9-10
    minBeta,maxBeta,...            % 11-12
    minT,maxT,...                     % 13-14
    minLambda,maxLambda,...      % 15-16
    ];                                    

%% strike实验集

round = 1;
[S,sigema,T,beta,Lambda] = train(round,exper_shuffle,strike,strikecoordinate,realresult,strike_k,strike_T,strike_d,theta,strike_colorArray); % 进行strike实验
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

train(round,exper_shuffle,strike,strikecoordinate,realresult,strike_k,T,strike_d,theta,strike_colorArray); % 进行strike实验


fprintf('########################strike compete!########################\n');
fprintf('########################strike compete!########################\n');
fprintf('########################strike compete!########################\n');
end