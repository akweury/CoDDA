clear;
load football.txt
football_adjacency = zeros(180);
[n m] = size(football);
for i = 1:n
    football_adjacency(football(i,1),football(i,2)) = 1;
end
fw = fopen('football_adjacency.txt','w+');

for i = 1:180
    for j = 1:180
        fprintf(fw,'%2d',football_adjacency(i,j));
    end
    fprintf(fw,'\n');
end

fclose(fw);



