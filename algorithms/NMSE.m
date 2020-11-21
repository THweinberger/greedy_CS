function [dataarray,s_m] = NMSE(N,s,SNR_db,n_iters,algorithm,type_matrix,type_x,varargin)
%% This function generates a phase transition diagram from Monte-Carlo iterations.
%% This gives a visualization for the empirical probabilities of successful
%% recovery of randomly drawn sparse signals by a given algorithm.

% Number of datapoints in the 1D parameter space
n_datapoints_m = 20;


if nargin >= 8
    field = varargin{1};
    alg_inputs = varargin{2};
    matrix_parameters = {varargin{1},varargin{3}};
end

s_m = linspace(s/N,0.4,n_datapoints_m);
m = round(s./s_m);

SNR = 10.^(SNR_db/10);
dataarray = zeros(n_datapoints_m,1);

%% Monte Carlo simulation
tic;
for ii = 1:n_datapoints_m
    data_ii = 0;
    for kk = 1:n_iters

    x = generate_x(N,s,type_x,field);

    if strcmp(field,'complex')
        noise = randn(m(ii),1) + 1i*randn(m(ii),1);
    elseif strcmp(field,'real')
        noise = rand(m(ii),1);
    else
        error('Field must be either "real" or "complex"');
    end

    noise = noise/(norm(noise)*sqrt(SNR))*norm(x);
    A = Sample_measOp_CS(m(ii),N,type_matrix,matrix_parameters{:});
    y = A*x + noise;


    % Use CS algorithm to reconstruct x
    x_hat = algorithm(y,A,s,alg_inputs);

    % [x,x_hat]
    % Normalized error
    NE = norm(x-x_hat)^2/norm(x)^2;

    % Compute empirical prob. of success
    data_ii = data_ii + NE;

    end
    dataarray(ii) = data_ii/n_iters;
end

disp(['Successfully performed ',num2str(n_datapoints_m*n_iters),' Monte-Carlo iterations in ',num2str(round(toc/60,1)),' minutes']);
filename = ['NMSE_',func2str(algorithm),'_',type_matrix,'_',type_x,'_',field,'_iters',num2str(n_iters),'_N',num2str(N),',_s',num2str(s),'_SNR',num2str(SNR_db)];
%save(filename, 'datamatrix');
end
