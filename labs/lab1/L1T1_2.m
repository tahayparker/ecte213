% Define the grid space for the vector field
gx = -20:1:20;  % X-axis range
gy = -40:1:40;  % Y-axis range
[x, y] = meshgrid(gx, gy);  % Create a 2D grid of x and y values

% Define the vector field components
g_x = cos(0.1 * pi * x);  % x-component of the vector field
g_y = cos(0.1 * pi * y);  % y-component of the vector field

% Compute the divergence of the vector field
div_g = divergence(x, y, g_x, g_y);

% Plot the vector field using quiver
figure; % Create a new figure window
quiver(x, y, g_x, g_y, 'b'); % Quiver plot for vector field (blue arrows)
hold on; % Hold the current plot for overlaying additional plots
contour(x, y, div_g); % Contour plot for divergence
hold off; % Release the current plot

% Formatting the plot
title('Vector Field g(x, y) and its Divergence');
axis equal; % Maintain aspect ratio
grid on; % Add grid for clarity