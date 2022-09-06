close all
clear all
BIF_DIAG=1;
beta=0.5;
thresh=2.;
g=1;
% phi=@(x, thresh)=exp(-(abs(x)-thresh)^2*(abs(x)>thresh));
phi=@(x, thresh,g) ((1+tanh(g*(x-thresh)))+(1+tanh(g*(-x-thresh))))/2;
F=@(x,alpha,gamma) (-beta*x^3 +alpha*x+ gamma)*(1-phi(x,thresh,g));

% Values of alpha used in the figure:
% 2.5: Fast chaos. 
% 2.8: nice clear onset of slow chaos before crisis. 
% 3: crisis (not used)
% 3.2: slow chaos after crisis
alpha=3.5; 
gamma=0;
x0=0.1
x=x0
N=1500;
n_gamma=800;
gamma_max=3.1;

markersize=1
transparency=0.1

Attractor=zeros(N/2+1,2*n_gamma);
Gamma_vect=zeros(2*n_gamma,1);
gvect=linspace(-gamma_max,gamma_max,n_gamma);


if BIF_DIAG
% figure;
k=0;
hold on
for gamma=gvect
    k=k+1;
    if ~isnan(x(end))
        x(1)=x(end);
    else
        x=0.1;
    end
    for i=1:N
        x(i+1)=F(x(i),alpha,gamma);
    end
%     plot(gamma, x(ceil(end/2):end),'k.') 
    Gamma_vect(k)=gamma;
    Attractor(:,k)=x(N/2:N)';
end

for h=gvect
    k=k+1;
    gamma=-h;
    if ~isnan(x(end))
        x(1)=x(end);
    else
        x=-1.1;
    end
%     x=x0;
    for i=1:N
        x(i+1)=F(x(i),alpha,gamma);
    end
%     plot(gamma, x(ceil(end/2):end),'k.') 
    Gamma_vect(k)=gamma;
    Attractor(:,k)=x(N/2:N)';
end

figure(1);
hold off
xvect=-5:0.01:5;
plot(beta*xvect.^3+(1./(1-phi(xvect,thresh,g))-alpha).*xvect,xvect);
% GG=Gamma_vect*ones(1,N/2+1)
hold on
for i=1:k
    scatter(Gamma_vect(i)*ones(1,N/2+1),Attractor(:,i),markersize,'k','MarkerFaceAlpha',transparency,'MarkerEdgeAlpha',transparency)
end
xlim([-gamma_max,gamma_max]);
% ylim([-5,5]);
end

%%
% close all
% clear all
% gamma_max=1;
% load Attractor_Alpha_2.2.mat
% figure;
% xvect=-3:0.01:3;
% alpha=2.2;
% plot(beta*xvect.^3+(1-alpha)*xvect,xvect);
% GG=Gamma_vect*ones(1,N/2+1)
% hold on
% 
% 
% for i=1:k
%     scatter(Gamma_vect(i)*ones(1,N/2+1),Attractor(:,i),0.1,'k.','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1)
% end
% xlim([-gamma_max,gamma_max]);

% F=@(x,alpha,gamma) -0.4*x^3 + alpha*x+ gamma;
% alpha=2.2;
%%
% close all
x=0.2
N=20000;
xmax=1e10;
xmin=-xmax;
% figure;   
hold on
SS=-0.1;
Delta=0.2;
G=@(gamma,x) (SS*gamma-x+Delta-0.9*x^3);%-1*gamma^3;
gamma=0.;
epsilon=0.01;

    for i=1:N
        x(i+1)=F(x(i),alpha,gamma(i));
        gamma(i+1)=gamma(i)+epsilon*G(gamma(i),x(i));
    end
    figure(1);
    scatter(gamma(1:N), x(1:N),5,'filled','MarkerFaceAlpha',1,'MarkerEdgeAlpha',1)
    plot(Gamma_vect,(SS*Gamma_vect-Delta));
figure();
plot(x)
hold on
plot(gamma)
%%
figure;
plot(x,'.');
hold on
plot(gamma,'.');

% figure(1)
% hold on
% plot(gamma(N/2:N), x(N/2:N),'.')
% ylim([-3,3])
