function x = generate_x(N,s,type,field)
%% This function allows to generate a random sparse signal from some underlying
%% predetermined probability distribution. Note that the non-zero entries are
%% drawn uniformly at random.
%%
%% Inputs:
%% N: ambient dimension of the generated vector x
%% s: sparsity of the generated vector x
%% type: string which determines the probability distribution of the non-zero
%%       entries. Valid inputs:
%%          'gaussian': draw sparse x from multivariate standard Gaussian
%%                      distriburion with i.i.d. entries
%%          'flat': draw sparse x such that all non-zero entries are equal to 1
%%          'linear': draw sparse x such that the value of all non-zero entries
%%                    is equal to their respective index
%%          'quadratic': draw sparse x such that the value of all non-zero entries
%%                    is equal to the square of their respective index
%%          'pflat': draw sparse x such that one half of the non-zero entries
%%                   is equal to 1 and 2, respectively (discrete saw-tooth)
%%
%% Output:
%% x: N-dimensional and s-sparse random vector

        if strcmp(type,'gaussian')
            std_dev = 1;
%             if strcmp(field,'real')
                x = [normrnd(0,std_dev,s,1);zeros(N-s,1)];
%             elseif strcmp(field,'complex')
%                 x = [normrnd(0,std_dev,s,1) + 1i*normrnd(0,std_dev,s,1);zeros(N-s,1)];
%             else
%                 error('Field must be either real or complex');
%             end
            x = x(randperm(N));
        elseif strcmp(type,'flat')
            x = [ones(s,1);zeros(N-s,1)];
            x = x(randperm(N));
        elseif strcmp(type,'linear')
            idcs = randperm(N,s)';
            x = [idcs;zeros(N-s,1)];
            x = x(randperm(N));
        elseif strcmp(type,'quadratic')
            idcs = randperm(N,s)';
            x = [idcs.^2;zeros(N-s,1)];
            x = x(randperm(N));
        elseif strcmp(type,'pflat')
            x = [ones(s,1)+mod(1:s,2)';zeros(N-s,1)];
            x = x(randperm(N));
            else
                error('Choose a valid type: gaussian, constant, linear, quadratic or flat');
            end
end
