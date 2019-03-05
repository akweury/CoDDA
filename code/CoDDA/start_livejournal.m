function start_livejournal()
clear;clc;

addpath ../dataset/data_LiveJournal/

addpath ../mit_network_analysis_tools/

% ѡ�����ʵ�� 1--ִ��  0--��ִ��
S_shuffle =             0;                  % ������ֵʵ��
sigema_shuffle =        1;                  % ˥������ʵ��
T_shuffle =             1;                  % ϡ���Ա���������ʵ��
beta_shuffle =          0;                  % �ͷ�����Ȩ��ʵ��
Lambda_shuffle =        0;                  % Ȩ��˥����


maxTimes =             5;                  % ��������

S = 6; % ������ֵ
sigema = 0.1; % ˥������
lj_T = 5; % ���ϡ���Զ��������Ĳ���


exper_shuffle = [S_shuffle,...
                 sigema_shuffle,...
                 T_shuffle,...
                 beta_shuffle,...
                 Lambda_shuffle,...
                 ];

fprintf('loading adj matrix...');
load lj_adj.txt;    % �������ݼ����ڽӾ���
fprintf('finished!\n');
fprintf('loading coordinate matrix...');
load lj_coordinate.txt % �������ݼ��ĵ�����
fprintf('finished!\n');
fprintf('loading communities matrix...');
load lj_coms.txt; % ������ʵ����
fprintf('finished!\n');
pickmeans = 1; % Figure 1 k_means������
pichop = 2; % Figure 2 ��h���ľ�����
picCoDDA = 7; % Figure 7 CoDDA������
picS = 8; % Figure 8 ������ֵʵ����
picSigema = 9; % Figure 9 ˥������ʵ����
picBeta = 10; % Figure 10 �ͷ�����Ȩ��ʵ����
picT = 11; % Figure 11 ����������ʵ����
picLambda = 12; % Figure 12 Ȩ��˥����ʵ����


lj_k = 8; % ��������
lj_d = [6368 4096 2048 1024 512 256]; % ÿ��Ľڵ���



beta = 0.01; % �ͷ�����Ȩ��
Lambda = 0.0001; % Ȩ��˥����

minS = 1; % ��С������ֵ
maxS = 7; % ���������ֵ

minSigema = 1; % ��С˥������ *10
maxSigema = 10; % ���˥������ *10

minBeta = 1; % ��С�ͷ�����Ȩ�� *100
maxBeta = 10; % ���ͷ�����Ȩ�� *100

minT = 1; % ��С����������
maxT = 6; % ������������

minLambda = 1; % ��СȨ��˥���*100,000
maxLambda = 20; % ���Ȩ��˥���� *100,000

lj_colorArray = colormap(hot); % ������������ʾ��ɫ

theta = [S,sigema,beta,Lambda,picCoDDA,maxTimes...              % 1-6
    minS,maxS,...                     % 7-8
    minSigema,maxSigema,...      % 9-10
    minBeta,maxBeta,...            % 11-12
    minT,maxT,...                     % 13-14
    minLambda,maxLambda,...      % 15-16
    ];                                    

%% LiveJournalʵ�鼯

round = 1;
[S,sigema,T,beta,Lambda] = train(round,exper_shuffle,lj_adj,lj_coordinate,lj_coms,lj_k,lj_T,lj_d,theta,lj_colorArray); % ����LiveJournalʵ��
round = round + 1;

% ѡ�����ʵ�� 1--ִ��  0--��ִ��
S_shuffle =             1;                  % ������ֵʵ��
sigema_shuffle =        1;                  % ˥������ʵ��
T_shuffle =             1;                  % ϡ���Ա���������ʵ��
beta_shuffle =          0;                  % �ͷ�����Ȩ��ʵ��
Lambda_shuffle =        0;                  % Ȩ��˥����

maxTimes =              5;                  % ��������

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

train(round,exper_shuffle,lj_adj,lj_coordinate,lj_coms,lj_k,lj_T,lj_d,theta,lj_colorArray); % ����LiveJournalʵ��

fprintf('########################liveJournal compete!########################');
fprintf('########################liveJournal compete!########################');
fprintf('########################liveJournal compete!########################');

end