function X = simMatrix(data,S,sigema)
% sampleIMAGES
% Returns strike for training

%% 输入
% 网络图的邻接矩阵 A，社区个数 k，跳数阈值S，衰减因子sigma， 深度稀疏自动编码器的层数T，每层的节点数d(向量)

A = data; % 邻接矩阵


%% 首先进行基于跳数的邻接矩阵预处理
tic
[~,m] = size(A);
hop = ones(m,m) * 1000; % 初始化跳数集合(矩阵），起初任意两个端点之间的跳数是无穷大(这里用1000代替)
Sim = zeros(m,m); % 相似度矩阵
for x = 1:m % for each x in V
    status = zeros(m,1); % status用来存放每个节点的状态，先初始化为未访问状态
    queue = 0; % 初始化queue
    status(x,1) = 1; % 将i标记为访问中状态
    hop(x,x) = 0; % 初始化x的跳数为0,这里只初始化 x 到自己的跳数为 0
    queue = [x queue]; % 将x入队列queue
    while ~all(queue == 0)
        u = queue(1,1); % 从队列 queue 中取出节点u
        queue([1])=[]; % 将 queue 中的第一个元素出队
%         for i=1:m % for each v in N(u)
%             if A(u,i) == 1 % for each v in N(u)
%                 v = i; % for each v in N(u)
%                 if hop(x,u) < S-1 && status(v,1)==0 % u 在 x 的(S-1) 跳内 and v ,,处于未访问状态 S-1内包括S-1吗
%                     status(v,1) = 1; % 将v设置为正在访问状态
%                     % 将 v 及 x 到 v 的跳数写进跳数集合 D
%                     hop(v,v) = 0; % v 到 v 的跳数为 0 
%                     hop(x,v) = hop(x,u) + 1; % x 到 v 的跳数等于 x 到 u 的跳数加 1 
%                     
%                     queue = [v queue]; % 将 v 加入队列 Queue
%                 end 
%             end
%         end

        v = zeros(m,1);
        v(A(u,:)==1) = 1;
        if hop(x,u) < S-1
            v(status>0) = 0;
            status(v==1) = 1;
            hop = hop-diag(diag(hop));
            hop(x,status==1) = hop(x,u) + 1;
            v = find(v>0);
            queue = [v' queue];
            queue(queue==0)=[];
        end
        status(u,1) = 2; % 将 u 设置为结束访问状态
    end
%     hop(logical(eye(size(hop))))=0;
% 	for v = 1:m % for each v in V
%         if hop(x,v) < 1000 % 如果 v 在 D 内
%             Sim(x,v) = exp(sigema * (1 - hop(x,v)));
%         else
%             Sim(x,v) = 0;
%         end  
%     end
    Sim(hop<1000) = exp(sigema * (1-hop(hop<1000))); % calc Similarity matrix
    Sim(~(hop<1000)) = 0;
	fprintf('(%d/%d)sim相似度矩阵计算\n',x,m)
end
X = Sim; % 得到基于跳数的相似度矩阵 X，此时对角线上的元素将不再为０ 
% X(logical(eye(size(X))))=0;
% 检测与原矩阵的差别
% X(X>0 & X<1) = 1;
% A-X;
t = toc;
fprintf('simMatrix time = %5.5f\n',t);
% filename = ['sim_adj\',num2str(m),'-',num2str(S),'-sigema-',num2str(sigema),'-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.txt'];
% fprintf('save similarity adj to txt file...');
% fw = fopen(filename,'w+');
% [n,m] = size(X);
% for i = 1:n
%     for j = 1:m
%         fprintf(fw,'%2.15f',X(i,j));
%     end
%     fprintf(fw,'\n');
% end
% fclose(fw);
% fprintf('compelete!\n');


end


 