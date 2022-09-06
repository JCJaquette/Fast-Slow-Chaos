function output =map(x,alpha,mu)

%   Sample function files for the trajectory and the tangent map:
%   ---------------------------
%   Sample for xfile='map'; coupled logistic maps (stored in m-file map.m)
%   function xmap=map(x,iter)
%   d=.2; r=3.6;
%   xm(1)=d*r*x(1)*(1-x(1))     +    (1-d)*r*x(2)*(1-x(2));
%   xm(2)=(1-d)*r*x(1)*(1-x(1)) +    d*r*x(2)*(1-x(2));
%   xmap=[xm(1) xm(2)]';
  
%   Parameters
% mu = .05;
% alpha = 2.75;

sigma = -1;
I=0;
  
x_out = alpha / ( 1 + x(1)^2 ) + x(2) + I;
y_out = x(2) - mu*(x(1)-sigma);

output = [x_out,y_out];  
  
end