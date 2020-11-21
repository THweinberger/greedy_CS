function x_hat=gOMP(y,A,s,parameters)
%% Generalized Orthogonal Matching Pursuit algorithm for sparse recovery from
%% incomplete noisy measurements y = Ax + e such that the ground truth data
%% vector x is s-sparse.
%% See Wang, Kwon and Shim 2012.
%%
%% Inputs:
%% y: measurement vector
%% A: measurement matrix
%% s: sparsity of the data vector
%% parameters: additional parameters:
%%                {1}: epsilon: error threshold: stop iterations if below
%%                {2}: maxiters: stop iterations if #iterions above
%%                {3}: hyperparameter K determines the number of newly added
%%                      entries per iteration
%% Note: for good theoretical guarantees, set K <= \min{s,m/s} (see Wang 2011)
%%
%% Output:
%% x_hat: estimate of the sparse underlying datavector x with guaranteed
%%          sparsity $\|x_hat\|_0 \leq s$

err = inf;
S = [];
n = 0;
[m,N] = size(A);
x_hat = zeros(N,1);
res = y;

epsilon = parameters{1};
maxiters = parameters{2};

K = parameters{3};

%K = min(s,round(m/s));

while err > epsilon && n<maxiters
    n=n+1;

% find columns with maximum correlation
    [~,ind]=sort(abs(A'*res),'descend');

S = [S,ind(1:K)'];

% Perform Least Squares
x_hat(S) = A(:,S)\y;

% Compute error
res = y-A*x_hat;
err = norm(res);

end
[~,ind]=sort(abs(x_hat),'descend');
x_hat(setdiff(1:N,ind(1:s))) = 0;
