function CoDDA = CoDDA_new(X1,coordinate,realresult, colorArray, theta)


data = X1;
function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end

%% 初始化参数
alpha = theta(1,1);
k = theta(1,3);
T = theta(1,4);
d = theta(1,6:end);
visibleSize = d(1,1);   % number of input units 
hiddenSize = d(1,2);     % number of hidden units 3
lr = 0.1; % 学习速率
rho = 0.01;
m = size(X1,2);
theta = initializeParameters(hiddenSize, visibleSize); 

% W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
% W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
% p = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
% q = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);
clear theta;

% W1grad = zeros(size(W1)); 
% W2grad = zeros(size(W2));
% b1grad = zeros(size(p)); 
% b2grad = zeros(size(q));
% 
% h_in = zeros(hiddenSize,visibleSize);
% h_out = zeros(hiddenSize,visibleSize);
% x_in = zeros(visibleSize,visibleSize);
% x_out = zeros(visibleSize,visibleSize);

for layer = 2:T
% 	Ltheta = 9999;
% 	while 1
% 		lastLtheta = Ltheta;
% 		
% 		
% % 		diff1_2 = zeros(visibleSize,1);
% %         diff2_2 = zeros(visibleSize,1);
% %         diff3_2 = zeros(visibleSize,1);
%         
%         for i = 1:visibleSize
% %             diff1_2(i,1) = sum(2 * (x_out(i,:) - X1(i,:)));
% %             diff2_2(i,1) = (exp(-x_in(i,:)) / ( power((1+exp(-x_in(i,:))),2)));
%             for j = 1:hiddenSize
% % 				diff3_2 = h_out(j,i);
% %                 ddW2 = -(2*exp(- q - W2/(exp(- p - W1*x) + 1))*(x - 1/(exp(- q - W2/(exp(- p - W1*x) + 1)) + 1)))/((exp(- p - W1*x) + 1)*(exp(- q - W2/(exp(- p - W1*x) + 1)) + 1)^2);
% %                 ddq = -(2*exp(- q - W2/(exp(- p - W1*x) + 1))*(x - 1/(exp(- q - W2/(exp(- p - W1*x) + 1)) + 1)))/(exp(- q - W2/(exp(- p - W1*x) + 1)) + 1)^2;
%                 
%                 W2grad(i,j) = -(2*exp(- q(i,1) - W2(i,j)/(exp(- p(j,1)...
%                     - W1(j,i)*X1) + 1))*(X1...
%                     - 1/(exp(- q(i,1) - W2(i,j)/(exp(- p(j,1) - W1(j,i)*X1) + 1))...
%                     + 1)))/((exp(- p(j,1) - W1(j,i)*X1) + 1)*(exp(- q(i,1)...
%                     - W2(i,j)/(exp(- p(j,1) - W1(j,i)*X1) + 1)) + 1)^2);
%                 
%                 b2grad(i,1) = -(2*exp(- q(i,1) - W2(i,j)/(exp(- p(j,1) - W1(j,i)*X1)...
%                     + 1))*(X1 - 1/(exp(- q(i,1) - W2(i,j)/(exp(- p(j,1) - W1(j,i)*X1)...
%                     + 1)) + 1)))/(exp(- q(i,1) - W2(i,j)/(exp(- p(j,1) - W1(j,i)*X1) + 1)) + 1)^2;
% % 				W2grad(i,j) = diff1_2(i,1)*diff2_2(i,1)*diff3_2;
%             end
% % 			b2grad(i,1) = diff1_2(i,1)*diff2_2(i,1);
%         end
%         
% % 		diff2_1 = zeros(hiddenSize,1);
% %         diff1_1 = 0;
%         for i = 1:hiddenSize
% %             diff2_1(i,1) = exp(-h_in(i,:))/( power((1+exp(-h_in(i,:))),2));
%             for j = 1: visibleSize
% %                 for v = 1:visibleSize
% %                     diff1_1 = diff1_1 * diff1_2(v,1) * diff2_2(v,1) * W2(v,i);
% %                 end
% % 				diff3_1 = X1(i,j);
%                 
% %                 fomular = power((1/( 1+( exp(-( W2*( 1/( 1+( exp( -(W1*x+p))))) + q)))))-x,2);
% %                 fomular = alpha * (rho * log(rho / (1/1+exp(-(W*data+p)))) + (1-p) * log((1-p) / (1-(W*data+p))));
% %                 fomular = -alpha*(log((p - 1)/(p + W*data - 1))*(p - 1) - rho*log(rho/(exp(- p - W*data) + 1)));
% %                 ddW = alpha*((data*(p - 1))/(p + W*data - 1) + (data*rho*exp(- p - W*data))/(exp(- p - W*data) + 1));
% %                 ddp = -alpha*(log((p - 1)/(p + W*data - 1)) + (1/(p + W*data - 1) - ...
% %                     (p - 1)/(p + W*data - 1)^2)*(p + W*data - 1) - (rho*exp(- p - W*data))/(exp(- p - W*data) + 1));
%                 
% 
% 
%                 ddW1_1 = -(2*W2(j,i)*X1(i,j)*exp(- p(i,1) - W1(i,j)*X1)*exp(- q(j,1) - W2(j,i)/(exp(- p(i,1) - ...
%                     W1(i,j)*X1) + 1))*(X1 - 1/(exp(- q(j,1) - W2(j,i)/(exp(- p(i,1) - W1(i,j)*X1) + 1))...
%                     + 1)))/((exp(- p(i,1) - W1(i,j)*X1) + 1)^2*(exp(- q(j,1) - W2(j,i)/(exp(- p(i,1) - W1(i,j)*X1) + 1)) + 1)^2);
%          
%                 ddW1_2 = alpha*((X1*(p(i,1) - 1))/(p(i,1) + W1(i,j)*X1 - 1) + ...
%                     (X1*rho*exp(- p(i,1) - W1(i,j)*X1))/(exp(- p(i,1) - W1(i,j)*X1) + 1));
%                 
%                 ddp_1 = -(2*W2(j,i)*exp(- p(i,1) - W1(i,j)*X1)*exp(- q(j,1) - W2(j,i)/(exp(- p(i,1) - W1(i,j)*X1)...
%                     + 1))*(X1 - 1/(exp(- q(j,1) - W2(j,i)/(exp(- p(i,1) - W1(i,j)*X1) + 1)) + 1)))/((exp(- p(i,1)...
%                     - W1(i,j)*X1) + 1)^2*(exp(- q(j,1) - W2(j,i)/(exp(- p(i,1) - W1(i,j)*X1) + 1)) + 1)^2);
%                 
%                 ddp_2 = -alpha*(log((p(i,1) - 1)/(p(i,1) + W1(i,j)*X1 - 1)) + (1/(p(i,1) + W1(i,j)*X1 - 1) - ...
%                     (p(i,1) - 1)/(p(i,1) + W1(i,j)*X1 - 1)^2)*(p(i,1) + W1(i,j)*X1 - 1) - ...
%                     (rho*exp(- p(i,1) - W1(i,j)*X1))/(exp(- p(i,1) - W1(i,j)*X1) + 1));
%                 
% % 				W1grad(i,j) = diff1_1*diff2_1(i,1)*diff3_1 + ddW;
%                 W1grad(i,j) = ddW1_1+ddW1_2;
%             end
% %             p(i,1) = diff1_1*diff2_1(i,1) + ddp;
%             p(i,1) = ddp_1 + ddp_2;
%         end
%         
% 		% 更新权重
% 		W1 = W1 - lr * W1grad;
% 		W2 = W2 - lr * W2grad;
% 		p = p - lr * b1grad;
% 		q = q - lr * b2grad;
% 		
% 
% 		
% 		re = zeros(visibleSize,1); % Reconstruction error
% 		% rhoj = zeros(visibleSize,1);
% 		
% 
% 		for i = 1:visibleSize
% 			h_in(:,i) = W1 * data(:,i) + p;
% 			h_out(:,i) = sigmoid(h_in(:,i));
% 			x_in(:,i) = W2 * h_out(:,i) + q;
% 			x_out(:,i) = sigmoid(x_in(:,i));
% 			re(i,1) = sum(norm((x_out(:,i) - data(:,i)),2) ^ 2);
% 		   
% 		end
% 		rhoj = sum(h_out,2)/visibleSize;
% 		re = sum(re);
% 		KL = rho * log(rho ./ rhoj) + (1-rho) * log((1-rho) ./ (1-rhoj));
% 		 
% 		KL = alpha * sum(KL);
% 
% 
% 		Ltheta = re + KL;
%         if lastLtheta-Ltheta < 0
%             W1 = W1 + lr * W1grad;
%             W2 = W2 + lr * W2grad;
%             p = p + lr * b1grad;
%             q = q + lr * b2grad;
%             break;
%         end
% % 		fprintf('%5.5f\n',Ltheta);
% 	
% 	end

    
    % net = newff(X1,X1,d(1,j),{'tansig', 'purelin'},'trainrp');
    % net.trainParam.epochs = 1000;
    % net.trainParam.lr = 0.1;
    % net.trainParam.goal = 0.0001;
    % net = train(net,X1,X1);
    
    % W1 = net.iW{1};
    % W2 = net.LW{2,1};
    % p = net.b{1,1};
    % q = net.b{2,1};
	

    autoenc = trainAutoencoder(X1,d(1,layer),...
        'MaxEpochs', 1000,...
        'EncoderTransferFunction','logsig',...
        'DecoderTransferFunction','logsig',...
        'L2WeightRegularization',0,...
        'SparsityRegularization',alpha,...
        'SparsityProportion',0.010);
    W1 = autoenc.EncoderWeights;
    p = autoenc.EncoderBiases;
    Xt = calcEncoderResult(W1,X1,p);
    X1 = Xt;
    
end
picNum = 7;
CoDDA = k_means(Xt,k,coordinate,realresult,picNum,colorArray);            % cls 为 CoDDA 算法聚类结果

end
