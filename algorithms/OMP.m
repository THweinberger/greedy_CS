function x_hat=OMP(y,A,s,parameters)
%% Orthogonal Matching Pursuit algorithm for sparse recovery from incomplete
%% measurements y = Ax + e such that the ground truth data vector x is s-sparse.
%% See Tropp and Gilbert 2007
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

% find column with maximum correlation
    [~,ind]=max(abs(A'*res));

S = [S;ind];

% Perform Least Squares based on QR decomposition
% A_n = A(:,S);
% if n == 1
%     [Q_n,R_n]=qr(A_n);
% else
%     column_idx = length(S(S<ind))+1;
%     [Q_n,R_n] = qrinsert(Q_n,R_n,column_idx,A(:,ind));
% end
% b = Q_n'*y;
% b1 = b(1:m);
% x_hat(S) = R_n\b1;

% Perform Least Squares
x_hat(S) = A(:,S)\y;


% Compute error
res = y-A*x_hat;
err = norm(res);

end
[~,ind]=sort(abs(x_hat),'descend');
x_hat(setdiff(1:N,ind(1:s))) = 0;
