function x_hat=StOMP(y,A,s,parameters)
%% STagewise Orthogonal Matching Pursuit algorithm for sparse recovery from
%% incomplete measurements y = Ax + e such that the ground truth data vector x
%% is s-sparse.
%% See Donoho et al. 2012.
%%
%% Inputs:
%% y: m-dimensional complex measurement vector
%% A: m x N-dimensional complexmeasurement matrix
%% s: sparsity of the data vector x
%% parameters: additional parameters:
%%                {1}: epsilon: error threshold: stop iterations if below
%%                {2}: maxiters: stop iterations if #iterions above
%%                {3}: threshold parameter t \in \[2,3\]. A lower value promotes
%%                      a larger number of selected entries per iteration.
%%
%% Output:
%% x_hat: N-dimensional estimate of the sparse underlying datavector x with
%%          guaranteed sparsity $\|x_hat\|_0 \leq s$

S = [];
n = 0;
[m,N] = size(A);
x_hat = zeros(N,1);
res = y;
err = norm(y);

epsilon = parameters{1};
maxiters = parameters{2};
t = parameters{3};

while err > epsilon && n<maxiters
    n=n+1;

% find columns with maximum correlation
c = abs(A'*(res));

sigma = err / sqrt(m);
S = [S,find(c>t*sigma)'];

% Perform Least Squares
x_hat(S) = A(:,S)\y;

% Compute error
res = y-A*x_hat;
err = norm(res);

end
[~,ind]=sort(abs(x_hat),'descend');
x_hat(setdiff(1:N,ind(1:s))) = 0;
