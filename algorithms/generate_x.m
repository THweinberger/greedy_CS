function x = generate_x(N,s,type,field)
%% Version 1.1, 19.9.2018 6PM
%%

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