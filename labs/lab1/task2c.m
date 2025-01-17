% Define physical constants and charge parameters
Q0 = -1;                              % Charge magnitude (-1 C)
Q1 = 1;                               % Charge magnitude (1 C)
epsilon0 = 8.85e-12;                  % Permittivity of free space (F/m)
k0 = Q0 / (4 * pi * epsilon0);        % Coulomb's constant times charge
k1 = Q1 / (4 * pi * epsilon0);        % Coulomb's constant times charge

% Charge positions
x0 = -1;  y0 = 0;  z0 = 0;           % First charge at (-1,0,0)
x1 = 1;   y1 = 0;  z1 = 0;           % Second charge at (1,0,0)

% Create a 3D grid for field calculation
gx = -5:0.5:5;                        % X grid points from -5 to 5 with step 0.5
gy = -5:0.6:5;                        % Y grid points from -5 to 5 with step 0.6
gz = -5:0.6:5;                        % Z grid points from -5 to 5 with step 0.6
[x, y, z] = meshgrid(gx, gy, gz);     % Create 3D grid matrices

% Compute distances from each charge
r0 = sqrt((x - x0).^2 + (y - y0).^2 + (z - z0).^2);    % Distance from charge 1
r1 = sqrt((x - x1).^2 + (y - y1).^2 + (z - z1).^2);    % Distance from charge 2

% Compute electric potential from each charge
V0 = k0 ./ r0;                        % Potential due to charge 1
V1 = k1 ./ r1;                        % Potential due to charge 2
V_total = V0 + V1;                    % Superposition principle: total potential

% Compute electric field components using the negative gradient of V_total
[Ex, Ey, Ez] = gradient(-V_total, 0.5, 0.6, 0.6);

% Find the index where x = 0
lengthg = length(gx);
pos_0 = (lengthg + 1) / 2;           % Middle index for x = 0 plane

% === 3D Visualization: Potential Slices and Full Electric Field ===
figure(1)
quiver3(x(:, pos_0, :), y(:, pos_0, :), z(:, pos_0, :), ...
        Ex(:, pos_0, :), Ey(:, pos_0, :), Ez(:, pos_0, :), ...
        1.5, 'r', 'linewidth', 1.5);
xlim([-3,3]); ylim([-3,3]); zlim([-3,3]);
xlabel('x'); ylabel('y'); zlabel('z');
title('Electric Field and Potential (y-z plane slice at x=0)');
grid on;