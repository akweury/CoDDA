function CoDDA = CoDDAAlgo(X1,coordinate,realresult,colorArray,theta)

%% 初始化参数


beta = theta(1,1); % weight of sparsity penalty term
k = theta(1,2);
T = theta(1,3);
picNum = theta(1,4);
d = theta(1,5:end);


visibleSize = d(1,1);   % number of input units 
hiddenSize = d(1,2);     % number of hidden units 3
sparsityParam = 0.01;   % desired average activation of the hidden units.
                     % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
                    %  in the lecture notes). 
lambda = 0.0001;     % weight decay parameter       
    


%%======================================================================
%% STEP 1:  Obtain random parameters theta

theta = initializeParameters(hiddenSize, visibleSize); 

%%======================================================================
%% STEP 2: Implement sparseAutoencoderCost



[cost, grad] = sparseAutoencoderCost(theta, visibleSize, hiddenSize, lambda, ...
                                     sparsityParam, beta, X1);
                                 
%%======================================================================
%% STEP 3: Gradient Checking
%
% Hint: If you are debugging your code, performing gradient checking on smaller models 
% and smaller training sets (e.g., using only 10 training examples and 1-2 hidden 
% units) may speed things up.

% First, lets make sure your numerical gradient computation is correct for a
% simple function.  After you have implemented computeNumericalGradient.m,
% run the following: 
% checkNumericalGradient();
% Now we can use it to check your cost function and derivative calculations
% for the sparse autoencoder.  

% numgrad = computeNumericalGradient( @(x) sparseAutoencoderCost(x, visibleSize, ...
%                                                   hiddenSize, lambda, ...
%                                                   sparsityParam, beta, ...
%                                                   X1), theta);


% Use this to visually compare the gradients side by side
% disp([numgrad grad]); 

% Compare numerically computed gradients with the ones obtained from backpropagation
% diff = norm(numgrad-grad)/norm(numgrad+grad);
% disp(diff); % Should be small. In our implementation, these values are
            % usually less than 1e-9.

            % When you got this working, Congratulations!!! 

%%======================================================================
%% STEP 4: After verifying that your implementation of
%  sparseAutoencoderCost is correct, You can start training your sparse
%  autoencoder with minFunc (L-BFGS).

% 基于上面已完成的稀疏自动编码器，完成下面的深度稀疏自动编码器，
% 相当于将稀疏自动编码器循环T-1次，每次的隐藏层神经元个数为d(1，i-1)个
if T==1
    Xt = X1;
end
for i=2:T
    hiddenSize = d(1,i); 
    visibleSize = d(1,i-1);
    %  Randomly initialize the parameters
    theta = initializeParameters(hiddenSize, visibleSize);
    %  Use minFunc to minimize the function
    addpath minFunc/
    options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                              % function. Generally, for minFunc to work, you
                              % need a function pointer with two outputs: the
                              % function value and the gradient. In our problem,
                              % sparseAutoencoderCost.m satisfies this.
    options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
    options.display = 'off';
    
    
    [opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, X1), ...
                              theta, options);

    %%======================================================================
    %% STEP 5: Visualization 

    W1 = reshape(opttheta(1:hiddenSize*visibleSize), hiddenSize, visibleSize); % 至此，权重矩阵W1计算完毕
    b1 = reshape(opttheta(2*hiddenSize*visibleSize+1 : 2*hiddenSize*visibleSize+hiddenSize),hiddenSize,1);
    % display_network(W1', 12);
    
    Xt = calcEncoderResult(W1,X1,b1); % 将权重矩阵带入编码器，计算低维特征矩阵
    X1 = Xt;
end

%% k-means 聚类

CoDDA = k_means(Xt,k,coordinate,realresult,picNum,colorArray);            % cls 为 CoDDA 算法聚类结果

end