close all;
sigma=10
b=2.66
eps=0.01
Scale=3
Gamma=400

t=4000;
dt=0.001;
nt=ceil(t/dt);
t0=1000;

r=1*ones(nt,1);
x=1*ones(nt,1);
y=1*ones(nt,1);
z=0*ones(nt,1);
h=1*ones(nt,1);

for k=1:nt-1

x(k+1)=x(k)+dt*(sigma*(y(k)-x(k)));
y(k+1)=y(k)+dt*(-x(k)*z(k)+Gamma*r(k)*x(k)-y(k));
z(k+1)=z(k)+dt*(x(k)*y(k)-b*z(k));

h(k+1)=h(k)+dt*(h(k)-h(k)^3/3-r(k)+x(k)/Scale);
r(k+1)=r(k)+dt*(eps*(h(k)-r(k)));
end
close all
figure;
plot3(h(ceil(t0/dt):10:end),r(ceil(t0/dt):10:end),x(ceil(t0/dt):10:end));
hold on
hvect=min(h(ceil(t0/dt):end)):0.01:max(h(ceil(t0/dt):end));
plot3(hvect,hvect-hvect.^3/3,-2*hvect,'linewidth',3);
plot3(hvect,hvect,0*hvect,'linewidth',3);
ylim([min(r(ceil(t0/dt):end))-0.1,max(r(ceil(t0/dt):end))+0.1])
view([58,52])
%%
figure;
plot(t0:dt:t,h(ceil(t0/dt):end),'linewidth',3)
figure;
plot(t0:dt:t,r(ceil(t0/dt):end),'linewidth',3)

%%
% Fast attractor
% Scale=3 %or 15 in Figure

rvect=-1:0.01:1;
t=500;
t0=200;
nt=ceil(t/dt);
nr=length(rvect);
notrans=ceil(t0/dt):nt;

r=1*ones(nt,1);
x=1*ones(nt,1);
y=1*ones(nt,1);
z=0*ones(nt,1);
h=1*ones(nt,1);
att=zeros(nr,1);
rr=zeros(nr,1);

attract=2.5;
figure;
hold on
l=1;
kr=1;
syms xx;
for r=rvect
    S = vpasolve(xx-xx^3/3==r,xx);
    RealSols=S(find(abs(imag(S))<0.001));
    for kh=1:length(RealSols)
        h(1)=RealSols(kh)+0.01*randn();
        x(1)=0.001*randn();
        y(1)=0.001*randn();
        z(1)=0.001*randn();
    for k=1:nt-1
        x(k+1)=x(k)+dt*(sigma*(y(k)-x(k)));
        y(k+1)=y(k)+dt*(-x(k)*z(k)+Gamma*r*x(k)-y(k));
        z(k+1)=z(k)+dt*(x(k)*y(k)-b*z(k));
        h(k+1)=h(k)+dt*(h(k)-h(k)^3/3-r+x(k)/Scale);
        if k*dt<t0
            k=k-1;
        end
    end
    rr(kr)=r;
    att(kr)=RealSols(kh);
    kr=kr+1;
    if var(h(notrans))<0.01
        scatter3(h(notrans),r*ones(size(x(notrans))),x(notrans),'*')
    else
        plot3(h(notrans),r*ones(size(x(notrans))),x(notrans))
    end
    end
end

plot3(hvect,hvect-hvect.^3/3,-2*hvect);
plot3(hvect,hvect,0*hvect);
ylim([min(rvect),max(rvect)])
%%
view([65,85])
        
        
