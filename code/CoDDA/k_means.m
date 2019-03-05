function cls = k_means( Xt,k,coordinate,realresult,picNum,colorArray )
%K_MEANS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

Xt = Xt';
cls = kmeans(Xt,k); % ��ȡ����������

isplot = 0;

if isplot == 1
	%% ��������ʾ
	figure(picNum)
	clf;
	subplot(1,2,2)
	hold on
	for i = 1:k
		plot( coordinate(cls==i,1), coordinate(cls==i,2),'.','Color',colorArray(i,:))
	end
	hold off
	title('������')


	subplot(1,2,1)
	hold on
	for i = 1:k
		plot( coordinate(realresult==i,1), coordinate(realresult==i,2),'.','Color',colorArray(i,:))
	end
	hold off
	title('��ʵ���');
end

% ��ʵ����д���ļ� cls.txt

fw = fopen('cls.txt','w+');
fprintf(fw,'%8d\n',cls);
fclose(fw);

end
