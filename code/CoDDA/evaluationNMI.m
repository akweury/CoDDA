function NMI = evaluationNMI(cls,realresult,k,t)

% ��������confusion matrix��N��ÿ��Ԫ��Nij�����˵�i������������j����ʵ�����Ľ��� 
% �������������ȫ�غϣ�������һ�����������ݼ��ڵ������
N = zeros(k,t);
c = cls; % �������

for i = 1:k
    for j = 1:t
        r = realresult;
        r(r~=j)=0;
        r(r==j)=i;
        isZero = (c - r) == 0;
        numOfZero = sum(isZero(:));
        N(i,j) = numOfZero;
    end
end

% Nt
Nt = sum(sum(N)); % ���� N ���ܺ�

numerator = 0; % NMI��ʽ�ķ���
denominator = 0; % NMI��ʽ�ķ�ĸ

for i = 1:k
    for j = 1:t
        if N(i,j)==0
            continue;
        end
        numerator = numerator + N(i,j) * log( (N(i,j) * Nt) / (sum(N(i,:)) * sum(N(:,j))));
    end
end
numerator = numerator * (-2);

for i = 1:k
    denominator = denominator + sum(N(i,:)) * log(sum(N(i,:)) / Nt);
end
for j = 1:t
	denominator = denominator + sum(N(:,j)) * log(sum(N(:,j))/Nt);
end

NMI = numerator/denominator;

end