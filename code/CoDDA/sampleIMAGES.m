function X = sampleIMAGES(data,S,sigema)
% sampleIMAGES
% Returns strike for training

%% ����
% ����ͼ���ڽӾ��� A���������� k��������ֵS��˥������sigma�� ���ϡ���Զ��������Ĳ���T��ÿ��Ľڵ���d(����)

A = data; % �ڽӾ���

fprintf(datestr(datetime,'yyyy-mm-dd HH:MM:SS'));

%% ���Ƚ��л����������ڽӾ���Ԥ����
tic
[n,m] = size(A);
hop = ones(m,m) * 1000; % ��ʼ����������(���󣩣�������������˵�֮��������������(������1000����)
Sim = zeros(m,m); % ���ƶȾ���
for x = 1:m % for each x in V
    status = zeros(m,1); % status�������ÿ���ڵ��״̬���ȳ�ʼ��Ϊδ����״̬
    queue = 0; % ��ʼ��queue
%     D = zeros(n,m); % ��ʼ����������
    hop = ones(m,m) * 1000; % ��ʼ����������(���󣩣�������������˵�֮��������������(������1000����)
    status(x,1) = 1; % ��i���Ϊ������״̬
    hop(x,x) = 0; % ��ʼ��x������Ϊ0,����ֻ��ʼ�� x ���Լ�������Ϊ 0
%     D(x,x) = 0; % �� x ������ 0 д���������� D
    queue = [x queue]; % ��x�����queue
    
    while ~all(queue == 0)
        u = queue(1,1); % �Ӷ��� queue ��ȡ���ڵ�u
        queue([1])=[]; % �� queue �еĵ�һ��Ԫ�س���
        for i=1:m % for each v in N(u)
            if A(u,i) == 1 % for each v in N(u)
                v = i; % for each v in N(u)
                if hop(x,u) < S-1 && status(v,1)==0 % u �� x ��(S-1) ���� and v ,,����δ����״̬ S-1�ڰ���S-1��
                    status(v,1) = 1; % ��v����Ϊ���ڷ���״̬
                    % �� v �� x �� v ������д���������� D
                    hop(v,v) = 0; % v �� v ������Ϊ 0 
                    hop(x,v) = hop(x,u) + 1; % x �� v ���������� x �� u �������� 1 
                    
                    queue = [v queue]; % �� v ������� Queue
                end 
            end
        end

        status(u,1) = 2; % �� u ����Ϊ��������״̬
    end
%     hop(logical(eye(size(hop))))=0;
	for v = 1:m % for each v in V
        if hop(x,v) < 1000 % ��� v �� D ��
            Sim(x,v) = exp(sigema * (1 - hop(x,v)));
        else
            Sim(x,v) = 0;
        end  
	end
%       fprintf('(%d/%d)���ƶȾ������\n',x,m)
end
X = Sim; % �õ��������������ƶȾ��� X����ʱ�Խ����ϵ�Ԫ�ؽ�����Ϊ�� 
% X(logical(eye(size(X))))=0;
% �����ԭ����Ĳ��
% X(X>0 & X<1) = 1;
% A-X;
t = toc;
fprintf(' %d sampleImages time = %5.5f\t',m,t);


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


