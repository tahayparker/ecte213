function [E_x, E_y, E_z, H_x, H_y, H_z] = TEWave3D (epsilon_r,mu_r,H0,m,p,a,b,c,f,t,Na,Nb,Nc)
% Function: Compute the field components for a TEmp wave at a given time 
% Input:    epsilon_r: relative permittivity  
%           mu_r: relative permeability 
%           H0: peak intensity of H_z
%           m,p: mode numbers 
%           a,b: width and height of the waveguide
%           c: length of waveguide 
%           t: time instant 
%           Na, Nb, Nc: number of grid points to evaluate on the x, y and z axis 
% Output:   E_x, E_y, E_z: x-, y-, z-components of E field
%           H_x, H_y, H_z: x-, y-, z-components of H field


epsilon0=8.8542*10^(-12);
mu0=4*pi*10^(-7);
epsilon=epsilon0*epsilon_r;
mu=mu0*mu_r;
c0=3*10^8;  
v=c0/sqrt(epsilon_r*mu_r);
omega=2*pi*f; 
k=omega/v; 
f_cut=v/2*sqrt((m/a)^2+(p/b)^2); % cutoff frequency
km=m*pi/a;
kp=p*pi/b;
kmp=sqrt(km^2+kp^2);
beta_mp=sqrt(k^2-kmp^2);
[x,y,z] = ndgrid([0:a/(Na-1):a], [0:b/(Nb-1):b], [0:c/(Nc-1):c]); 

E_x = real(1j*omega*mu*(kp/(kmp^2))*H0*cos(km*x).*sin(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));
E_y = real(-1j*omega*mu*(km/(kmp^2))*H0*sin(km*x).*cos(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));
E_z = zeros(size(E_x)); 
H_x = real(1j*beta_mp*(km/(kmp^2))*H0*sin(km*x).*cos(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));
H_y = real(1j*beta_mp*(kp/(kmp^2))*H0*cos(km*x).*sin(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));
H_z = real(H0*cos(km*x).*cos(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));