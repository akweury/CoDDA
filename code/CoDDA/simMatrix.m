function X = simMatrix(data,S,sigema)
% sampleIMAGES
% Returns strike for training

%% ����
% ����ͼ���ڽӾ��� A���������� k��������ֵS��˥������sigma�� ���ϡ���Զ��������Ĳ���T��ÿ��Ľڵ���d(����)

A = data; % �ڽӾ���


%% ���Ƚ��л����������ڽӾ���Ԥ����
tic
[~,m] = size(A);
hop = ones(m,m) * 1000; % ��ʼ����������(���󣩣�������������˵�֮��������������(������1000����)
Sim = zeros(m,m); % ���ƶȾ���
for x = 1:m % for each x in V
    status = zeros(m,1); % status�������ÿ���ڵ��״̬���ȳ�ʼ��Ϊδ����״̬
    queue = 0; % ��ʼ��queue
    status(x,1) = 1; % ��i���Ϊ������״̬
    hop(x,x) = 0; % ��ʼ��x������Ϊ0,����ֻ��ʼ�� x ���Լ�������Ϊ 0
    queue = [x queue]; % ��x�����queue
    while ~all(queue == 0)
        u = queue(1,1); % �Ӷ��� queue ��ȡ���ڵ�u
        queue([1])=[]; % �� queue �еĵ�һ��Ԫ�س���
%         for i=1:m % for each v in N(u)
%             if A(u,i) == 1 % for each v in N(u)
%                 v = i; % for each v in N(u)
%                 if hop(x,u) < S-1 && status(v,1)==0 % u �� x ��(S-1) ���� and v ,,����δ����״̬ S-1�ڰ���S-1��
%                     status(v,1) = 1; % ��v����Ϊ���ڷ���״̬
%                     % �� v �� x �� v ������д���������� D
%                     hop(v,v) = 0; % v �� v ������Ϊ 0 
%                     hop(x,v) = hop(x,u) + 1; % x �� v ���������� x �� u �������� 1 
%                     
%                     queue = [v queue]; % �� v ������� Queue
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
        status(u,1) = 2; % �� u ����Ϊ��������״̬
    end
%     hop(logical(eye(size(hop))))=0;
% 	for v = 1:m % for each v in V
%         if hop(x,v) < 1000 % ��� v �� D ��
%             Sim(x,v) = exp(sigema * (1 - hop(x,v)));
%         else
%             Sim(x,v) = 0;
%         end  
%     end
    Sim(hop<1000) = exp(sigema * (1-hop(hop<1000))); % calc Similarity matrix
    Sim(~(hop<1000)) = 0;
	fprintf('(%d/%d)sim���ƶȾ������\n',x,m)
end
X = Sim; % �õ��������������ƶȾ��� X����ʱ�Խ����ϵ�Ԫ�ؽ�����Ϊ�� 
% X(logical(eye(size(X))))=0;
% �����ԭ����Ĳ��
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


 