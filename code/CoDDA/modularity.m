function Q = modularity(CoDDA,k,strike)

in = zeros(k,1); % 每个社区的内部边的数量
out = zeros(k,1); % 每个社区的外部边的数量
vertices = size(CoDDA,1); % 图的节点个数
for i = 1:k
    community_i = CoDDA;
    community_i(community_i ~= i) = 0; % 属于社区i的若干节点
    is_community_i = community_i;
    is_community_i(is_community_i == i)=1;% 社区i的存在向量
    for j = 1:vertices
        if is_community_i(j,1) % 如果第 j 个节点属于社区 i
            for m = j:vertices % 找第 j 个节点的邻边
                if is_community_i(m,1) == 1 % 如果第 m 个节点属于社区 i
                    in(i,1) = in(i,1) + strike(j, m); % 第 j 个节点的社区内部邻边数
                end
            end
            for m = 1:vertices 
                if is_community_i(m,1) ~= 1 % 如果第 m 个节点不属于社区 i
                    out(i,1) = out(i,1) + strike(j,m); % 第j个节点的社区外部邻边数
                end
            end
        end
    end
end

edges = sum(in) + sum(out)/2;% 边的总数

Q = 0;
for i = 1:k
    Q = Q + (in(i,1)/edges - ((2 * in(i,1) + out(i,1)) / (2 * edges)) ^2);
end



end