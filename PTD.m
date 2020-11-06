function PTD(N,SNR_db,n_iters,algorithm,type_matrix,type_x,varargin)
%% Version 1.2, 21.9.2018 0 AM
%%
% This script generates a phase transition diagram which shows the empirical
% probabilities of successful recovery of a sparse signal.
%
%%

% Threshold tau: if the normalized error is smaller than tau + 2/sqrt(SNR),
% the current estimate \hat{x} is considered a successful recovery
tau = 1e-3;
% Number of datapoints in the 2D parameter space
% Hint: choose n = int*9 + 1
n_datapoints_m = 19;
n_datapoints_s = 19;

%%
if nargin >= 7
    field = varargin{1};
    alg_inputs = varargin{2};
    matrix_parameters = {varargin{1},varargin{3}};
end

m=round(N*linspace(0.005,1,n_datapoints_m));
s=zeros(n_datapoints_m,n_datapoints_s);
for ii = 1:n_datapoints_m
    s(:,ii)=round(linspace(1,m(ii),n_datapoints_s) )';
end

perform_s_iters = 'false';
if alg_inputs{2} == -1
  perform_s_iters = 'true';  
end
    
SNR = 10.^(SNR_db/10);
datamatrix = zeros(length(s),length(m));
%% Monte Carlo simulation
tic;
for ii = 1:n_datapoints_m
    dataarray_ii = zeros(n_datapoints_s,1);
    for jj = 1:n_datapoints_s
        data_jj = 0;
        
        if perform_s_iters == 'true'
            alg_inputs{2} = s(jj,ii);
        end
            
        for kk = 1:n_iters

        x = generate_x(N,s(jj,ii),type_x,field);
        
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
        x_hat = algorithm(y,A,s(jj,ii),alg_inputs);
    
        %[x,x_hat]
        % Normalized error
        NE = norm(x-x_hat)/norm(x);
        
        % Compute empirical prob. of success
        data_jj = data_jj + (NE<(tau+2/sqrt(SNR)));
        
        end
        dataarray_ii(jj)=data_jj;
    end
    datamatrix(:,ii)=dataarray_ii/n_iters;
end
disp(['Successfully performed ',num2str(n_datapoints_m*n_datapoints_s*n_iters),' Monte-Carlo iterations in ',num2str(round(toc/60,1)),' minutes']);
disp(['Average probability of successful recovery: ', num2str(sum(sum(datamatrix))/(n_datapoints_m*n_datapoints_s)*100),' %']);

plot_title = ['A=',type_matrix,', x=',type_x,', field=',field,', N=',num2str(N),', SNR/dB=',num2str(SNR_db)];
filename=['PTD_',func2str(algorithm),'_',type_matrix,'_',type_x,'_',field,'_iters',num2str(n_iters),'_N',num2str(N),'_SNR',num2str(SNR_db)];
%save(filename, 'datamatrix');
plot_PTD(datamatrix,N,m,s,filename,plot_title);
end