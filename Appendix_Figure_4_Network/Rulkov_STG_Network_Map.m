function [ x_out_vec ,y_out_vec ] = Rulkov_STG_Network_Map( x_vec, y_vec , alpha_vec, mu_vec, sigma_vec, I_vec , connectivity_mat,theta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

M = length(alpha_vec);

x_out_vec = x_vec;
y_out_vec = y_vec;

% Compute Mean Field Coupling 

% C = epsilon*sum(x_vec) /M;

Coupling_effect = connectivity_mat*(x_vec-theta);

% Compute 
for i = 1:M
    [ x_out ,y_out ] = Rulkov_Map( x_vec(i), y_vec(i) , alpha_vec(i), mu_vec(i), sigma_vec(i), I_vec(i) );
    x_out_vec(i) = x_out ;
    y_out_vec(i) = y_out +Coupling_effect(i);
end


end

