load community.txt

n = size(community,1);

football_community = zeros(180,1);
current_community = 0;


for i = 1:n
    if community(i,1)==11111
        current_community = current_community + 1;
        continue;
    end
    football_community(community(i,1),1) = current_community;
end

fw = fopen('football_community.txt','w+');
fprintf(fw,'%8d\n',football_community);
fclose(fw);




% fw = fopen('football_arc.txt','w+');
% 
% for j = 1:788
%     for i = 1:3
%         fprintf(fw,'%5d',football(j,i));
%     end
%     fprintf(fw,'\n');
% end
% 
% fclose(fw);

% % зјБъ
% fw = fopen('football_coordinate.txt','w+');
% 
% for j = 1:180
%     for i = 1:3
%         fprintf(fw,'%1.4f',test(j,i));
%         fprintf(fw,'    ');
%     end
%     fprintf(fw,'\n');
% end
% 
% fclose(fw);

% зјБъ
fw = fopen('yeast_coordinate2.txt','w+');

for j = 1:2361
    for i = 1:3
        fprintf(fw,'%1.4f',yeast_coordinate(j,i));
        fprintf(fw,'    ');
    end
    fprintf(fw,'\n');
end

fclose(fw);



