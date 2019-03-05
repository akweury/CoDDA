function start_livejournal()
clear;clc;

addpath ../dataset/data_LiveJournal/

addpath ../mit_network_analysis_tools/

% 选择参数实验 1--执行  0--不执行
S_shuffle =             0;                  % 跳数阈值实验
sigema_shuffle =        1;                  % 衰减因子实验
T_shuffle =             1;                  % 稀疏自编码器层数实验
beta_shuffle =          0;                  % 惩罚因子权重实验
Lambda_shuffle =        0;                  % 权重衰减项


maxTimes =             5;                  % 迭代次数

S = 6; % 跳数阈值
sigema = 0.1; % 衰减因子
lj_T = 5; % 深度稀疏自动编码器的层数


exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];

fprintf('loading adj matrix...');
load lj_adj.txt;    % 导入数据集的邻接矩阵
fprintf('finished!\n');
fprintf('loading coordinate matrix...');
load lj_coordinate.txt % 导入数据集的点坐标
fprintf('finished!\n');
fprintf('loading communities matrix...');
load lj_coms.txt; % 导入真实社区
fprintf('finished!\n');
pickmeans = 1; % Figure 1 k_means聚类结果
pichop = 2; % Figure 2 带h跳的聚类结果
picCoDDA = 7; % Figure 7 CoDDA聚类结果
picS = 8; % Figure 8 跳数阈值实验结果
picSigema = 9; % Figure 9 衰减因子实验结果
picBeta = 10; % Figure 10 惩罚因子权重实验结果
picT = 11; % Figure 11 编码器层数实验结果
picLambda = 12; % Figure 12 权重衰减项实验结果


lj_k = 8; % 社区个数
lj_d = [6368 4096 2048 1024 512 256]; % 每层的节点数



beta = 0.01; % 惩罚因子权重
Lambda = 0.0001; % 权重衰减项

minS = 1; % 最小跳数阈值
maxS = 7; % 最大跳数阈值

minSigema = 1; % 最小衰减因子 *10
maxSigema = 10; % 最大衰减因子 *10

minBeta = 1; % 最小惩罚因子权重 *100
maxBeta = 10; % 最大惩罚因子权重 *100

minT = 1; % 最小编码器层数
maxT = 6; % 最大编码器层数

minLambda = 1; % 最小权重衰减项　*100,000
maxLambda = 20; % 最大权重衰减项 *100,000

lj_colorArray = colormap(hot); % 各个社区的显示颜色

theta = [S,sigema,beta,Lambda,picCoDDA,maxTimes...              % 1-6
    minS,maxS,...                     % 7-8
    minSigema,maxSigema,...      % 9-10
    minBeta,maxBeta,...            % 11-12
    minT,maxT,...                     % 13-14
    minLambda,maxLambda,...      % 15-16
    ];                                    

%% LiveJournal实验集

round = 1;
[S,sigema,T,beta,Lambda] = train(round,exper_shuffle,lj_adj,lj_coordinate,lj_coms,lj_k,lj_T,lj_d,theta,lj_colorArray); % 进行LiveJournal实验
round = round + 1;

% 选择参数实验 1--执行  0--不执行
S_shuffle =             1;                  % 跳数阈值实验
sigema_shuffle =        1;                  % 衰减因子实验
T_shuffle =             1;                  % 稀疏自编码器层数实验
beta_shuffle =          0;                  % 惩罚因子权重实验
Lambda_shuffle =        0;                  % 权重衰减项

maxTimes =              5;                  % 迭代次数

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

train(round,exper_shuffle,lj_adj,lj_coordinate,lj_coms,lj_k,lj_T,lj_d,theta,lj_colorArray); % 进行LiveJournal实验

fprintf('########################liveJournal compete!########################');
fprintf('########################liveJournal compete!########################');
fprintf('########################liveJournal compete!########################');

end