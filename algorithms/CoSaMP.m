function x_hat=CoSaMP(y,A,s,parameters)
%% COmpressive SAmpling Matching Pursuit algorithm for sparse recovery from
%% incomplete noisy measurements y = Ax + e such that the ground truth data
%% vector x is s-sparse. See Needell and Tropp 2009.
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
[m,N] = size(A);
supp_x= [];
x_hat = zeros(N,1);
res = y;

epsilon = parameters{1};
maxiters = parameters{2};

while err > epsilon && n<maxiters
    n=n+1;

% Identification step
[~,ind]=sort(abs(A'*res),'descend');

S = [supp_x;ind(1:min([N,2*s]))];
S = unique(S);

% Perform Least Squares
A_n = A(:,S);
u_n = A_n\y;

% Estimate new support
[~,I] = sort(abs(u_n),'descend');
I = I(1:s);
supp_x = S(I);

% Update x_hat
x_hat = zeros(N,1);
x_hat(supp_x) = u_n(I);

% Compute residual and error
res = y-A*x_hat;
err = norm(res);

end
