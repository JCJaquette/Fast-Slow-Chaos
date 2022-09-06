%% Different parameter regimes 

% For fixed mu = 0.05, these are the different qualitative regimes

% alpha = 1.9     --  Neimar Sacker bifurcation, birthing invariant circle
% alpha = 2.75    --  Approximate birth of (micro) chaos
%                 --  Co-existence of periodic orbits & (fast) chaos
%                 --    depending on infinitesimal change of alpha parameter
% alpha = 3.041   --  Periodic orbit, large period
% alpha = 3.05    --  Segmented chaos. 
% alpha = 3.5     --  Only (fast) chaos; periodic orbits no longer appear
% alpha = 3.795   --  Beginning of slow chaos
% alpha = 4.5-5.0 --  Still slow chaos, but long quiescent period disappears

% Taking mu smaller / slower causes
% - Slow chaos starts at a larger value of alpha 
% - Disappearance of long quiescence starts at a smaller value of alpha 


% We Plot on one figure the traces for Alpha = 
% 2.698 (Weak Chaos)
% 3.950 (Fast I Chaos)
% 4.000 (Slow Chaos)
% 4.100 (Fast II Chaos)
% 5.000 (Hyper Chaos)


%% Define parameters 
% close all;
% clear all

alpha_list = [ 
     2.698 % (Weak Chaos)
     3.950 % (Fast I Chaos)
     4.000 % (Slow Chaos)
     4.050 % (Fast II Chaos)
     5.000 % (Hyper Chaos)
     ];

mu      = 0.01;    % Slow parameter
I       = 0;        % Input current
sigma   = -1;       % 

PLOT_TRACE      = 1;
PLOT_ATTRACTOR  = 0;
PLOT_HISTOGRAM  = 0;

% Computational Parameters 


trace_periods = 20;
x_vect=-4:.01:1.5;
% RulkovScratch

fig_b     = 200;
fig_l     = 750;
fig_width  = 700;
fig_height = 500;

% Number of points to keep
N_keep =1*10^6;
% Toss initial Trajectory
N_cut = 10^5;
N = N_cut + N_keep -1;

% Max range for plotting trace
T_min_graphing = 100000 ;
x_vect=-4:.01:1.5;

 
 
alpha_number = 0;
figure()

for alpha=alpha_list'
    alpha_number = alpha_number +1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Compute a trajectory
    % Seed
    x_0 = -1 +randn();
    y_0 = -2.1  ;

    % Initialize trajectory
    X = 1:N;
    Y = 1:N; 
    % Seed initial condition
    X(1) = x_0;
    Y(1) = y_0;

    % Compute Trajectory
    for i = 1:N-1
        [X(i+1),Y(i+1)] = Rulkov_Map( X(i) , Y(i) , alpha, mu, sigma, I );
    end

    % The final trajectory, with the initial part thrown away
    X_final = X(N_cut:N) ; 
    Y_final =Y(N_cut:N) ; 


    %% Plot the trace

    if PLOT_TRACE 
        N_final = length(X_final);

        T_min_graphing = N_final-0999;%max(1,trace_periods*ave_period);
        T_min_graphing = ceil(T_min_graphing);

        subplot(length(alpha_list),1,alpha_number)
        ylim([-4.5,2])
        hold on
        
        
        subplot(length(alpha_list),2,2*alpha_number-1)
        plot(X_final(T_min_graphing:N_final))
        ylim([-4.5,2])
        
        if (alpha == alpha_list(end)) == 0
            set(gca,'XTick',[])
        end

%         ylim([-4.,2])
        subplot(length(alpha_list),2,2*alpha_number)
        plot(Y_final(T_min_graphing:N_final ))
        ylim([-4.5,2])
        
        if (alpha == alpha_list(end)) == 0
            set(gca,'XTick',[])
        end

%         ylim([-4.25,-2])


        hold off
%         ylabel(['\alpha = ',num2str(alpha),'  '])
         hYLabel = get(gca,'YLabel');
         set(hYLabel,'FontWeight','bold')
hYLabel.Position(1) = fig_width+320; % change horizontal position of ylabel
set(hYLabel,'rotation',0,'VerticalAlignment','middle','HorizontalAlignment','left')
ylim([-4.5,-2])
%         title(['\alpha = ',num2str(alpha),', \mu = ',num2str(mu)])
%         xlabel('n')
    %     xlim([1,N_final-T_min_graphing]);
    
%         legend('x (fast)','y (slow)')
        set(gcf, 'Position',  [fig_l,fig_b, fig_width, fig_height]);
    %     ylim([-2 -0.5])
    end


end
