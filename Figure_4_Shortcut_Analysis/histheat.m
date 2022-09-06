
close all; clear all;

mu = 0.01; 

numbins = 75;

binedges = linspace(25,300,numbins+1);

%% Define parameters 
I       = 0;        % Input current
sigma   = -1;       % 

% Computational Parameters 
spike_window = 50;

% Number of points to keep
N_keep = 10^5;
% Toss initial Trajectory
N_cut = 1000000;
N = N_cut + N_keep -1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute a trajectory
% Seed
x_0 = -1  +randn();
y_0 = -2.1  ;

% Initialize trajectory
X = zeros(N,1);
Y = zeros(N,1); 

threshold = -1.4; 

%%%%%%%%%%%%%%%%%%%%%


numalph = 100; 

alphvect = linspace(3.5,4.5,numalph);

prop = zeros(numalph,numbins);


for j = 1:numalph
	alph = alphvect(j);
	% Seed initial condition
	X(1) = x_0;
	Y(1) = y_0;

	% Compute Trajectory
	for i = 1:N-1
		[X(i+1),Y(i+1)] = Rulkov_Map( X(i) , Y(i) , alph, mu, sigma, I );
	end

	% The final trajectory, with the initial part thrown away
	X_final = X(N_cut:N) ; 
	Y_final =Y(N_cut:N) ; 

	%% Interspike intervals 

	isisp2 = diff(find(diff([threshold+1; X_final; 0]>threshold)==1));
	ha =  histogram(isisp2,binedges); title('poincare2'); 
	vals=ha.Values;
	vals = vals/sum(vals);
	prop(j,:) = vals;
end 


[xx,yy]  = meshgrid(binedges(1:end-1),alphvect); 
thre = 0.018; 
propbinary = double(prop>thre);
vals = find(propbinary>0 & xx<150);
miny = min(yy(vals)); 
vals =  find(propbinary>0 & xx>150);
maxy = max(yy(vals)); 


figure;
hold on;
h = surf(xx,yy,prop)
xlim([25,300])
set(h,'LineStyle','none')
view(90,-90)
caxis([0,.1])

%[M,c] = contour(xx,yy,prop,[thre thre],'c');
%c.LineWidth = 2;
plot([30 30 290 290 30],[miny maxy maxy miny miny],'white','LineWidth',5)
xlabel('Interburst Intervals')
ylabel('\alpha')
exportgraphics(gcf,'heat1.pdf','ContentType','vector')


%Two color figure - not needed
%figure; 
%h = pcolor(xx,yy,propbinary)
%set(h,'LineStyle','none')
%xlabel('Interburst intervals')
%ylabel('\alpha')
%exportgraphics(gcf,'heat2.pdf','ContentType','vector')

alph = 4;
% Seed initial condition
X(1) = x_0;
Y(1) = y_0;

% Compute Trajectory
for i = 1:N-1
	[X(i+1),Y(i+1)] = Rulkov_Map( X(i) , Y(i) , alph, mu, sigma, I );
end

% The final trajectory, with the initial part thrown away
X_final = X(N_cut:N) ; 
Y_final =Y(N_cut:N) ; 

%% Interspike intervals 


isisp2 = diff(find(diff([threshold+1; X_final; 0]>threshold)==1));
figure; histogram(isisp2,binedges); 
ylabel('Frequency') 
xlabel('Interburst intervals')
title('\alpha = 4')
exportgraphics(gcf,'heat3.pdf','ContentType','vector')



