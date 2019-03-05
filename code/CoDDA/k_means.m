function cls = k_means( Xt,k,coordinate,realresult,picNum,colorArray )
%K_MEANS 此处显示有关此函数的摘要
%   此处显示详细说明

Xt = Xt';
cls = kmeans(Xt,k); % 获取聚类结果向量

isplot = 0;

if isplot == 1
	%% 聚类结果显示
	figure(picNum)
	clf;
	subplot(1,2,2)
	hold on
	for i = 1:k
		plot( coordinate(cls==i,1), coordinate(cls==i,2),'.','Color',colorArray(i,:))
	end
	hold off
	title('聚类结果')


	subplot(1,2,1)
	hold on
	for i = 1:k
		plot( coordinate(realresult==i,1), coordinate(realresult==i,2),'.','Color',colorArray(i,:))
	end
	hold off
	title('真实结果');
end

% 将实验结果写入文件 cls.txt

fw = fopen('cls.txt','w+');
fprintf(fw,'%8d\n',cls);
fclose(fw);

end
