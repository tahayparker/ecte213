N = 100000; xi = 0;
f = 3*10^8; c = 3*10^8; lambda = c/f;
l = 0.25*lambda;
d = 0.5*lambda;
k = 2*pi/lambda;
N_theta = 100; N_phi = 200;
% Plot 2D pattern (versus (\theta, \phi))
subplot(2,2,1)
[theta,phi] = meshgrid(0:pi./(N_theta-1):pi, 0:2*pi./(N_phi-1):2*pi);
psi = xi + k*d*sin(theta).*cos(phi);
A = 1/N*abs(sin(N*psi/2))./abs(sin(psi/2));
F = (abs(((cos(k*l*cos(theta))-cos(k*l))./sin(theta))));
E_mag = A.*F; % Coefficients irelevant to (\theta,\phi) are ignored
XD = E_mag.*sin(theta).*cos(phi);
YD = E_mag.*sin(theta).*sin(phi);
ZD = E_mag.*cos(theta);
surf(XD,YD,ZD);
title('2D pattern'); axis image; rotate3d on;
% Plot 1D pattern versus \theta with \phi=pi/2
subplot(2,2,2)
phi = pi/2;
theta = [0:pi/(N_theta-1):pi];
psi = xi + k*d*sin(theta).*cos(phi);
A = 1/N*abs(sin(N*psi/2))./abs(sin(psi/2));
F = (abs(((cos(k*l*cos(theta))-cos(k*l))./sin(theta))));
E_mag = A.*F;
polar(theta, E_mag/max(E_mag))
title('Normalized pattern vs \theta at \phi=\pi/2')
% Plot 1D pattern versus \phi with \theta=pi/2(H-plane)
subplot(2,2,3)
theta = pi/2;
phi=[0:2*pi/( N_phi-1):2*pi];
psi = xi + k*d*sin(theta).*cos(phi);
A = 1/N*abs(sin(N*psi/2))./abs(sin(psi/2));
F = (abs(((cos(k*l*cos(theta))-cos(k*l))./sin(theta))));
E_mag = A.*F;
plot(phi/pi*180, 20*log10(E_mag/max(E_mag)))
title('Normalized pattern vs \phi at \theta=\pi/2'); grid on;
xlabel('\phi(degrees)'); ylabel('dB')
% Polar plot 1D pattern versus \phi with \theta=pi/2
subplot(2,2,4)
polar(phi, E_mag/max(E_mag))
title('Normalized pattern vs \phi at \theta=\pi/2')