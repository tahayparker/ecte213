x0 = -1; y0 = 0; z0 = 0;    % Position of first charge at (-1,0,0)
x1 = 1;  y1 = 0; z1 = 0;    % Position of second charge at (1,0,0)
epsilon0 = 8.85e-12;        % Permittivity of free space (F/m)
k = Q/(4*pi*epsilon0);      % Calculate Coulomb's constant times charge (N⋅m²/C)

r0 = sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2);  % Distance from first charge
r1 = sqrt((x-x1).^2 + (y-y1).^2 + (z-z1).^2);  % Distance from second charge

V0 = k * (1./r0);           % Potential due to first charge
V1 = k * (1./r1);           % Potential due to second charge