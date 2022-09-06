function [lyap1,lyap2] = lyapunov_with_param(alpha,mu)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%This problem computes the Lyapunov exponents for the Rulkov map for
%a single random initial starting point in the plane. Written by
%Evelyn Sander 2019. 
% Modified by Jonathan Jaquette 2020





    N=200000;

    
	vold = [-1;  -2.1] + 1e-3*[rand();rand()];

    w1=[1 0];
    w2=[0 1];

    l1=0;
    l2=0;

    for i=1:2*N
        vold = map(vold,alpha,mu);
    end 
    
    for i = 1:N    
    	vnew= map(vold,alpha,mu);
        dh  = tanmap(vold,alpha,mu);
        vold= vnew;   
        z1  = (dh*w1')';
        z2  = (dh*w2')';
        y1  = z1;
        y2  = z2-dot(y1,z2)/norm(z2)^2*y1;
        l1  = l1+log(norm(y1));
        l2  = l2+log(norm(y2));
        w1  = y1/norm(y1);
        w2  = y2/norm(y2);
    end
    lyap1=l1/N;
    lyap2=l2/N;


end

