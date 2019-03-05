clear;clc;close all;

figure(1)
sparsityParam = 0.3;
rho = linspace(0,1);
KL = sparsityParam .* log(sparsityParam ./ rho) + (1 - sparsityParam) .* log((1-sparsityParam) ./ (1-rho));


plot(rho,KL);
title('KL-divergence function');
text
ylabel('KL散度值');
xlabel('隐藏层平均激活值');
set(get(gca,'Children'),'linewidth',1.0);
set(get(gca,'XLabel'),'FontSize',15);
set(get(gca,'YLabel'),'FontSize',15);
set(get(gca,'title'),'FontSize',15);
strings={'ρ=',sparsityParam};
