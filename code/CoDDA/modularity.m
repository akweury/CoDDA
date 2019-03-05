function Q = modularity(CoDDA,k,strike)

in = zeros(k,1); % ÿ���������ڲ��ߵ�����
out = zeros(k,1); % ÿ���������ⲿ�ߵ�����
vertices = size(CoDDA,1); % ͼ�Ľڵ����
for i = 1:k
    community_i = CoDDA;
    community_i(community_i ~= i) = 0; % ��������i�����ɽڵ�
    is_community_i = community_i;
    is_community_i(is_community_i == i)=1;% ����i�Ĵ�������
    for j = 1:vertices
        if is_community_i(j,1) % ����� j ���ڵ��������� i
            for m = j:vertices % �ҵ� j ���ڵ���ڱ�
                if is_community_i(m,1) == 1 % ����� m ���ڵ��������� i
                    in(i,1) = in(i,1) + strike(j, m); % �� j ���ڵ�������ڲ��ڱ���
                end
            end
            for m = 1:vertices 
                if is_community_i(m,1) ~= 1 % ����� m ���ڵ㲻�������� i
                    out(i,1) = out(i,1) + strike(j,m); % ��j���ڵ�������ⲿ�ڱ���
                end
            end
        end
    end
end

edges = sum(in) + sum(out)/2;% �ߵ�����

Q = 0;
for i = 1:k
    Q = Q + (in(i,1)/edges - ((2 * in(i,1) + out(i,1)) / (2 * edges)) ^2);
end



end