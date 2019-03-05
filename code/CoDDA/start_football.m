function start_football()
clear;clc;close all;

addpath ../dataset/data_football/

addpath ../mit_network_analysis_tools/

% ѡ�����ʵ�� 1--ִ��  0--��ִ��
S_shuffle =             1;                  % ������ֵʵ��
sigema_shuffle =        1;                  % ˥������ʵ��
T_shuffle =             1;                  % ϡ���Ա���������ʵ��
beta_shuffle =          0;                  % �ͷ�����Ȩ��ʵ��
Lambda_shuffle =        0;                  % Ȩ��˥����


maxTimes =             100;                  % ��������

S = 1; % ������ֵ
sigema = 0.1; % ˥������
football_T = 1; % ���ϡ���Զ��������Ĳ���

exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];


load football_adjacency.txt;    % �������ݼ����ڽӾ���
load football_coordinate.txt % �������ݼ��ĵ�����
load football_community.txt; % �������ݼ�����ʵ����

football_k = 12; % ��������
football_d = [180 128 64 32 16 8 4 2 1]; % ÿ��Ľڵ���

beta = 0.01; % �ͷ�����Ȩ��
Lambda = 0.0001; % Ȩ��˥����

minS = 1; % ��С������ֵ
maxS = 5; % ���������ֵ

minSigema = 1; % ��С˥�����ӵ�ʮ��
maxSigema = 10; % ���˥�����ӵ�ʮ��

minT = 1; % ��С����������
maxT = 5; % ������������

minBeta = 1; % ��С�ͷ�����Ȩ��
maxBeta = 20; % ���ͷ�����Ȩ��

minLambda = 11; % ��СȨ��˥�����10000��
maxLambda = 20; % ���Ȩ��˥�����10000��

pickmeans = 1; % Figure 1 k_means������
pichop = 2; % Figure 2 ��h���ľ�����
picCoDDA = 7; % Figure 7 CoDDA������

picS = 8; % Figure 8 ������ֵʵ����
picSigema = 9; % Figure 9 ˥������ʵ����
picBeta = 10; % Figure 10 �ͷ�����Ȩ��ʵ����
picT = 11; % Figure 11 ����������ʵ����
picLambda = 12; % Figure 12 Ȩ��˥����ʵ����

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

%% footballʵ�鼯

round = 1;
[S,sigema,T,beta,Lambda] = train(round,exper_shuffle,football_adjacency,football_coordinate,football_community,football_k,football_T,football_d,theta,football_colorArray); % ����footballʵ��
round = round + 1;


% ѡ�����ʵ�� 1--ִ��  0--��ִ��
S_shuffle =             1;                  % ������ֵʵ��
sigema_shuffle =        1;                  % ˥������ʵ��
T_shuffle =             1;                  % ϡ���Ա���������ʵ��
beta_shuffle =          0;                  % �ͷ�����Ȩ��ʵ��
Lambda_shuffle =        0;                  % Ȩ��˥����

maxTimes =              100;                  % ��������

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

train(round,exper_shuffle,football_adjacency,football_coordinate,football_community,football_k,T,football_d,theta,football_colorArray); % ����footballʵ��

fprintf('########################football compete!########################\n');
fprintf('########################football compete!########################\n');
fprintf('########################football compete!########################\n');
end