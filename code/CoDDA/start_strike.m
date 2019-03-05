function start_strike()

clear;clc;close all;

addpath ../dataset/data_strike/

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
strike_T = 1; % ���ϡ���Զ��������Ĳ���

exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];


load strike.txt;    % �������ݼ����ڽӾ���
load strikecoordinate.txt % �������ݼ��ĵ�����
load realresult.txt; % ������ʵ����
pickmeans = 1; % Figure 1 k_means������
pichop = 2; % Figure 2 ��h���ľ�����
picCoDDA = 7; % Figure 7 CoDDA������
picS = 8; % Figure 8 ������ֵʵ����
picSigema = 9; % Figure 9 ˥������ʵ����
picBeta = 10; % Figure 10 �ͷ�����Ȩ��ʵ����
picT = 11; % Figure 11 ����������ʵ����
picLambda = 12; % Figure 12 Ȩ��˥����ʵ����


strike_k = 3; % ��������

strike_d = [24 16 8 4 2 1]; % ÿ��Ľڵ���



beta = 0.02; % �ͷ�����Ȩ��
Lambda = 0.0001; % Ȩ��˥����

minS = 1; % ��С������ֵ
maxS = 5; % ���������ֵ

minSigema = 1; % ��С˥������ *10
maxSigema = 10; % ���˥������ *10

minT = 1; % ��С����������
maxT = 3; % ������������

minBeta = 1; % ��Сϡ������Ȩ������ *100
maxBeta = 10; % ���ϡ������Ȩ������ *100

minLambda = 1; % ��СȨ��˥���*100,000
maxLambda = 20; % ���Ȩ��˥���� *100,000

strike_colorArray = [[1,0,0];[0,0,1];[0,1,0]]; % ������������ʾ��ɫ

theta = [S,sigema,beta,Lambda,picCoDDA,maxTimes...              % 1-6
    minS,maxS,...                     % 7-8
    minSigema,maxSigema,...      % 9-10
    minBeta,maxBeta,...            % 11-12
    minT,maxT,...                     % 13-14
    minLambda,maxLambda,...      % 15-16
    ];                                    

%% strikeʵ�鼯

round = 1;
[S,sigema,T,beta,Lambda] = train(round,exper_shuffle,strike,strikecoordinate,realresult,strike_k,strike_T,strike_d,theta,strike_colorArray); % ����strikeʵ��
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

train(round,exper_shuffle,strike,strikecoordinate,realresult,strike_k,T,strike_d,theta,strike_colorArray); % ����strikeʵ��


fprintf('########################strike compete!########################\n');
fprintf('########################strike compete!########################\n');
fprintf('########################strike compete!########################\n');
end