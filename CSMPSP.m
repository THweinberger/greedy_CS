function x_hat=CSMPSP(y,A,s,parameters)
%% Version 1.1, 19.9.2018 6PM
%%
err = inf;
res = y;
n = 0;
[m,N] = size(A);
supp_x= [];
x_hat = zeros(N,1);

epsilon = parameters{1};
maxiters = parameters{2};

while err > epsilon && n<maxiters
    n=n+1;
    
% find 2s columns with maximum correlation
[~,ind]=sort(abs(A'*res),'descend');
S = [supp_x;ind(1:min([N,s]))];
S = unique(S);
A_n = A(:,S);

% Perform Least Squares
u_n = A_n\y;

[~,I] = sort(abs(u_n),'descend');

I = I(1:s);
supp_x = S(I);
x_hat = zeros(N,1);
x_hat(supp_x) = u_n(I);

% Compute error
res = y-A*x_hat;
err = norm(res);

end