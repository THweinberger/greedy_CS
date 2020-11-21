function x_hat=NIHT(y,A,s,parameters)
%% Normalized Iterative Hard Thresholding algorithm for sparse recovery from
%% incomplete noisy measurements y = Ax + e such that the ground truth data
%% vector x is s-sparse.
%% See Blumensath and Davies 2010.
%%
%% Inputs:
%% y: measurement vector
%% A: measurement matrix
%% s: sparsity of the data vector
%% parameters: additional parameters:
%%                {1}: epsilon: error threshold: stop iterations if below
%%                {2}: maxiters: stop iterations if #iterions above
%%
%% Output:
%% x_hat: estimate of the sparse underlying datavector x with guaranteed
%%          sparsity $\|x_hat\|_0 \leq s$

err = inf;
n = 0;
N = size(A,2);

epsilon = parameters{1};
maxiters = parameters{2};

x_hat = A'*y;
[~,T] = sort(abs(x_hat),'descend');
T = T(1:s);
x_hat(setdiff(1:N,T)) = 0;
res = y - A*x_hat;

while err > epsilon && n<maxiters
    n=n+1;

% Compute Step Size omega
Ar = A'*res;
ArT = Ar(T);
omega = norm(ArT)^2/norm(A(:,T)*ArT)^2;

% Gradient Descend Step
x_hat = x_hat + omega*Ar;

[~,T] = sort(abs(x_hat),'descend');
T = T(1:s);
x_hat(setdiff(1:N,T)) = 0;

% Compute residual and error
res = y-A*x_hat;
err = norm(res);

end
