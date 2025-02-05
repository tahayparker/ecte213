function [omega,beta,lambda,T,eta]=losslesspropagation(f,mu_r,epsilon_r)
%Function: Calculate the propagation parameters of waves in lossless media (including free space). 
%Inputs:  f: frequency in Hz; 
%         mu_r: relative permeability
%         epsilon_r: relative permittivity;
%Outputs: omega: angular frequency
%         beta: wavenumber (spatial frequency)
%         lambda: wavelength
%         T: time period
%         eta: intrinsic impedance;

c = 3*10^8;
omega = 2*pi*f;
V_p = c/sqrt(mu_r*epsilon_r);
beta = omega/V_p;
lambda = 2*pi/beta;
T = 2*pi/omega;
eta=377*sqrt(mu_r/epsilon_r);
