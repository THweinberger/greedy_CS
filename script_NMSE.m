%% Version 1.2, 21.9.2018 0 AM
%%
clc;clear all;tic;

N = 200;
s = 10;
SNR = 30;

% Number of Monte Carlo runs for each parameter tuple
n_iters = 50;

% Number field for A, x and the noise
field = 'complex';

% Early stopping criterion, alogorithm halts if norm(residual) < epsilon
epsilon = 0;
%1.2*sqrt(10^(-SNR/10));

maxiters = s;

% Algorithm parameters:
% algorithm = @OMP;
% alg_parameters = {epsilon,maxiters};
% 
algorithm = @CoSaMP;
alg_parameters = {epsilon,maxiters};
% 
% algorithm = @ROMP;
% alg_parameters = {epsilon,maxiters};
%
% algorithm = @StOMP;
% %% t: threshold parameter \in \[2,3\]. Lower value promotes larger
% %% number of selected entries per iteration.
% t = 2; 
% alg_parameters = {epsilon,maxiters,t};
% 
% algorithm = @gOMP;
% %% K: number of newly added entries per iteration.
% %% For theoretical guarantees, K !<= min{s,m/s} (see Wang 2011)
% K=3; 
% alg_parameters = {epsilon,maxiters,K};
%
% algorithm = @NIHT;
% alg_parameters = {epsilon,maxiters};
% 
% algorithm = @CSMPSP;
% alg_parameters = {epsilon,maxiters};

% Value k for t-Student matrix
k = 20;

matrix = {'Fourier'};
vectors = {'linear','quadratic','flat','pflat'};


plot_title = ['A=',matrix{1},', field=',field,', N=',num2str(N),', s=',num2str(s),' SNR/dB=',num2str(SNR)];

figure;
for jj = 1:length(vectors)
[data, s_m] = NMSE(N,s,SNR,n_iters,algorithm,matrix{1},vectors{jj},field,alg_parameters,k);
semilogy(s_m,data);
hold on;
end

legend(vectors{:});
xlabel('s/m');
ylabel('NMSE');
title(plot_title);

time_total = toc/60