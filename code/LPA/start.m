clear;clc;close all;

% addpath \\charlietp\code\CoDDA\data_strike
% addpath \\charlietp\code\\CoDDA\data_football
addpath ..\dataset\data_strike
addpath ..\dataset\data_football
addpath ..\CoDDA


%% strikeʵ�鼯

%-----------------------����---------------------------------------

% load strike.txt;    % �������ݼ����ڽӾ���
% load strikecoordinate.txt % �������ݼ��ĵ�����
% load realresult.txt; % ������ʵ����
% 
% k = 3; % ��ʵ��������
% colorArray = [[1,0,0];[0,0,1];[0,1,0]]; % ������������ʾ��ɫ
% 
% %***************************ִ��*************************************
% tic
% LPA(strike,strikecoordinate,realresult,k,colorArray);
% t = toc;

%-----------------------����---------------------------------------

% load football_adjacency.txt;    % �������ݼ����ڽӾ���
% load football_coordinate.txt % �������ݼ��ĵ�����
% load football_community.txt; % �������ݼ�����ʵ����
% k = 12; % ��������
% colorArray = [[1,0,0];[0,0,1];[0,1,0];[0.0977,0.0977,0.4375];[0.18,0.54,0.34];[0.33,0.41,0.18];...
%     [1,0.6445,0];[0.82,0.41,0.12];[0.2183,0.2382,0.5430];[0.5430,0,0];[1,0.4102,0.7031];[0.8,0.1484,0.1484]];
% 
% %***************************ִ��*************************************
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


load lj_adj.txt;    % �������ݼ����ڽӾ���
load lj_coordinate.txt % �������ݼ��ĵ�����
load lj_coms.txt; % �������ݼ�����ʵ����
k = 8; % ��������
colorArray = [[1,0,0];[0,0,1];[0,1,0];[0.0977,0.0977,0.4375];[0.18,0.54,0.34];[0.33,0.41,0.18];...
    [1,0.6445,0];[0.82,0.41,0.12]];

%***************************ִ��*************************************
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


