function [ Labelnew ] = LPA2( adjacent_matrix, coordinate,realresult,k,colorArray)
addpath L:\Abschlussarbeit\code\CoDDA
	label = 1:size(adjacent_matrix,2);
    tic
    N = size(adjacent_matrix,2);
    [~,m] = size(adjacent_matrix);
    LPA2 = zeros(m,1); % ��������������
    
    Label1 = label;
    Label2 = Label1;
    Labelnew = Label1;
    flag=1;
    while(1)
        for i=1:N
            nb_lables = Labelnew(adjacent_matrix(i,:)==1);%�ҵ��ھ��±��Ӧ�ı�ǩ
            if size(nb_lables,2)>0
                x = tabulate(nb_lables);
                max_nb_labels = x(x(:,2)==max(x(:,2)),1);
                Labelnew(i) = max_nb_labels(randi(length(max_nb_labels)));
            end
        end
        % ��������,Ԥ����Ծ
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
    
% ���������t��������n���������1-t��������
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



%% STEP : ��������֤
% �������۱�׼��Fname �Ƕ������������ʵ�����Ľ���ͽ��Ƴ̶ȵĺ���ָ�꣬��Χ��[0,1],��ֵԽ��˵�����Խ׼ȷ
% cls�ǽ��������realresult����ʵ������k�Ǿ�����Ŀ��Ŀǰ�ݶ���ʵ�����ͽ�������ľ�����Ŀ����k
F_name = evaluationF_name(LPA2,realresult,k,t); 

% �������۱�׼��NMI �ǹ�һ������Ϣ����Χ��[0,1]��ֵԽ��˵�����Խ׼ȷ
NMI = evaluationNMI(LPA2,realresult,k,t);

% �����������۱�׼��Qģ������ʹ����㷺�ĺ����������������۱�׼֮һ
% CoDDA�Ǿ�������k�Ǿ�����������strike��ͼ���ڽӾ���
Q = modularity(LPA2,k,adjacent_matrix);

filename = ['result\',num2str(m),'node-evaluation-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
fw = fopen(filename,'w+');
fprintf(fw,'�ڵ���Ŀ: %4d\tF_name = %1.2f\tNMI = %1.2f\tQ = %1.2f\ttime = %1.4f\n\n',m,F_name,NMI,Q,time);
fclose(fw);
    
end