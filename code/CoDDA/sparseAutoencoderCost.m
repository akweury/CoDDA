function [cost, grad] = sparseAutoencoderCost(theta, visibleSize, hiddenSize, ...
                                             lambda, sparsityParam, beta, data)

% visibleSize: the number of input units (probably 64) 
% hiddenSize: the number of hidden units (probably 25) 
% lambda: weight decay parameter
% sparsityParam: The desired average activation for the hidden units (denoted in the lecture
%                           notes by the greek alphabet rho, which looks like a lower-case "p").
% beta: weight of sparsity penalty term
% data: Our 64x10000 matrix containing the training data.  So, data(:,i) is the i-th training example. 
  
% The input theta is a vector (because minFunc expects the parameters to be a vector). 
% We first convert theta to the (W1, W2, b1, b2) matrix/vector format, so that this 
% follows the notation convention of the lecture notes. 

W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
b1 = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2 = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);

% Cost and gradient variables (your code needs to compute these values). 
% Here, we initialize them to zeros. 
cost = 0;
W1grad = zeros(size(W1)); 
W2grad = zeros(size(W2));
b1grad = zeros(size(b1)); 
b2grad = zeros(size(b2));

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost/optimization objective J_sparse(W,b) for the Sparse Autoencoder,
%                and the corresponding gradients W1grad, W2grad, b1grad, b2grad.
%
% W1grad, W2grad, b1grad and b2grad should be computed using backpropagation.
% Note that W1grad has the same dimensions as W1, b1grad has the same dimensions
% as b1, etc.  Your code should set W1grad to be the partial derivative of J_sparse(W,b) with
% respect to W1.  I.e., W1grad(i,j) should be the partial derivative of J_sparse(W,b) 
% with respect to the input parameter W1(i,j).  Thus, W1grad should be equal to the term 
% [(1/m) \Delta W^{(1)} + \lambda W^{(1)}] in the last block of pseudo-code in Section 2.2 
% of the lecture notes (and similarly for W2grad, b1grad, b2grad).
% 
% Stated differently, if we were using batch gradient descent to optimize the parameters,
% the gradient descent update to W1 would be W1 := W1 - alpha * W1grad, and similarly for W2, b1, b2. 
% 
m = size(data,2);

% three terms of J_sparse 
Jcost = 0; 
Jweight = 0;
Jsparse = 0;

% z is the independent variable of function sigmoid 
% a is the dependent variable of function sigmoid

% calc total weighed sum of inputs in layer 2
z2 = W1 * data + repmat(b1, 1, m); clear b1;
% calc activation of outputs in layer 2
a2 = sigmoid(z2);

% calc total weighed sum of inputs in layer 3
z3 = W2 * a2 + repmat(b2, 1, m); clear b2;
% calc activation of outputs in layer 3
a3 = sigmoid(z3);

% calc the squared error term of data
% Jcost = (norm(a3-data,2))^2;
Jcostarray = zeros(m,1);
for i = 1:m
    Jcostarray(i,1) = sum((a3(:,i)-data(:,i)) .^2);
end
Jcostarray = sum(Jcostarray);

% error = Jcost-Jcostarray;

% Jcost = (0.5/m) * sum(sum((a3-data) .^2));

%calc the weight decay term of data
% Jweight = 0.5 * (sum(sum(W1 .^ 2)) + sum(sum(W2 .^2)));

% calc the sparsity penalty term fo data
rho = (1/m) .* sum(a2,2);
Jsparse = sum(sparsityParam .* log(sparsityParam ./ rho) + (1 - sparsityParam) .* log((1-sparsityParam) ./ (1-rho)));

% cost = Jcost + lambda * Jweight + beta * Jsparse;
cost = Jcostarray + beta * Jsparse;



% calc error term delta3, which is a 64*1 array 
z3diff = exp(-z3) ./ power((exp(-z3) + 1),2); clear z3;
delta3 = -(data - a3) .* z3diff; clear z3diff a3;

% calc error term delta2, which is a 25*1 array
z2diff = exp(-z2) ./ power((exp(-z2) + 1), 2); clear z2;
sterm = beta * (-sparsityParam ./ rho + (1-sparsityParam) ./(1-rho));clear rho;
delta2 = (W2' * delta3 + repmat(sterm,1,m)) .* z2diff; clear sterm z2diff;

% calc partial derivative of layer 2
W1grad = W1grad + delta2 * data'; clear data;
W1grad = (1/m) .* W1grad + lambda * W1; clear W1;
b1grad = b1grad + sum(delta2,2); clear delta2;
b1grad = (1/m) * b1grad;

% calc partial derivative of layer 3
W2grad = W2grad + delta3 * a2'; clear a2;
W2grad = (1/m) .* W2grad + lambda * W2;
clear W2;
b2grad = b2grad + sum(delta3,2); clear delta3;
b2grad = (1/m) * b2grad;

%-------------------------------------------------------------------
% After computing the cost and gradient, we will convert the gradients back
% to a vector format (suitable for minFunc).  Specifically, we will unroll
% your gradient matrices into a vector.

grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];
clear W1grad W2grad b1grad b2grad;
end

%-------------------------------------------------------------------
% Here's an implementation of the sigmoid function, which you may find useful
% in your computation of the costs and the gradients.  This inputs a (row or
% column) vector (say (z1, z2, z3)) and returns (f(z1), f(z2), f(z3)). 

function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end

