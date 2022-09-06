
%How to run: 
%alpha_bar=4.0;
%figurename = 'trace2.pdf'
%Rulkov_STG_Network_Att4

close all

set(0,'defaultaxesfontsize',20,'defaultaxeslinewidth',2,...
    'defaultlinelinewidth',3);



%%% Network Size 
M = 3;

%alpha_bar   = 4.1;



alpha_bar=3.9;
alpha_sigma = .00;
% alpha_vec = alpha_bar - alpha_sigma*rand(1,M);

alpha_vec = 3.9*[1,1,1];
mu_sigma = .00 ;
mu_bar = 0.01 ;
mu_vec = mu_bar *(1+ mu_sigma*rand(1,M));
sigma_vec = -1 * ones(1,M);
I_vec = 0 * ones(1,M);
theta = -1.5;
% # of points
N =     1000000;
% Toss initial Trajectory
N_cut = 100000;

% Coupling strength
epsilon = 0.001;
% Network type
STG_model = 1;
if STG_model ==1
%     We use inhibitory coupling for the neurons, as the LP-PY-PD in the STG
    if M ==3 
        connectivity_mat = zeros(M,M);
         J_pd_lp=-3.5 + (0.5-rand); 
         J_pd_py=-5 + (0.5-rand);  
         J_lp_pd=-5.5+ (0.5-rand);
         J_lp_py=-2.5+ (0.5-rand);
         J_py_lp=-3+ (0.5-rand);
      
%         Neuron 1 = PD
        connectivity_mat(2,1)= J_pd_lp;
        connectivity_mat(3,1)= J_pd_py;
%         Neuron 2 = LP
        connectivity_mat(1,2)= J_lp_pd;
        connectivity_mat(3,2)= J_lp_py;
%         Neuron 3 = PY
        connectivity_mat(2,3)= J_py_lp;
        
        connectivity_mat
        
        connectivity_mat = epsilon.*connectivity_mat;
    else
        return
    end
else
%     We use mean field coupling
    connectivity_mat = epsilon*ones(M,M)/M;
end

% connectivity_mat=0*connectivity_mat;



% Seed
x_0 = -1;
y_0 = -2.1;

initial_sigma = 1;

x_0_vec = x_0 + initial_sigma* randn(M,1);
y_0_vec = y_0 + initial_sigma* randn(M,1);



X = zeros(M,N);
Y = zeros(M,N); 

X(:,1) = x_0_vec;
Y(:,1) = y_0_vec;

% Compute Trajectory
for i = 1:N-1
    [X(:,i+1),Y(:,i+1)] = Rulkov_STG_Network_Map(  X(:,i), Y(:,i), alpha_vec, mu_vec, sigma_vec, I_vec , connectivity_mat,theta);
end


X_final = X(:,N_cut:N) ; 
Y_final = Y(:,N_cut:N) ; 

if alpha_bar < 4.00001
	plot_time = 16000-5;
	cutoff = -1.5; 
else
	plot_time = 3000-5;
	cutoff = -1.5; 
end


%figure
%plot_time = length(X_final(1,:))-1;


Xplot = X_final(:,end-plot_time:end); 
Xplotb = X_final(:,end-plot_time-1:end-1); 

loopind1 = find(Xplotb(1,:)<cutoff & Xplot(1,:)>cutoff);
loopind2 = find(Xplotb(2,:)<cutoff& Xplot(2,:)>cutoff);
loopind3 = find(Xplotb(3,:)<cutoff & Xplot(3,:)>cutoff);

looplen = min([length(loopind1),length(loopind2),length(loopind3)]);

figure
 % We plot  traces 
traces = min(3,M)+1; 
 for i = 1:traces-1 
     subplot(traces,1,i);
     plot(X_final(i,end-plot_time:end))
      set(gca,'XTick',[]);
  end
subplot(traces,1,1)
 title(['alpha =',num2str(alpha_bar)])

minmaxplot  = [min(min(Xplot)); max(max(Xplot))];

ax1=subplot(traces,1,1);
hold on;
%plot(loopind1,Xplot(1,loopind1),'o')
% plot([1;1]*loopind1,minmaxplot,'color','#77AC30')
str = '#b53737';
color1 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;

plot([1;1]*loopind1,minmaxplot,'Color',color1)
ax2=subplot(traces,1,2);
hold on;
str = '#ffd801';
color2 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;

%plot(loopind2,Xplot(2,loopind2),'o')
plot([1;1]*loopind2,minmaxplot,'Color',color2)

ax3=subplot(traces,1,3);
str = '#77AC30';
color3 = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;

hold on;
%plot(loopind3,Xplot(3,loopind3),'o')
plot([1;1]*loopind3,minmaxplot,'Color',color3)
ax4=subplot(traces,1,4);
set(gca,'YTick',[])
hold on
plot(loopind1,0*loopind1,'.','Color',color1,'markersize',40)
plot(loopind2,0*loopind2,'.','Color',color2,'markersize',40)
plot(loopind3,0*loopind3,'.','Color',color3,'markersize',40)
linkaxes([ax1,ax2,ax3,ax4],'x')
%%
Trans_mat=ComputeTransitionMatrix(X_final,-1.5);
Entropy=-nansum(nansum(Trans_mat.*log(Trans_mat)))/3
figure;
imagesc(Trans_mat);
caxis([0 1])
colorbar()

%%

%legend('PD', 'LP','PY')
%xlabel('t')
%ylabel('x')
%title(['alpha =',num2str(alpha_bar)])
%hold off

% exportgraphics(gcf,figurename,'ContentType','image')

%figure
%plot3(X_final(1,end-plot_time:end),X_final(2,end-plot_time:end),X_final(3,end-plot_time:end))

%figure; hold on;
%plot(loopind1(1) + diff(loopind1),'.','markersize',30)
%plot(loopind2(1) + diff(loopind2),'.','markersize',30)
%plot(loopind3(1) + diff(loopind3),'.','markersize',30)
%title('loopind')

varval = std(loopind1(1:looplen)-loopind3(1:looplen)) + std(loopind2(1:looplen)-loopind3(1:looplen)) + std(loopind1(1:looplen)-loopind2(1:looplen));

% 
% figure
% % We plot four attractors 
% attractor_plots = 2; 
% counter =0;
% for i = 1:attractor_plots^2 
%     if i>M
%         break;
%     end
%     counter =counter +1;
%     subplot(attractor_plots,attractor_plots,counter);
%     scatter(X_final(counter,:),Y_final(counter,:),5,'filled')
% end
%title('attractor')


% figure
%trace_final = sum(X_final,1);
% plot(trace_final(end-plot_time:end))
% plot(trace_final)
%title('trace')

% 
% N_final = length(X_final);
% 
% T_max_graphing = 10000 ;
% 
% figure
% hold on
% plot(X_final(N_final -T_max_graphing:N_final ))
% plot(Y_final(N_final-T_max_graphing:N_final ))
% hold off
% title('nfinal')

%%
figure()
plot(X_final(1,:),Y_final(1,:),'.');
hold on
    x_vect=-5:.01:2;
    plot(x_vect,x_vect-alpha_bar./(1+x_vect.^2),'linewidth',3)

figure()
plot(X_final(2,:),Y_final(2,:),'.');
hold on
    x_vect=-5:.01:2;
    plot(x_vect,x_vect-alpha./(1+x_vect.^2),'linewidth',3)


figure()
plot(X_final(3,:),Y_final(3,:),'.');
hold on
    x_vect=-5:.01:2;
    plot(x_vect,x_vect-alpha./(1+x_vect.^2),'linewidth',3)
