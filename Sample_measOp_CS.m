function A = Sample_measOp_CS(m,N,mode,varargin)
%Sample_measOp_CS: This function samples an (m x N) measurement operator A
%(corresponding to a compressed sensing procedure) according to the random
%model specified by "mode".

%%% Input:   m = number of rows of measurement operator
%            N = number of columns of measurement operator
%         mode = 'Gaussian': A with i.i.d. standard Gaussians
%              = 'Fourier': A with rows subsampled from a DFT matrix
%              = 'Circulant': A is partial circulant matrix with uniformly
%              subsampled rows, and complex (real) standard Gaussian
%              generator vector
%              = 'Psi_alpha': A has i.i.d. Psi_alpha variables with mean
%              zero and parameter 0 < alpha <= 2
%              = 'Student': A has i.i.d. Student-t variables with k degrees
%              of freedom
%              = 'Rademacher': A has i.i.d. {-1,+1}-Rademacher variables.
%
%%% Output:  A = measurement operator

field = 'complex';
if nargin >= 4
    field = varargin{1};
end
if strcmp(mode,'Gaussian')
    std_dev = 1;
    if strcmp(field,'complex')
        A= (normrnd(0,std_dev,m,N)/sqrt(2)+1i*normrnd(0,std_dev,m,N)/sqrt(2))/sqrt(m);
    elseif strcmp(field,'real')
        A=normrnd(0,std_dev,m,N)/sqrt(m);
    else
        error('Specify field: Either "complex" or "real"');
    end
    
elseif strcmp(mode,'Fourier')
    DFT = dftmtx(N);
    Omega= randperm(N,m);
    A = DFT(Omega,:)/sqrt(m);
elseif strcmp(mode,'Radar') %'Radar_Fourier'
    DFT = dftmtx(N);
    Omega= randperm(N,m);
    A = ((randi(2,m,1)-1.5).*2.*rand(m,1).*100+0.5.*ones(m,1)).*DFT(Omega,:)/sqrt(m);
%     for j=1:N
%        A(:,j)=A(:,j)./norm(A(:,j)).*sqrt(m); 
%     end
    %DFT(Omega,:).*((randi(2,1,N)-1.5).*2.*rand(1,N).*10+0.5.*ones(1,N));
    %DFT(Omega,:).*randn(1,N).^2;
    
elseif strcmp(mode,'Circulant')
    DFT = dftmtx(N);
    if strcmp(field,'real')
        gHat=randn(N,1); %gHat=DFT*randn(N,1);
    elseif strcmp(field,'complex')
        gHat=DFT*(randn(N,1)./sqrt(2)+1i*randn(N,1)./sqrt(2));
    else
        error('Specify field: Either "complex" or "real"');
    end
    gHat=gHat./sqrt(N);
    Circ=toeplitz([gHat(1) fliplr(gHat(2:end))'], gHat.');
    Omega= randperm(N,m);
    A = Circ(Omega,:);
    
elseif strcmp(mode,'Psi_alpha')
    alpha = varargin{2};
    fun = @(x) abs(x).^(4/alpha).*1./(sqrt(2*pi)).*exp(-(x).^2./2);
    q = integral(fun,-Inf,+Inf);
    if strcmp(field,'real')
        A = randn(m,N);
%         A = sign(A).*abs(A).^(2/alpha);  
        A = (sign(A).*abs(A).^(2/alpha)) ./sqrt(q);%./(4/alpha).^(2/alpha)
        %./(sqrt(gamma(1/alpha)/gamma(3/alpha))); 
    elseif strcmp(field,'complex')
        A1=randn(m,N); A2=randn(m,N);
        A = sign(A1).*abs(A1).^(2/alpha)./sqrt(2*q) + 1i.*sign(A2).*abs(A2).^(2/alpha)./sqrt(2*q);
    else
        error('Specify field: Either "complex" or "real"');
    end
    
elseif strcmp(mode,'Student')
    k     = varargin{2};
    if strcmp(field,'real')
        A = trnd(k,[m,N])./sqrt(k/(k-2));
    elseif strcmp(field,'complex')
        A = trnd(k,[m,N])./sqrt(2)./sqrt(k/(k-2)) + 1i.*trnd(k,[m,N])./sqrt(2)./sqrt(k/(k-2));
               % trnd(k,[m,N])./sqrt(2) + 1i.*trnd(k,[m,N])./sqrt(2);
    else
        error('Specify field: Either "complex" or "real"');
    end
elseif strcmp(mode,'Rademacher')
    if strcmp(field,'real')
        A = (randi(2,m,N)-1.5)*2/sqrt(m);
    elseif strcmp(field,'complex')
        A = ((randi(2,m,N)-1.5) + 1i.*(randi(2,m,N)-1.5))*2/sqrt(2*m);
    else
        error('Specify field: Either "complex" or "real"');
    end
elseif strcmp(mode,'DCT')
    DCT = dctmtx(N);
    Omega= randperm(N,m);
    A = DCT(Omega,:)/sqrt(m);
        
    
else
    error('Please specify "mode" as one of the following: Gaussian, Fourier, Circulant, Psi_alpha, Student.');
end
    
end
