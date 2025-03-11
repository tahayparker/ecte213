%Plot 2D pattern
f = 3*10^8; c = 3*10^8; lambda = c/f; k = 2*pi/lambda;
l = 0.75*lambda;
N_theta = 200; N_phi = 200;
[theta,phi] = meshgrid(0:pi./(N_theta-1):pi, 0:2*pi./(N_phi-1):2*pi);
F = ((cos(k*l*cos(theta))-cos(k*l))./sin(theta));
XD = abs(F).*sin(theta).*cos(phi);
YD = abs(F).*sin(theta).*sin(phi);
ZD = abs(F).*cos(theta);
subplot(2,2,1); surf(XD,YD,ZD);
title('2D pattern vs (\theta, \phi)'); axis image; rotate3d on; grid on;
% Pattern vs \theta in polar coordinates
N_theta = 200;
theta = [0: pi/( N_theta-1):pi];
F = (cos(k*l*cos(theta))-cos(k*l))./sin(theta);
subplot(2,2,2)
polar(theta,abs(F))
title('1D pattern vs \theta'); grid on
% Pattern vs \theta in rectangular coordinates
subplot(2,2,4)
% Normalize F for dB calculation
F_normalized = abs(F)/max(abs(F));
F_db = 20*log10(F_normalized);

% Define target dB value
target_db = -3;

% Find ALL indices close to -3 dB (within a small tolerance)
tolerance = 0.1;  % Adjust this value to control how close to -3 dB
indices = find(abs(F_db - target_db) < tolerance);

% Get corresponding theta values in degrees
theta_at_minus3db = theta(indices) * 180/pi;

plot(theta/pi*180, F_db, 'linewidth', 2)
title('1D pattern vs \theta, normalized'); grid on; ylabel('20log10 (abs(F))')

% Print out the -3 dB point values
disp('Theta values at -3 dB:');
for i = 1:length(indices)
    fprintf('Theta = %.4f degrees\n', theta_at_minus3db(i));
end

% Calculate and display the difference between max and min theta values at -3 dB
if length(theta_at_minus3db) > 1
    theta_difference = max(theta_at_minus3db) - min(theta_at_minus3db);
    fprintf('Difference between max and min theta at -3 dB: %.4f degrees\n', theta_difference);
else
    fprintf('Not enough points to calculate difference\n');
end

% Pattern vs \phi in polar coordinates
subplot(2,2,3)
phi =[0: 2*pi/( N_phi-1):2*pi];
theta = pi/2;
F = (cos(k*l*cos(theta))-cos(k*l))./sin(theta)*ones(size(phi));
polar(phi, abs(F))
title('1D pattern vs \phi with \theta=\pi/2'); grid on

% Find peaks in dB scale, with theta as x-axis values
[pks, locs] = findpeaks(F_db, theta * 180/pi);  % locs contains theta values in degrees

% Identify main lobe (highest peak)
[main_lobe_peak, main_index] = max(pks);
main_lobe_theta = locs(main_index);  % Main lobe theta

% Remove the main lobe from consideration
pks(main_index) = [];
locs(main_index) = [];  % locs already contains theta values in degrees

% Define a small tolerance to filter out values too close to the main lobe peak
tolerance = max(eps, 1e-6);  % Use machine epsilon or a small threshold

% Remove any values that are effectively the same as the main lobe peak
valid_indices = abs(pks - main_lobe_peak) > tolerance;
pks = pks(valid_indices);
locs = locs(valid_indices);

% Find the highest remaining peak (side lobe)
if ~isempty(pks)
    [side_lobe_peak, side_index] = max(pks);

    fprintf('Side lobe peak: %.4f dB\n', side_lobe_peak);
else
    fprintf('No side lobe detected.\n');
end
