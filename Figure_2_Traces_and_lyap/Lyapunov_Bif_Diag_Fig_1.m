    clear all;
    format long 

mu = 0.01;

alpha_min = 1.98;
alpha_max = 5.05;
delta = 0.01;
alpha_list = alpha_min:delta:alpha_max;

alpha_list_Lines = [ 
     2.698 % (Weak Chaos)
     3.950 % (Fast I Chaos)
     4.000 % (Slow Chaos)
     4.050 % (Fast II Chaos)
     5.000 % (Hyper Chaos)
     ];

%%%%%%% 
% Figure Parameters

M = length(alpha_list);


fig_b     = 400;
fig_l     = 700;
fig_width  = 700;
fig_height = 300;

%%%%%%% 
% Start program 

Lyap1_List      = 0*alpha_list;
Lyap2_List      = 0*alpha_list;

iter = 0;
tic
parfor iter = 1:M
    alpha = alpha_list(iter);   
    [Lyap1,Lyap2] = lyapunov_with_param(alpha,mu);
    
    lyap1 = max([Lyap1,Lyap2]);
    lyap2 = min([Lyap1,Lyap2]);

    
    Lyap1_List(iter) = lyap1;
    Lyap2_List(iter) = lyap2;

end
toc

 

figure
hold on 
for alpha = alpha_list_Lines
    line([alpha,alpha],[-.8,0.4],'Color','k','LineWidth',1);
end


s1=scatter(alpha_list,Lyap1_List)
s2=scatter(alpha_list,Lyap2_List)
xlim([alpha_min,alpha_max])
%



% title(['Lyapunov Exponents' newline  '\mu = ' num2str(mu)])
xlabel('\alpha')
legend([s1,s2],'\lambda_1','\lambda_2','Location','northwest');
ylabel('Exponent')

grid on

 ylim([-0.8,0.400000001]);

set(gcf, 'Position',  [fig_l,fig_b, fig_width, fig_height]);

hold off 


% title_str = 'Lyapunov_BifurcationDgm';    
% saveas(gcf,title_str);
% if ismac == 0 
%     cd ..\..;
%     cd('Manuscript\CodesForFigures\Figure_1\');
%     saveas(gcf,title_str,'png');
%     cd ..\..\..;
%     cd('Code\Lyapunov');
% end
% 
% 
