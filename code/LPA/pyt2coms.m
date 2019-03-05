clear ;clc;close all;
addpath ..\CoDDA
load cls.txt;
load realresult.txt; % �������ݼ�����ʵ����
load strike.txt;    % �������ݼ����ڽӾ���
data = strike;
k = 3; % ��������
LPA = cls;
[~,m] = size(data);
t = length(unique(cls));
%% STEP : ��������֤
% �������۱�׼��Fname �Ƕ������������ʵ�����Ľ���ͽ��Ƴ̶ȵĺ���ָ�꣬��Χ��[0,1],��ֵԽ��˵�����Խ׼ȷ
% cls�ǽ��������realresult����ʵ������k�Ǿ�����Ŀ��Ŀǰ�ݶ���ʵ�����ͽ�������ľ�����Ŀ����k
F_name = evaluationF_name(LPA,realresult,k,t); 

% �������۱�׼��NMI �ǹ�һ������Ϣ����Χ��[0,1]��ֵԽ��˵�����Խ׼ȷ
NMI = evaluationNMI(LPA,realresult,k,t);

% �����������۱�׼��Qģ������ʹ����㷺�ĺ����������������۱�׼֮һ
% CoDDA�Ǿ�������k�Ǿ�����������strike��ͼ���ڽӾ���
Q = modularity(LPA,k,data);

filename = ['result\',num2str(m),'node-evaluation-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
fw = fopen(filename,'w+');
fprintf(fw,'�ڵ���Ŀ: %4d\tF_name = %1.2f\tNMI = %1.2f\tQ = %1.2f\n\n',m,F_name,NMI,Q);
fclose(fw);