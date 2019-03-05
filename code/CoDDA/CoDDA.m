function [Fsame,NMI,Q,t] = CoDDA(maxIter,data,coordinate,realresult,k,T,d,theta,colorArray)


% -------��������----------------
data(data>0) = 1; % ������ݼ���ȷ������Ϊ0-1�ڽӾ���
S = theta(1,1); 
sigema = theta(1,2); % ˥������
beta = theta(1,3);
Lambda = theta(1,4); 
picNum = theta(1,5); % ��ʾͼ��ı��
[~,m] = size(data);


Fsame = zeros(maxIter,1);
NMI = zeros(maxIter,1);
Q = zeros(maxIter,1);
for i = 1:maxIter
    tic
    % ���ȼ����ԭ���ݵ����ƶȾ���X1
    X1 = sampleIMAGES(data,S,sigema);

    % �����ƶȾ������ò�ͬ���㷨���о���
    theta = [beta,Lambda,k,T,picNum,d];

    % CoDDA = CoDDA_new(X1,coordinate,realresult,colorArray,theta);
    CoDDA_reault = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta);
    t = toc;
    %% STEP 3: ��������֤

    % �������۱�׼��Fname �Ƕ������������ʵ�����Ľ���ͽ��Ƴ̶ȵĺ���ָ�꣬��Χ��[0,1],��ֵԽ��˵�����Խ׼ȷ
    % cls�ǽ��������realresult����ʵ������k�Ǿ�����Ŀ��Ŀǰ�ݶ���ʵ�����ͽ�������ľ�����Ŀ����k
    Fsame(i,1) = evaluationF_name(CoDDA_reault,realresult,k,k); 

    % �������۱�׼��NMI �ǹ�һ������Ϣ����Χ��[0,1]��ֵԽ��˵�����Խ׼ȷ
    % NMI = evaluationNMI(CoDDA,realresult,k,k);
    NMI(i,1) = nmi(CoDDA_reault,realresult);
    % �����������۱�׼��Qģ������ʹ����㷺�ĺ����������������۱�׼֮һ
    % CoDDA�Ǿ�������k�Ǿ�����������strike��ͼ���ڽӾ���
    % Q = modularity(CoDDA,k,data);
    modules = coms2modules(CoDDA_reault);
    Q(i,1) = modularity_metric(modules,data);
end

Fsame = sum(Fsame)/maxIter;
NMI = sum(NMI)/maxIter;
Q = sum(Q)/maxIter;
fprintf('\n(%d)CoDDA Result : F_name=%1.2f\tNMI=%1.2f\tQ=%1.2f\n',m,Fsame,NMI,Q);

% �����ļ�
filename = 'result\evaluation.xlsx';
[~, ~, row] = xlsread(filename);
[rowN, ~]=size(row);
sheet=1;
xlsRange=['A',num2str(rowN+1)];
xlswrite(filename,[m,maxIter,Fsame,NMI,Q,t,S,sigema,T,beta,Lambda],sheet,xlsRange);
xlsRange=['L',num2str(rowN+1)];
datetime_str = datestr(datetime,'yyyy-mm-dd HH:MM:SS');
xlswrite(filename,{datetime_str},sheet,xlsRange);
end