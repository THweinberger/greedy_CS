%% This is a script generates phase transition diagrams which compare
%% the empirical rate of successful recovery attained by various sparse
%% recovery algorithms.

%clc;clear all;
tic;

N = 50;
SNRs = [Inf];

% Number of Monte Carlo runs for each parameter tuple
n_iters = 20;

% Number field for A, x and the noise
field = 'complex';

% Early stopping criterion, algorithm halts if norm(residual) < epsilon
epsilon = 1e-12;

% Letting maxiters = -1 leads to a maximum number of iterations equal to the
% sparsity s
maxiters = -1;

% Algorithm parameters:
% algorithm = @OMP;
% alg_parameters = {epsilon,maxiters};
%
% algorithm = @CoSaMP;
% alg_parameters = {epsilon,maxiters};
%
% algorithm = @ROMP;
% alg_parameters = {epsilon,maxiters};
%
algorithm = @StOMP;
%% t: threshold parameter \in [2,3]. Smaller value promotes larger
%% number of selected entries per iteration.
t = 2;
alg_parameters = {epsilon,maxiters,t};
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


% Value k for t-Student matrix. Choose k= log(N) for theoretical guarantees
k = 3;

matrices = {'Fourier'};
vectors = {'linear'};

for kk = 1:length(SNRs)
    for ii = 1:length(matrices)
        for jj = 1:length(vectors)
        PTD(N,SNRs(kk),n_iters,algorithm,matrices{ii},vectors{jj},field,alg_parameters,k);
        end
    end
end
time_total = toc/60
