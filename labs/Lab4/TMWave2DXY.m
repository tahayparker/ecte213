function [E_x, E_y, E_z, H_x, H_y, H_z] = TMWave2DXY(epsilon_r,mu_r,E0,m,p,a,b,z,f, t, Na, Nb)
% Function: Compute the field components for a TEmp wave at a given time and z-coordidate
% Input:    epsilon_r: relative permittivity
%           mu_r: relative permeability
%           E0: peak intensity of H_z
%           m,p: mode numbers
%           a,b: width and height of the waveguide
%           z: depth of waveguide
%           t: time instant
%           Na, Nb: number of grid points to evaluate on the x and y axis
% Output:   E_x, E_y, E_z: x-, y-, z-components of E field
%           H_x, H_y, H_z: x-, y-, z-components of H field


%% Parameters initialization
[x,y] = meshgrid([0:a/(Na-1):a], [0:b/(Nb-1):b]);
epsilon0=8.8542*10^(-12);
mu0=4*pi*10^(-7);
epsilon=epsilon0*epsilon_r;
mu=mu0*mu_r;
c0=3*10^8; % speed of light
v=c0/sqrt(epsilon_r*mu_r);
omega=2*pi*f;
k=omega/v;
f_cut=v/2*sqrt((m/a)^2+(p/b)^2); % cutoff frequency
km=m*pi/a;
kp=p*pi/b;
kmp=sqrt(km^2+kp^2);
beta_mp=sqrt(k^2-kmp^2);

%% TM mode field components
E_x = real(-1j*beta_mp*(km/(kmp^2))*E0*cos(km*x).*sin(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));

E_y = real(-1j*beta_mp*(kp/(kmp^2))*E0*sin(km*x).*cos(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));

E_z = real(E0*sin(km*x).*sin(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));

H_x = real(1j*omega*epsilon*(kp/(kmp^2))*E0*sin(km*x).*cos(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));

H_y = real(-1j*omega*epsilon*(km/(kmp^2))*E0*cos(km*x).*sin(kp*y).*exp(-1j*beta_mp*z)*exp(j*omega*t));

H_z = zeros(size(H_x));