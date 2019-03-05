clear;clc;close all;

addpath data_LiveJournal/

fprintf('loading dataset to memory...');
cmty = textread('lj.top5000.cmty.txt');
graph = importdata('lj.ungraph.txt');
fprintf('compete!\n');

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
node(1,:) = [];

fprintf('save node to txt file...');
fw = fopen('data_LiveJournal\LiveJournal.node.txt','w+');
[n,~] = size(node);
node_pajek = (1:1:n)';
for i = 1:n
    fprintf(fw,'%8d\n',node_pajek(i,1));
end
fclose(fw);
fprintf('compelete!\n');


[n,~] = size(node);
mycoms = zeros(n,2);
mycoms(:,1) = node;


for i = 1:n
    [row,col] = find(coms==mycoms(i,1));
    mycoms(i,2) = row(1,1);
end
mycoms = mycoms(:,2);

fprintf('save communities to txt file...');
fw = fopen('data_LiveJournal\LiveJournal.coms.txt','w+');
[n,~] = size(mycoms);
for i = 1:n
    fprintf(fw,'%3d\n',mycoms(i,1));
end
fclose(fw);
fprintf('compelete!\n');


column = 2;
edgeall = graph.data;
edge = edgeall;
[n_edge,m_edge] = size(edge);
maxNode = max(node);
curEdge = 1;
hash_map = zeros(6368,6368);
hash_map(:,1) = node;
[n,m] = size(hash_map);


cur_edge = 1;
for i = 1:n_edge
    
	if i==1 
        hash_map(cur_edge,2) = edge(i,2);
        continue;
	end
    if hash_map(cur_edge,1) > edge(i,1)
        continue;
    end
    
    % not 1 line
	if edge(i-1,1) == edge(i,1) % old line
        zero_pos = find(hash_map(cur_edge,:)==0);
        if cur_edge == 1
            hash_map(cur_edge,zero_pos(2)) = edge(i,2);
        else
            hash_map(cur_edge,zero_pos(1)) = edge(i,2);
        end
            
    else
        if edge(i-1,1) ~= edge(i,1) % new line
            if edge(i,1) > hash_map(cur_edge,1)
                cur_edge = cur_edge + 1;
                if cur_edge > n % out of myedge range
                    break;
                end
            end
            if edge(i,1) == hash_map(cur_edge,1)
                zero_pos = find(hash_map(cur_edge,:)==0);
                hash_map(cur_edge,zero_pos(1)) = edge(i,2);
            end
        end
    end
    fprintf('%d/%d\n',i,n_edge);
    if i>100000
        test1111 = 1;
    end
end



i = m;
while sum(hash_map(:,i)) == 0
    i = i-1;
end

hash_map = hash_map(:,1:i); % delete lines which have no edge

zero_pos = find(hash_map(:,2)==0);
hash_map(zero_pos,:) = [];





fprintf('change hashmap to edges...');
[n,m] = size(hash_map);
myedge = [0,0];
for i = 1:n
    for j = 2:m
        if hash_map(i,j)==0
            break;
        end
        myedge = [myedge; hash_map(i,1),hash_map(i,j)];
    end
end
fprintf('complete!\n');


% [n,~] = size(myedge);

deletelines = 1;
for i=1:size(myedge)
    if isempty(find(node==myedge(i,2), 1))
        deletelines = [deletelines,i];
    end
end

deletelines(:,1) = [];
myedge(deletelines,:)=[];


fprintf('rename every node from 1-n...\n');
[n,~] = size(node);
for i = 1:n
    myedge(myedge==node(i,1))=i;
    if mod(n,1000)==0
        fprintf('%dnode renamed\n',floor(i/1000));
    end
end
fprintf('complete!\n');

unimyedge = unique(myedge);
uninode = unique(node_pajek);
error = setdiff(unimyedge,uninode);
    
[n,~] = size(myedge);
myedge_pajek = zeros(n,3);
myedge_pajek(:,1:2) = myedge;
myedge_pajek(:,3) = 1;



fprintf('save edges to txt file...');
fw = fopen('data_LiveJournal\LiveJournal.edges_pajek.txt','w+');
[n,m] = size(myedge_pajek);
for i = 1:n
    for j = 1:m
        fprintf(fw,'%8d',myedge_pajek(i,j));
    end
    fprintf(fw,'\n');
end
fclose(fw);
fprintf('compelete!\n');


