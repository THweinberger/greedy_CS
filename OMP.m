function x_hat=OMP(y,A,s,parameters)
%% Version 1.1, 19.9.2018 6PM
%%
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