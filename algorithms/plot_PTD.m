function plot_PTD(datamatrix,N,m,s,filename,plot_title)
%% This function plots the phase transition diagram for a datamatrix
%% containing the respective empirical probabilities of successful
%% recontruction.

n_axis_ticks_x = 10;
n_axis_ticks_y = 8;

s_m = s(:,end)/m(end);
m_N = m/N;

% Interpolate with 2^K-1 points between each two sample points
K = 3;
datamatrix = interp2(datamatrix,K,'linear');

a1=round(linspace(1,length(m),n_axis_ticks_x));
b1=round(linspace(1,length(s),n_axis_ticks_y));

a=round(linspace(1,(2^K)*(length(m)-1)+1,n_axis_ticks_x));
b=round(linspace(1,(2^K)*(length(s)-1)+1,n_axis_ticks_y));

figure;
imagesc(datamatrix);colormap(flip(gray));
xlabel('m/N');ylabel('s/m');
set(gca,'XTick',a,'XTickLabel',round(m_N(a1),2));
set(gca,'YTick',b,'YTickLabel',round(s_m(b1),2));
set(gca,'Ydir','Normal');
title(plot_title);
c=colorbar;
ylabel(c, 'Empirical prob. of successful recovery');
%savefig(filename);

end
