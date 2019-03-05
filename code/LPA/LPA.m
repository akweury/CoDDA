function [F_name,NMI,Q] = LPA(data,coordinate,realresult,k,colorArray)


addpath ..\mit_network_analysis_tools

[~,m] = size(data);
community = (1:1:m)'; 
LPA = zeros(m,1); % 最终社区聚类结果
hasChange = 1;

tic

iter = 0;
while hasChange == 1 % 只要还有节点变化，就继续循环
    iter = iter + 1;
    hasChange = 0; % 进入循环后，假设没有变化
    
    % 这里需要将节点的顺序打乱，然后按照打乱的顺序逐个确定该节点所属的社区
    % 随机生成一个由1-m组成的的m*1向量
    order = randperm(m)';

    for i = 1:m
        neighborCommunity = zeros(m,2); % 每个节点的相邻节点所对应的社区
        neighborCommunity(:,1) = (1:1:m); % 第一列为社区标号，第二列为该社区出现次数
        % 统计节点i的相邻节点中各个社区出现次数
        for j = 1:m
            if data(order(i,1),j) == 1 % 如果节点i与节点j相邻
                neighborCommunity(community(j,1),2) = neighborCommunity(community(j,1),2) + 1;
            end
        end
        % 查看社区 i 的相邻社区中哪个社区出现的次数最多,并更新当前节点的所在社区属性
        
        max_nb_labels = neighborCommunity(neighborCommunity(:,2)==max(neighborCommunity(:,2)),1);
%         hfcCommunity = max_nb_labels(randi(length(max_nb_labels)));
        hfcCommunity = max_nb_labels(1);
        
%         nth = mod(length(max_nb_labels),3);
%         if nth == 0
%             nth = 1;
%         end
%         hfcCommunity = max_nb_labels(nth,1);
        
        
%         nth = randi(10); % nth是随机数
%         maxCommunity = max(neighborCommunity(:,2)); % 频率最高的社区出现次数
%         maxCommunityPosition = find(neighborCommunity(:,2)==maxCommunity); % 频率最高的社区出现的所有位置
%         numOfMax = length(maxCommunityPosition); % 频率最高的社区出现的次数
%         nth = mod(nth,numOfMax); % 对次数取模，保证第n个数小于最大出现次数
%         if nth == 0
%             nth = 1;
%         end
%         hfcCommunity = maxCommunityPosition(nth,1);
        
        if community(order(i,1),1) ~= hfcCommunity
            hasChange = 1; % 出现次数最多的相邻社区与该节点对应社区不符，社区属性发生变化
            community(order(i,1),1) = hfcCommunity;
        end
        
    end 
%     if iter > 4
%         break;
%     end
    fprintf('第 %d 次循环...\n',iter);
end


% 将聚类出的t个社区的n个结果按照1-t重新命名
t = length(unique(community));
maxCommunityArray = max(community);
i = 1;
for j = 1:maxCommunityArray
    if sum(community(community==j)) == 0
        continue;
    end
    currentCommunity = community;
    if i ~=j
        currentCommunity(currentCommunity==i) = 0;
    end

    currentCommunity(currentCommunity==j) = i;
    currentCommunity(currentCommunity~=i) = 0;
    if sum(currentCommunity) > 0
        i = i + 1;
    end
    LPA = LPA + currentCommunity;
end
time = toc;



%% STEP : 聚类结果验证
% 社区评价标准：Fname 是对社区结果与真实社区的交叉和近似程度的衡量指标，范围是[0,1],数值越大说明结果越准确
% cls是结果社区，realresult是真实社区，k是聚类数目，目前暂定真实社区和结果社区的聚类数目都是k
F_name = evaluationF_name(LPA,realresult,k,t); 

% 社区评价标准：NMI 是归一化互信息，范围是[0,1]数值越大说明结果越准确
NMI = nmi(LPA,realresult);

% 社区质量评价标准：Q模块性是使用最广泛的衡量社区质量的评价标准之一
% CoDDA是聚类结果，k是聚类社区数，strike是图的邻接矩阵
modules = coms2modules(LPA);
Q = modularity_metric(modules,data);
fprintf('nodes: %d\tF_name=%1.2f\tNMI=%1.2f\tQ=%1.2f\n',m,F_name,NMI,Q);



filename = ['result\',num2str(m),'node-evaluation-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
fw = fopen(filename,'w+');
fprintf(fw,'节点数目: %4d\tF_name = %1.2f\tNMI = %1.2f\tQ = %1.2f\ttime = %1.4f\n\n',m,F_name,NMI,Q,time);
fclose(fw);

end