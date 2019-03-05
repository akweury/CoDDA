function [S,sigema,T,beta,Lambda] = train(round,exper_shuffle,data,coordinate,realresult,k,T,d,theta,colorArray)

addpath ../mit_network_analysis_tools/
%% STEP 1: �������

% -------��������----------------
data(data>0) = 1; % ������ݼ���ȷ������Ϊ0-1�ڽӾ���
S = theta(1,1); 
sigema = theta(1,2); % ˥������
beta = theta(1,3);
Lambda = theta(1,4); 
picNum = theta(1,5); % ��ʾͼ��ı��
maxTimes = theta(1,6); % ��������
[~,m] = size(data);

% -------����ʵ��Ĳ���------------

minS = theta(1,7); % ��С����
maxS = theta(1,8); % �������

minSigema = theta(1,9); % ��С˥������
maxSigema = theta(1,10); % ���˥������

minBeta = theta(1,11); % ��С�ͷ�����Ȩ��
maxBeta = theta(1,12); % ���ͷ�����Ȩ��

minT = theta(1,13); % ��С����������
maxT = theta(1,14); % ������������


minLambda = theta(1,15); % ��СȨ��˥�����10000��
maxLambda = theta(1,16); % ���Ȩ��˥�����10000��


 
fprintf('***************************************round %d*****************************************************\n',round);
%% STEP 2: CoDDA����ʵ��ǰ


theta = [S,sigema,beta,Lambda,picNum];
CoDDA(1,data,coordinate,realresult,k,T,d,theta,colorArray);


%% STEP 4: ����ʵ�� 
tic
num_experment = sum(exper_shuffle);
cur_experment = 1;
fprintf('\n(%d)��ʼ����ʵ��...һ��%d��\n',m,num_experment);

% % STEP 4.1: ������ֵ====================================================================

theta = [minS,maxS,sigema,k,T,maxTimes,beta,Lambda,d]; 

% ��һ�����������ݼ�
% �ڶ�����������С����,�������,˥������,������Ŀ�����ϡ���Զ�������������ÿ��Ľڵ���
% ��������������ʵ���������������
% ���ĸ���������ʵ����
% �����������ÿ����������ɫ
%----------------------------------
if exper_shuffle(1,1) == 1
    S = parameterS(round,cur_experment,num_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end

% % STEP 4.2: ˥������=====================================================================

theta = [minSigema,maxSigema,S,k,T,maxTimes,beta,Lambda,d]; % ���ɲ����ļ��ϣ��·���ע�ͣ�

%----------------------------------
% ��һ�����������ݼ�
% �ڶ�����������С˥������,���˥������,������ֵ,������Ŀ�����ϡ���Զ�������������ÿ��Ľڵ���
% ��������������ʵ���������������
% ���ĸ���������ʵ����
% �����������ÿ����������ɫ
if exper_shuffle(1,2) == 1
    sigema = parameterSigema(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end

% % STEP 4.3: ���ϡ���Զ��������Ĳ���========================================================
% 
theta = [minT,maxT,sigema,S,k,T,maxTimes,beta,Lambda,d]; % ���ɲ����ļ��ϣ��·���ע�ͣ�
% 
% %----------------------------------
% % ��һ�����������ݼ�
% % �ڶ�����������С����,������,˥������,������ֵ,������Ŀ,���ϡ���Զ�����������,��������,�ͷ�����Ȩ��,ÿ��Ľڵ���
% % ��������������ʵ���������������
% % ���ĸ���������ʵ����
% % �����������ÿ����������ɫ
if exper_shuffle(1,3) == 1
    T = parameterT(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end
% % STEP 4.4: ϡ���Գͷ����ӵ�Ȩ��============================================================
% 
theta = [minBeta,maxBeta,sigema,S,k,T,maxTimes,beta,Lambda,d]; % ���ɲ����ļ��ϣ��·���ע�ͣ�
% 
% %----------------------------------
% % ��һ�����������ݼ�
% % �ڶ�����������С�ͷ�����Ȩ�أ����ͷ�����Ȩ�أ�˥�����ӣ�������ֵ��������Ŀ�����ϡ���Զ������������������������ͷ�����Ȩ�أ�ÿ��Ľڵ���
% % ��������������ʵ���������������
% % ���ĸ���������ʵ����
% % �����������ÿ����������ɫ
if exper_shuffle(1,4) == 1
    beta = parameterBeta(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end
% 

% STEP 4.5:Ȩ��˥����========================================================

theta = [minLambda,maxLambda,sigema,S,k,T,maxTimes,beta,Lambda,d]; % ���ɲ����ļ��ϣ��·���ע�ͣ�

%----------------------------------
% ��һ�����������ݼ�
% �ڶ�����������С����,������,˥������,������ֵ,������Ŀ,���ϡ���Զ�����������,��������,�ͷ�����Ȩ��,ÿ��Ľڵ���
% ��������������ʵ���������������
% ���ĸ���������ʵ����
% �����������ÿ����������ɫ
if exper_shuffle(1,5) == 1
    Lambda = parameterLambda(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end
t = toc;
fprintf('\n----%d nodes Graph BestParameter(after %d times parameter experment)-----\n',m,maxTimes);
fprintf('----node=%d\n',m);
fprintf('----S=%d\n',S);
fprintf('----sigema=%1.7f\n',sigema);
fprintf('----T=%d\n',T);
fprintf('----beta=%1.7f\n',beta);
fprintf('----lambda=%1.6f\n',Lambda);
fprintf('----times=%d\n',maxTimes);
fprintf('----Total: %f10.2f seconds\n',t);


%% STEP 5: CoDDA����ʵ���

theta = [S,sigema,beta,Lambda,picNum];
[Fsame,NMI,Q,t] = CoDDA(1,data,coordinate,realresult,k,T,d,theta,colorArray);

% �����ļ�
filename = 'result\parameter.xlsx';
[~, ~, row] = xlsread(filename);
[rowN, ~]=size(row);
sheet=1;
xlsRange=['A',num2str(rowN+1)];
xlswrite(filename,[m,S,sigema,T,beta,Lambda,maxTimes,Fsame,NMI,Q,t],sheet,xlsRange);
xlsRange=['L',num2str(rowN+1)];
datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
xlswrite(filename,{datetime_str},sheet,xlsRange);
xlsRange=['M',num2str(rowN+1)];
exper_shuffle_str = num2str(exper_shuffle);
xlswrite(filename,{exper_shuffle_str},sheet,xlsRange);

fprintf('\n***************************************round %d end********************************************\n\n',round);
end
