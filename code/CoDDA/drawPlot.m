function drawPlot(m,theta,CoDDA_array)

[n,~] = size(CoDDA_array);

figure(99)
x = 1:n; % x轴的范围
y1 = CoDDA_array(:,1); % Fsame
y2 = CoDDA_array(:,2); % NMI
y3 = CoDDA_array(:,3); % Q

x_smooth = linspace(min(x),max(x));
y_smooth = interp1(x,y1,x_smooth,'cublic');

subplot(3,1,1)
semilogy(x_smooth,y_smooth,'*-','Color',[0.161,0.482,0.071]);
legend('Fsame');
xlabel('times');
ylabel('Fsame');
set(get(gca,'Children'),'linewidth',1.0);
set(get(gca,'XLabel'),'FontSize',15);
set(get(gca,'YLabel'),'FontSize',15);

subplot(3,1,2)
semilogy(x_smooth,y_smooth,'v-','Color',[1.0,0.843,0.0]);
legend('NMI');
xlabel('times');
ylabel('NMI');
set(get(gca,'Children'),'linewidth',1.0);
set(get(gca,'XLabel'),'FontSize',15);
set(get(gca,'YLabel'),'FontSize',15);

subplot(3,1,3)
semilogy(x_smooth,y_smooth,'^-b','Color',[0.635,0.078,0.184]);
legend('Q');
xlabel('times');
ylabel('Q');
set(get(gca,'Children'),'linewidth',1.0);
set(get(gca,'XLabel'),'FontSize',15);
set(get(gca,'YLabel'),'FontSize',15);

filename = ['pic\',num2str(m),'-CoDDA聚类结果波动范围-',num2str(theta(1,1)),'-',num2str(theta(1,2)),...
    '-',num2str(theta(1,3)),'-',num2str(theta(1,4)),'-',num2str(theta(1,5)),...
    '-',datestr(datetime,'yyyy-mm-dd-HHMMSS'),'.tif'];


saveas(99,filename,'tif');


end