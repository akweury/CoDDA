function F_name = evaluationF_name(cls,realresult,k,t)


n = size(cls,1);
maxi = 0;
maxj=0;
singleCommunity = cls; % �������
singleCommunityReal = realresult; % ��ʵ����
for c = 1:k
    max = 0;    % �����ж�ÿ�������������ʵ����֮������ƥ���
    for c_real = 1:k
        singleCommunityReal = realresult;
        singleCommunityReal(singleCommunityReal ~= c_real) = 0; % ���Ƕ�Ӧ��Ԫ������
        singleCommunityReal(singleCommunityReal == c_real) = c; % ����Ӧ��Ԫ���ã�
        isZero = (singleCommunity - singleCommunityReal) == 0; % ��ȡ���غϵ�Ԫ��
        numOfZero = sum(isZero(:)); % ͳ���غ�Ԫ�ظ���
        if max < numOfZero
            max = numOfZero; % ѡȡ����ϵļ���
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