function [ x_out ,y_out ] = Rulkov_Map( x, y , alpha, mu, sigma, I )
%Rulkov_Map:::  This function computes the chaotic Rulkov map.
%     Cf. Ibarz, Casado, Sanjuán 2011

F= alpha ./ ( 1 + x.^2 ) + y + I;

x_out = F;
y_out = y - mu*(x-sigma);

end

