function [S,sigema,T,beta,Lambda] = train(round,exper_shuffle,data,coordinate,realresult,k,T,d,theta,colorArray)

addpath ../mit_network_analysis_tools/
%% STEP 1: 导入参数

% -------基本参数----------------
data(data>0) = 1; % 检查数据集，确保内容为0-1邻接矩阵
S = theta(1,1); 
sigema = theta(1,2); % 衰减因子
beta = theta(1,3);
Lambda = theta(1,4); 
picNum = theta(1,5); % 显示图像的编号
maxTimes = theta(1,6); % 迭代次数
[~,m] = size(data);

% -------参数实验的参数------------

minS = theta(1,7); % 最小跳数
maxS = theta(1,8); % 最大跳数

minSigema = theta(1,9); % 最小衰减因子
maxSigema = theta(1,10); % 最大衰减因子

minBeta = theta(1,11); % 最小惩罚因子权重
maxBeta = theta(1,12); % 最大惩罚因子权重

minT = theta(1,13); % 最小编码器层数
maxT = theta(1,14); % 最大编码器层数


minLambda = theta(1,15); % 最小权重衰减项的10000倍
maxLambda = theta(1,16); % 最大权重衰减项的10000倍


 
fprintf('***************************************round %d*****************************************************\n',round);
%% STEP 2: CoDDA参数实验前


theta = [S,sigema,beta,Lambda,picNum];
CoDDA(1,data,coordinate,realresult,k,T,d,theta,colorArray);


%% STEP 4: 参数实验 
tic
num_experment = sum(exper_shuffle);
cur_experment = 1;
fprintf('\n(%d)开始参数实验...一共%d个\n',m,num_experment);

% % STEP 4.1: 跳数阈值====================================================================

theta = [minS,maxS,sigema,k,T,maxTimes,beta,Lambda,d]; 

% 第一个参数：数据集
% 第二个参数：最小跳数,最大跳数,衰减因子,聚类数目，深度稀疏自动编码器层数，每层的节点数
% 第三个参数：真实社区各个点的坐标
% 第四个参数：真实社区
% 第五个参数：每个社区的颜色
%----------------------------------
if exper_shuffle(1,1) == 1
    S = parameterS(round,cur_experment,num_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end

% % STEP 4.2: 衰减因子=====================================================================

theta = [minSigema,maxSigema,S,k,T,maxTimes,beta,Lambda,d]; % 若干参数的集合（下方有注释）

%----------------------------------
% 第一个参数：数据集
% 第二个参数：最小衰减因子,最大衰减因子,跳数阈值,聚类数目，深度稀疏自动编码器层数，每层的节点数
% 第三个参数：真实社区各个点的坐标
% 第四个参数：真实社区
% 第五个参数：每个社区的颜色
if exper_shuffle(1,2) == 1
    sigema = parameterSigema(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end

% % STEP 4.3: 深度稀疏自动编码器的层数========================================================
% 
theta = [minT,maxT,sigema,S,k,T,maxTimes,beta,Lambda,d]; % 若干参数的集合（下方有注释）
% 
% %----------------------------------
% % 第一个参数：数据集
% % 第二个参数：最小层数,最大层数,衰减因子,跳数阈值,聚类数目,深度稀疏自动编码器层数,迭代次数,惩罚因子权重,每层的节点数
% % 第三个参数：真实社区各个点的坐标
% % 第四个参数：真实社区
% % 第五个参数：每个社区的颜色
if exper_shuffle(1,3) == 1
    T = parameterT(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end
% % STEP 4.4: 稀疏性惩罚因子的权重============================================================
% 
theta = [minBeta,maxBeta,sigema,S,k,T,maxTimes,beta,Lambda,d]; % 若干参数的集合（下方有注释）
% 
% %----------------------------------
% % 第一个参数：数据集
% % 第二个参数：最小惩罚因子权重，最大惩罚因子权重，衰减因子，跳数阈值，聚类数目，深度稀疏自动编码器层数，迭代次数，惩罚因子权重，每层的节点数
% % 第三个参数：真实社区各个点的坐标
% % 第四个参数：真实社区
% % 第五个参数：每个社区的颜色
if exper_shuffle(1,4) == 1
    beta = parameterBeta(round,num_experment,cur_experment,data,theta,coordinate,realresult,colorArray);
    cur_experment = cur_experment+1;
end
% 

% STEP 4.5:权重衰减项========================================================

theta = [minLambda,maxLambda,sigema,S,k,T,maxTimes,beta,Lambda,d]; % 若干参数的集合（下方有注释）

%----------------------------------
% 第一个参数：数据集
% 第二个参数：最小层数,最大层数,衰减因子,跳数阈值,聚类数目,深度稀疏自动编码器层数,迭代次数,惩罚因子权重,每层的节点数
% 第三个参数：真实社区各个点的坐标
% 第四个参数：真实社区
% 第五个参数：每个社区的颜色
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


%% STEP 5: CoDDA参数实验后

theta = [S,sigema,beta,Lambda,picNum];
[Fsame,NMI,Q,t] = CoDDA(1,data,coordinate,realresult,k,T,d,theta,colorArray);

% 保存文件
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
