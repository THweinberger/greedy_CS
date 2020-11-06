function x_hat=CoSaMP(y,A,s,parameters)
%%
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