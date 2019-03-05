function [ Labelnew ] = LPA2( adjacent_matrix, coordinate,realresult,k,colorArray)
addpath L:\Abschlussarbeit\code\CoDDA
	label = 1:size(adjacent_matrix,2);
    tic
    N = size(adjacent_matrix,2);
    [~,m] = size(adjacent_matrix);
    LPA2 = zeros(m,1); % 最终社区聚类结果
    
    Label1 = label;
    Label2 = Label1;
    Labelnew = Label1;
    flag=1;
    while(1)
        for i=1:N
            nb_lables = Labelnew(adjacent_matrix(i,:)==1);%找到邻居下标对应的标签
            if size(nb_lables,2)>0
                x = tabulate(nb_lables);
                max_nb_labels = x(x(:,2)==max(x(:,2)),1);
                Labelnew(i) = max_nb_labels(randi(length(max_nb_labels)));
            end
        end
        % 收敛条件,预防跳跃
        if all(Labelnew==Label1)||all(Labelnew==Label2)
            break;
        else
            if flag==1
                Label1 = Labelnew;
                flag=0;
            else
                Label2 = Labelnew;
                flag=1;
            end
        end
    end
	community = Labelnew;
    t = length(unique(community));
    community = community';
    
% 将聚类出的t个社区的n个结果按照1-t重新命名
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
    LPA2 = LPA2 + currentCommunity;
end
    
    
    
    time = toc;



%% STEP : 聚类结果验证
% 社区评价标准：Fname 是对社区结果与真实社区的交叉和近似程度的衡量指标，范围是[0,1],数值越大说明结果越准确
% cls是结果社区，realresult是真实社区，k是聚类数目，目前暂定真实社区和结果社区的聚类数目都是k
F_name = evaluationF_name(LPA2,realresult,k,t); 

% 社区评价标准：NMI 是归一化互信息，范围是[0,1]数值越大说明结果越准确
NMI = evaluationNMI(LPA2,realresult,k,t);

% 社区质量评价标准：Q模块性是使用最广泛的衡量社区质量的评价标准之一
% CoDDA是聚类结果，k是聚类社区数，strike是图的邻接矩阵
Q = modularity(LPA2,k,adjacent_matrix);

filename = ['result\',num2str(m),'node-evaluation-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
fw = fopen(filename,'w+');
fprintf(fw,'节点数目: %4d\tF_name = %1.2f\tNMI = %1.2f\tQ = %1.2f\ttime = %1.4f\n\n',m,F_name,NMI,Q,time);
fclose(fw);
    
end