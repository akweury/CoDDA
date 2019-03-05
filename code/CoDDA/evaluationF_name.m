function F_name = evaluationF_name(cls,realresult,k,t)


n = size(cls,1);
maxi = 0;
maxj=0;
singleCommunity = cls; % 结果社区
singleCommunityReal = realresult; % 真实社区
for c = 1:k
    max = 0;    % 用来判断每个结果社区与真实社区之间最大的匹配度
    for c_real = 1:k
        singleCommunityReal = realresult;
        singleCommunityReal(singleCommunityReal ~= c_real) = 0; % 将非对应的元素置零
        singleCommunityReal(singleCommunityReal == c_real) = c; % 将对应的元素置ｃ
        isZero = (singleCommunity - singleCommunityReal) == 0; % 提取出重合的元素
        numOfZero = sum(isZero(:)); % 统计重合元素个数
        if max < numOfZero
            max = numOfZero; % 选取最符合的集合
        end
    end
    maxj = maxj + max;
end


singleCommunityReal = realresult;
for c_real = 1:t
    max = 0;
    for c = 1:t
        singleCommunity = cls;
        singleCommunity(singleCommunity ~= c) = 0;
        singleCommunity(singleCommunity == c) = c_real;
        isZero = (singleCommunityReal - singleCommunity) == 0;
        numOfZero = sum(isZero(:));
        if max < numOfZero
            max = numOfZero;
        end
    end
    maxi = maxi + max;
end

F_name = (maxj + maxi)/ (2*n);





end