  function [T]=tanmap(X,alpha,mu)

%   ---------------------------
%   Sample for tanmfile='tanmap'; Jacobian for coupled logistic maps (stored in 
%   m-file tanmap.m)
%   function [T]=tanmap(x)
%   d=.2; r=3.6;
%   T=  [  d*r*(1-2*x(1))        (1-d)*r*(1-2*x(2))
%         (1-d)*r*(1-2*x(1))       d*r*(1-2*x(2)) ];
%   ---------------------------

    
    %   Parameters
% mu = .05;
% alpha = 2.75;

% sigma = -1;
% I=0;
  
x=X(1);y=X(2);
% x_out = alpha / ( 1 + x(1)^2 ) + x(2) + I;
% y_out = x(2) - mu*(x(1)-sigma);
T = [ -alpha*2*x/(1+x^2)^2, 1;
      -mu, 1];    
  end