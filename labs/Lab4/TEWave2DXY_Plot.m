function [E_x, E_y, E_z, H_x, H_y, H_z]=TEWave2DXY_Plot(epsilon_r,mu_r,E_0,m,p,a,b,z,f,t)
%% Function: Demonstrate the field components of a TE21 mode wave with E_0=1
%  Input:    Parameters are same as for TEWave2DXY
epsilon_r=8;
mu_r=1;
E_0=1;
m=1;
p=1;
a=0.15;
b=0.05;
f=2*1.12*10^9;
z=0;
t=0.1/f;

%% Compute and plot the field components
Na = 20;
Nb = 20;
[x,y] = meshgrid([0:a/(Na-1):a], [0:b/(Nb-1):b]);
[E_x, E_y, E_z, H_x, H_y, H_z]=TEWave2DXY(epsilon_r,mu_r,E_0,m,p,a,b,z,f, t, Na, Nb);
figure
subplot(3,2,1); quiver(x,y,E_x, E_y );                          % Use quiver to plot the Ex, Ey components in the 2D plane
axis([0 a 0 b]); xlabel('x'); ylabel('y'); title('(E_x, E_y)')
subplot(3,2,3); surf(x,y, E_z);                                 % Use surf to plot the Ez component for points on the 2D plane
title('E_z');xlabel('x'); ylabel('y');
subplot(3,2,5); surf(x,y, sqrt(abs(E_x.^2)+abs(E_y.^2)+abs(E_z.^2)))    % Plot the magnitude of the E field
title('|E|'); rotate3d on;xlabel('x'); ylabel('y');
subplot(3,2,2); quiver(x,y,H_x, H_y, 2)                         % Plot the Hx, Hy components
axis([0 a 0 b]); xlabel('x'); ylabel('y'); title('(H_x, H_y)')
subplot(3,2,4); surf(x,y, H_z)                                  % Plot Hz component
title('H_z');xlabel('x'); ylabel('y');
subplot(3,2,6); surf(x,y, sqrt(abs(H_x.^2)+abs(H_y.^2)+abs(H_z.^2)))    % Plot the magnitude of the H field
title('|H|'); rotate3d on; xlabel('x'); ylabel('y');
