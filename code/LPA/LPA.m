function [F_name,NMI,Q] = LPA(data,coordinate,realresult,k,colorArray)


addpath ..\mit_network_analysis_tools

[~,m] = size(data);
community = (1:1:m)'; 
LPA = zeros(m,1); % ��������������
hasChange = 1;

tic

iter = 0;
while hasChange == 1 % ֻҪ���нڵ�仯���ͼ���ѭ��
    iter = iter + 1;
    hasChange = 0; % ����ѭ���󣬼���û�б仯
    
    % ������Ҫ���ڵ��˳����ң�Ȼ���մ��ҵ�˳�����ȷ���ýڵ�����������
    % �������һ����1-m��ɵĵ�m*1����
    order = randperm(m)';

    for i = 1:m
        neighborCommunity = zeros(m,2); % ÿ���ڵ�����ڽڵ�����Ӧ������
        neighborCommunity(:,1) = (1:1:m); % ��һ��Ϊ������ţ��ڶ���Ϊ���������ִ���
        % ͳ�ƽڵ�i�����ڽڵ��и����������ִ���
        for j = 1:m
            if data(order(i,1),j) == 1 % ����ڵ�i��ڵ�j����
                neighborCommunity(community(j,1),2) = neighborCommunity(community(j,1),2) + 1;
            end
        end
        % �鿴���� i �������������ĸ��������ֵĴ������,�����µ�ǰ�ڵ��������������
        
        max_nb_labels = neighborCommunity(neighborCommunity(:,2)==max(neighborCommunity(:,2)),1);
%         hfcCommunity = max_nb_labels(randi(length(max_nb_labels)));
        hfcCommunity = max_nb_labels(1);
        
%         nth = mod(length(max_nb_labels),3);
%         if nth == 0
%             nth = 1;
%         end
%         hfcCommunity = max_nb_labels(nth,1);
        
        
%         nth = randi(10); % nth�������
%         maxCommunity = max(neighborCommunity(:,2)); % Ƶ����ߵ��������ִ���
%         maxCommunityPosition = find(neighborCommunity(:,2)==maxCommunity); % Ƶ����ߵ��������ֵ�����λ��
%         numOfMax = length(maxCommunityPosition); % Ƶ����ߵ��������ֵĴ���
%         nth = mod(nth,numOfMax); % �Դ���ȡģ����֤��n����С�������ִ���
%         if nth == 0
%             nth = 1;
%         end
%         hfcCommunity = maxCommunityPosition(nth,1);
        
        if community(order(i,1),1) ~= hfcCommunity
            hasChange = 1; % ���ִ�����������������ýڵ��Ӧ�����������������Է����仯
            community(order(i,1),1) = hfcCommunity;
        end
        
    end 
%     if iter > 4
%         break;
%     end
    fprintf('�� %d ��ѭ��...\n',iter);
end


% ���������t��������n���������1-t��������
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



%% STEP : ��������֤
% �������۱�׼��Fname �Ƕ������������ʵ�����Ľ���ͽ��Ƴ̶ȵĺ���ָ�꣬��Χ��[0,1],��ֵԽ��˵�����Խ׼ȷ
% cls�ǽ��������realresult����ʵ������k�Ǿ�����Ŀ��Ŀǰ�ݶ���ʵ�����ͽ�������ľ�����Ŀ����k
F_name = evaluationF_name(LPA,realresult,k,t); 

% �������۱�׼��NMI �ǹ�һ������Ϣ����Χ��[0,1]��ֵԽ��˵�����Խ׼ȷ
NMI = nmi(LPA,realresult);

% �����������۱�׼��Qģ������ʹ����㷺�ĺ����������������۱�׼֮һ
% CoDDA�Ǿ�������k�Ǿ�����������strike��ͼ���ڽӾ���
modules = coms2modules(LPA);
Q = modularity_metric(modules,data);
fprintf('nodes: %d\tF_name=%1.2f\tNMI=%1.2f\tQ=%1.2f\n',m,F_name,NMI,Q);



filename = ['result\',num2str(m),'node-evaluation-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
fw = fopen(filename,'w+');
fprintf(fw,'�ڵ���Ŀ: %4d\tF_name = %1.2f\tNMI = %1.2f\tQ = %1.2f\ttime = %1.4f\n\n',m,F_name,NMI,Q,time);
fclose(fw);

end