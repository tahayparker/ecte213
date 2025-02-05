function [E_x, E_y, E_z, H_x, H_y, H_z] = TEM_2D(epsilon_r, mu_r, a, b, z, f, t, Na, Nb); 
% Function: Generate the field quantities for a TEM wave with given parameters on a rectangular area with side lengths (a,b)   
% Input:    epsilon_r: reletive permittivity  
%           mu_r: relative permeability 
%           H0: peak intensity of Hz
%           a,b: length of the rectangular area in the x and y directions 
%           z: the z coordinate 
%           t: time instant 
%           f: frequency in Hz  
%           Na, Nb: number of grid points to evaluate 
% Output:   E_x, E_y, E_z: x-, y-, and z-components of the E field
%           H_x, H_y, H_z: x-, y-, and z-components of the H field

[x,y] = meshgrid([0:a/(Na-1):a], [0:b/(Nb-1):b]); 
[omega,beta,lambda,T,eta]=losslesspropagation(f,mu_r,epsilon_r);
E0 = 1;     % assumed the amplitude of the harmonic E wave is 1 
E_x = E0*cos(omega*t-beta*z)*ones(Na,Nb);       % all points on the transverse plane have the same field quantities 
H_y = E0/eta*cos(omega*t-beta*z)*ones(Na,Nb);     
E_y = zeros(size(E_x));                         % other field components are zero 
E_z = zeros(size(E_x));     
H_x = zeros(size(E_x)); 
H_z = zeros(size(E_x)); 