function TEWave3D_VaryingTime( )
% Function: Animate the TE wave propagation direction at different time
% Input: The width a, the height b, the length c
%        Frequency of the wave: f (Hz)
%        The mode numbers: m, p
%        Dielectrics parameters: epsilon_r, mu_r
%        Amplitude of the H field: H0
%        Time of simulation: e.g., T = [0:0.1/f: 2*1/f]
%        Numbers of grid points in the x, y, z directions: Na, Nb, Nc
%        Pausetime: time interval of displaying results for next time instant

a=0.15; b=0.05;
m=2; p=1;
epsilon_r=8; mu_r=1;
H0=1;

%% Compute the cutoff frequency
c0 = 3e8; % Speed of light in vacuum (m/s)

fcmp = (c0 / (2 * pi * sqrt(mu_r * epsilon_r))) * sqrt((m * pi / a)^2 + (p * pi / b)^2);

fprintf('Cutoff Frequency: %.2f GHz\n', fcmp / 1e9);