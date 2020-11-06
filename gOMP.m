function x_hat=gOMP(y,A,s,parameters)
%% Version 1.1, 19.9.2018 6PM
%% Note: for theoretical guarantees, K !<= min{s,m/s} (see Wang 2011)
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