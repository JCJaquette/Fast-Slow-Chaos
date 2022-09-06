N_keep_1 = 200;
N_cut_1 = floor(N_keep_1*0.25);
N_1=N_keep_1+N_cut_1;
ny=1000
Y_list = linspace(-2,-6,ny+1);
% close all

Y_total_1 = 0*( 1:  (length(Y_list)*N_keep_1));
X_total_1 = Y_total_1;
X_1 = 1:N_1;
x0=-3;
alpha

% 
% for j = 1:length(Y_list)
%     y0 = Y_list(j);     
%     X(1) = -1.5;
%     for i = 1 : N-1
%         x = X(i);
%         X(i+1) = RulkovFast(alpha,x,y0);
%     end
% 
%     Y_total((j-1)*N_keep+1:(j)*N_keep) =y0;
%     X_total((j-1)*N_keep+1:(j)*N_keep) =X(N_cut+1:end);
% end
% figure;
% scatter(X_total,Y_total);
N_shift=length(X_total_1);
x0=1
for j = 1:length(Y_list)
    y0 = Y_list(end-j+1);     
    X_1(1) = 0;
    for i = 1 : N_1-1
        x = X_1(i);
        X_1(i+1) = RulkovFast(alpha,x,y0);
    end

    Y_total_1((N_shift+(j-1)*N_keep_1+1):(N_shift+(j)*N_keep_1)) =y0;
    X_total_1((N_shift+(j-1)*N_keep_1+1):(N_shift+(j)*N_keep_1)) =X_1(N_cut_1+1:end);
end
Y_total=Y_total_1;
X_total=X_total_1;
% hold on 
% scatter(X_total,Y_total);
