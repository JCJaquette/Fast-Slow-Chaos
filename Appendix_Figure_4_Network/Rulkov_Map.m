function [ x_out ,y_out ] = Rulkov_Map( x, y , alpha, mu, sigma, I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


CHAOTIC = 1;
if CHAOTIC 
    F= alpha / ( 1 + x^2 ) + y + I;
else
    if (x <= 0)
        F = alpha /(1-x) + y;
    elseif x< alpha + y 
        F = alpha + y;
    else
        F = -1;
    end
end

x_out = F;
y_out = y - mu*(x-sigma);

end

