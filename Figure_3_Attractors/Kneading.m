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
Ntimes=5;
X_knead=zeros(length(Y_list),Ntimes);
Y_knead=zeros(length(Y_list),Ntimes);
for j = 1:length(Y_list)
    y0 = Y_list(end-j+1); 
    X_1=zeros(1,Ntimes);
    if (alpha-y_0)/y_0 >0
        X_1(1) = 0;sqrt((alpha-y_0)/y_0);
    else
        X_1(1)=0;
    end
    
    for i = 1 : Ntimes
        x = X_1(i);
        X_1(i+1) = RulkovFast(alpha,x,y0);
    end

%     Y_total_1((N_shift+(j-1)*N_keep_1+1):(N_shift+(j)*N_keep_1)) =y0;
%     X_total_1((N_shift+(j-1)*N_keep_1+1):(N_shift+(j)*N_keep_1)) =X_1(N_cut_1+1:end);
    Y_knead(j,:)=y0*ones(1,Ntimes);
    X_knead(j,:)=X_1(2:end);

end
% hold on 
% scatter(X_total,Y_total);
