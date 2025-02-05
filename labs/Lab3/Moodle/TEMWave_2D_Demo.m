function TEMWave_2D_Demo( ) 
% Function: Animate the field distribution of a TEM wave on a x-y plane with z fixed     
% Parameters:   f: frequency in Hz
%               mu_r: relative permeability 
%               epsilon_r: relative permittivity 
%               z: z coordinate defining the x-y plane of interest   
%               T: time instants at which the fields are evaluated 
%               pausetime: time duration for displaying for each time instant  
 
%% Initilization 
f = 2*10^10; epsilon_r = 4; mu_r =1;  
T = [0:0.01/f: 20/f];   % Time instants at which the fields are evaluated  
pausetime = 0.1;        % Increase to slow down the animation 
[omega,beta,lambda,T_wave,eta]=losslesspropagation(f, mu_r,epsilon_r);  % Find wave parameters 
z = lambda/4;           % Set the z coordinate to a quarter of the wavelength 
 
%% The next three lines are used to generate grid points on the x-y plane with z fixed   
a = lambda; b = lambda;   
Na = 20;  Nb = 20;
[x,y] = meshgrid([0:a/(Na-1):a], [0:b/(Nb-1):b]); 
 
%% Parameter for scaling the H field components in plots to account for the much smaller values of the H field quantities 
scaleH = eta; 
 
%% Animation produced by computing the field distributions for a sequence of time instants specified by T 
for k=1:1:length(T) 
    t= T(k); 
    [E_x, E_y, E_z, H_x, H_y, H_z] = TEM_2D(epsilon_r, mu_r, a, b, z, f, t, Na, Nb); % Calculate the field quanties with given parameters, space area and time 
    subplot(2,2,1); quiver(x,y,E_x, E_y );  % Plot electric field intensity lines in the x-y plane 
    axis([0 a 0 b]); xlabel('x'); ylabel('y'); title('(E_x, E_y)')
    subplot(2,2,3); surf(x,y, sqrt(abs(E_x.^2)+abs(E_y.^2)+abs(E_z.^2))) % Plot the magnetitude of the electric field intensity in the x-y plane  
    title('|E|');  rotate3d on;xlabel('x'); ylabel('y');  
    subplot(2,2,2); quiver(x,y,H_x, H_y, 2 ) % Plot magnetic field intensity lines in the x-y plane
    axis([0 a 0 b]); xlabel('x'); ylabel('y'); title('(H_x, H_y)')
    subplot(2,2,4); surf(x,y, scaleH* sqrt(abs(H_x.^2)+abs(H_y.^2)+abs(H_z.^2)))  % Plot the magnitude of the magnetic field intensity in the x-y plane  
    title('|H|'); rotate3d on;xlabel('x'); ylabel('y');       
    pause(pausetime)
end