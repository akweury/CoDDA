clear;clc;close all;

addpath data_LiveJournal/

cmty = textread('lj.top5000.cmty.txt');
graph = importdata('lj.ungraph.txt');
column = 3;
while column < 500
    column = column+1;
    row_index = cmty(:,column) > 0;
    coms = cmty(row_index,:);
    [~,m] = size(coms);
end
row_index = [3,4,5,6, 7,8, 11, 12];
coms = coms(row_index,:);
node = unique(coms);

column = 2;
edgeall = graph.data;
edge = edgeall;
[n_edge,m_edge] = size(edge);
maxNode = max(node);
curEdge = 1;
myedge = zeros(6369,6369);
myedge(:,1) = node;
delta = 0;
cur_edge = 1;
for i = (n_edge/2 + 1):n_edge
    
	if i==1 
        myedge(cur_edge,2) = edge(i,2);
	end
    if myedge(cur_edge,1) > edge(i,1)
        continue;
    end
    

	if edge(i,1) == edge(i+1,1) 
        zero_pos = find(myedge(cur_edge,:)==0);
        if i>1 && edge(i,1) ~= edge(i-1,1)
           myedge(cur_edge,zero_pos(1)) = edge(i,2);
        end
       
       if cur_edge == 1
            myedge(cur_edge, zero_pos(2)) = edge(i+1,2);
       else
            myedge(cur_edge, zero_pos(1)) = edge(i+1,2);
       end

	else
        cur_edge = cur_edge + 1;
%         myedge(cur_edge,2)=edge(i+1,2);    
	end

    fprintf('%d\n',i);
    if i>100
        test1111 = 1;
    end
end






fprintf('saving...');
[n,~] = size(myedge);
fw = fopen('data_LiveJournal\LiveJournal.edge2.txt','w+');
for i = 1:n
    for j = 1:2
        fprintf(fw,'%7d',myedge(i,j));
    end
    fprintf(fw,'\n');
end
fclose(fw);

fprintf('save compete!');

