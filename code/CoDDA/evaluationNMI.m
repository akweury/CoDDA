function NMI = evaluationNMI(cls,realresult,k,t)

% 混淆矩阵（confusion matrix）N，每个元素Nij代表了第i个结果社区与第j个真实社区的交集 
% 如果两个社区完全重合，则矩阵的一范数就是数据集节点的数量
N = zeros(k,t);
c = cls; % 结果社区

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
Nt = sum(sum(N)); % 矩阵 N 的总和

numerator = 0; % NMI公式的分子
denominator = 0; % NMI公式的分母

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