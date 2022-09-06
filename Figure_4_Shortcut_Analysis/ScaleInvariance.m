SwitchMu001=[3.996	2.17E-04	0.000835743
3.997	0.259239517	0.28512239
3.998	0.452757652	0.488937257
3.999	0.580760856	0.63480858
4.000	0.699857752	0.739128369
4.001	0.782763601	0.813694527
4.002	0.837091418	0.866973289
4.003	0.87678759	0.905030803
4.004	0.902908925	0.93220933
4.005	0.932377776	0.951615031
4.006	0.952059419	0.965468711
4.007	0.956493078	0.975357544
4.008	0.967328635	0.982415493
4.009	0.980981595	0.987452513
4.010	0.988123515	0.991047004];

SwitchMu01=[3.96	0.007905515	0.008514
3.97	0.263547587	0.294063
3.98	0.462727118	0.497892
3.99	0.615911409	0.642833
4	0.734339336	0.7458
4.01	0.804799633	0.818944
4.02	0.8588557	0.87092
4.03	0.897159647	0.907878
4.04	0.935145877	0.934179
4.05	0.952664252	0.952914
4.06	0.963792959	0.966273
4.07	0.977909872	0.97581
4.08	0.983506463	0.982626
4.09	0.988583047	0.987504
4.1	0.992482368	0.99100023];
%%
figure;
plot(SwitchMu01(:,1),SwitchMu01(:,2),'--','linewidth',3);
hold on
plot(SwitchMu01(:,1),SwitchMu01(:,3),'linewidth',3);
% figure
plot(SwitchMu001(:,1),SwitchMu001(:,2),'--','linewidth',3);
hold on
plot(SwitchMu001(:,1),SwitchMu001(:,3),'linewidth',3);
xlim([3.96,4.03]);
set(gca,'FontSize',18)
legend('\mu=0.01, numerics','\mu=0.01, theory','\mu=0.001, numerics','\mu=0.001, theory','FontSize',15);
%%
figure;
loglog((SwitchMu01(:,1)-SwitchMu01(1,1))/0.01,SwitchMu01(:,2),'o--');
hold on
loglog(SwitchMu01(:,1)-SwitchMu01(1,1),SwitchMu01(:,3));
% figure
loglog(10*(SwitchMu001(:,1)-SwitchMu001(1,1)),SwitchMu001(:,2),'o--');
hold on
loglog(10*(SwitchMu001(:,1)-SwitchMu001(1,1)),SwitchMu001(:,3));
hold on
loglog(SwitchMu01(:,1)-SwitchMu01(1,1),30*(SwitchMu01(:,1)-SwitchMu01(1,1)).^(0.8),'k');

(SwitchMu01(2:end,1)-SwitchMu01(1,1))./(SwitchMu001(2:end,1)-SwitchMu001(1,1))
%%


k=1
Pow=@(x,k) sign(x)*abs(x).^k
figure;
mu=0.01;
plot((SwitchMu01(:,1)-4)/mu,SwitchMu01(:,2),'o--','linewidth',2);
hold on
plot((SwitchMu01(:,1)-4)/mu,SwitchMu01(:,3),'linewidth',2);
mu=0.001;
plot((SwitchMu001(:,1)-4)/mu,SwitchMu001(:,2),'o--','linewidth',2);
plot((SwitchMu001(:,1)-4)/mu,SwitchMu001(:,3),'linewidth',2);
legend('Mu=0.01, expe','Mu=0.01, theory','Mu=0.001, experiments','Mu=0.001, theory')

%%
S=@(a,mu)(-0.297619E0).*((-2).*a.*((-1)+mu)+(8+(-3).*mu).*mu).^(1/2).*(2.* ...
  a.*((-1)+mu)+mu.*((-8)+3.*mu)).*(((-2).*a.*((-1)+mu)+(8+(-3).*mu) ...
  .*mu).^(1/2)+2.*((-2)+a).^(-1).*(1+a).*mu.*((-2).*a.*((-1)+mu)+(8+ ...
  (-3).*mu).*mu).^(1/2)+2.*((-2)+a).^(-2).*a.*mu.^2.*((-2).*a.*((-1) ...
  +mu)+(8+(-3).*mu).*mu).^(1/2)+(-1).*a.*(1+(1/4).*(a+mu+(-1).*((-2) ...
  .*a.*((-1)+mu)+(8+(-3).*mu).*mu).^(1/2)).^2).^(-1)+a.*(1+(1/4).*( ...
  a+mu+((-2).*a.*((-1)+mu)+(8+(-3).*mu).*mu).^(1/2)).^2).^(-1)).^( ...
  -1);
RS=@(a,mu) real(S(a,mu)).*(abs(imag(S(a,mu)))<1e-6);

DeltaYOverMu=@(a,mu) (((-2).*a.*((-1)+mu)+(8+(-3).*mu).*mu).^(1/2)+2.*((-2)+a).^(-1).*( ...
  1+a).*mu.*((-2).*a.*((-1)+mu)+(8+(-3).*mu).*mu).^(1/2)+2.*((-2)+a) ...
  .^(-2).*a.*mu.^2.*((-2).*a.*((-1)+mu)+(8+(-3).*mu).*mu).^(1/2)+( ...
  -1).*a.*(1+(1/4).*(a+mu+(-1).*((-2).*a.*((-1)+mu)+(8+(-3).*mu).* ...
  mu).^(1/2)).^2).^(-1)+a.*(1+(1/4).*(a+mu+((-2).*a.*((-1)+mu)+(8+( ...
  -3).*mu).*mu).^(1/2)).^2).^(-1))./mu;

RDeltaYOverMu=@(a,mu) real(DeltaYOverMu(a,mu)).*(abs(imag(DeltaYOverMu(a,mu)))<1e-6);

a=-0.1:0.001:0.4;
mu=0.001;

return 

figure;
plot(a+4,(1 - (1 - S(a,mu)).^(DeltaYOverMu(a,mu))))
hold on
mu=0.01;
plot(a+4,(1 - (1 - S(a,mu)).^(DeltaYOverMu(a,mu))))
ylim([0,1])



figure;
plot(SwitchMu01(:,1),SwitchMu01(:,2),'--','linewidth',3);
hold on
plot(SwitchMu01(:,1),SwitchMu01(:,3),'linewidth',3);
% figure
plot(SwitchMu001(:,1),SwitchMu001(:,2),'--','linewidth',3);
hold on
plot(SwitchMu001(:,1),SwitchMu001(:,3),'linewidth',3);

mu=0.001;
plot(a+4,(1 - (1 - RS(a,mu)).^(RDeltaYOverMu(a,mu))))
hold on
mu=0.01;
plot(a+4,(1 - (1 - RS(a,mu)).^(RDeltaYOverMu(a,mu))))
ylim([0,1])
