function x_hat=ROMP(y,A,s,parameters)
%% Regularized Orthogonal Matching Pursuit algorithm for sparse recovery from
%% incomplete noisy measurements y = Ax + e such that the ground truth data
%% vector x is s-sparse.
%% See Needell and Vershynin 2009.
%%
%% Inputs:
%% y: m-dimensional complex measurement vector
%% A: m x N-dimensional complexmeasurement matrix
%% s: sparsity of the data vector x
%% parameters: additional parameters:
%%                {1}: epsilon: error threshold: stop iterations if below
%%                {2}: maxiters: stop iterations if #iterions above
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

while err > epsilon && n<maxiters
    n=n+1;

% find columns with maximum correlation


    [c,ind]=sort(abs(A'*(res)),'descend');
    c = c(1:s);

    E_max = 0;
    for ii = 1:s
        J_0 = find(2*c >= c(ii));
        E = norm(c(J_0));

        if E > E_max
        E_max = E;
        J = J_0;
        end

    end


S = [S,ind(J)'];

% Perform Least Squares
x_hat(S) = A(:,S)\y;

% Compute error
res = y-A*x_hat;
err = norm(res);

end
[~,ind]=sort(abs(x_hat),'descend');
x_hat(setdiff(1:N,ind(1:s))) = 0;
