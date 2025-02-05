function TEM_Polarized( )
 
%% Function: Simulate polarized TEM waves  
%  Parameters: f: frequency in Hz
%              Ex0: amplitude of Ex component 
%              Ey0: amplitude of Ey component 
%              phi: phase difference between the Ex and Ey components  
%              mu_r, epsilon_r: relative permittivity and permeability of the material 
%              t: time of interest  
 
%% Initialize parameters 
Ex0 = 1; 
Ey0 = 2; 
phi = -pi/2; 

% The type is elliptical

f = 10^6;
omega = 2*pi*f;
T = 2*pi/omega;
t = 2*T/15; 
 
epsilon_r = 4; 
mu_r = 1; 
 
%% Wave parameters 
c = 3*10^8;
k = omega*sqrt(mu_r*epsilon_r);      % Propagation constant 
alpha = -imag(k);                               % Attenuation constant 
beta = real(k);                                    % Phase constant 
lambda = 2*pi/beta;
V_p = c/sqrt(mu_r*epsilon_r);        % Phase velocity  
eta=377*sqrt(mu_r/epsilon_r);        % Wave impedance 
scaleH = abs(eta);                             % Only for visualization          
 
%% Compute and plot the field components  
z=[0:lambda/20:4*lambda]';                                               % Grid points on z axis 
Ex=zeros(size(z)); Ey=zeros(size(z)); Ez=zeros(size(z));    % Initialization 
Sx=zeros(size(z)); Sy=zeros(size(z)); Sz=zeros(size(z));
Ex = Ex0*exp(-alpha*z).*cos(omega*t-beta*z);                    % Ex component 
Hy = Ex0/eta*exp(-alpha*z).*cos(omega*t-beta*z);             % Hy component 
Ey = Ey0*exp(-alpha*z).*cos(omega*t-beta*z+phi);            % Ey component    
Hx = -Ey0/eta*exp(-alpha*z).*cos(omega*t-beta*z+phi);    % Hx component 
 
Sz = 1/eta*(abs(Ex.^2)+abs(Ey.^2));                                  % Power density 
figure('units','normalized','outerposition',[0 0 1 1])
 
subplot(3,4,[1,2,5,6,9,10]);
plot3(z, Ex, Ey,'r', 'linewidth',2)                                     % Plot the E field using plot3  
hold on 
plot3(z, scaleH*Hx, scaleH*Hy,'b', 'linewidth',2)           % Plot the H field using plot3 with scaling   
hold on 
% arrow3([z zeros(size(z)) zeros(size(z)) ], [z Ex Ey ])       % Plot the E field using arrow3   
% arrow3([z zeros(size(z)) zeros(size(z)) ], [z scaleH*Hx scaleH*Hy ]) % Plot the H field using arrow3 with scaling 
legend('E field', 'H field'); grid on; xlabel('z'); ylabel('x'); zlabel('y')
 
subplot(3,4,3);plot(z, Ex, 'r', 'linewidth',2); ylabel('Ex')                % Plot Ex only  
subplot(3,4,7);plot(z, Ey, 'r','linewidth',2); ylabel('Ey')                 % Plot Ey only 
subplot(3,4,11);plot(Ex, Ey, 'r', 'linewidth',2); xlabel('Ex'); ylabel('Ey') % Plot (Ex, Ey) to see the polarization type  
subplot(3,4,4);plot(z, scaleH*Hx, 'linewidth',2); ylabel('Hx');       % Plot Hx only with scaling   
subplot(3,4,8);plot(z, scaleH*Hy, 'linewidth',2); ylabel('Hy');      % Plot Hy only with scaling 
subplot(3,4,12);plot(Hx, Hy, 'linewidth',2); xlabel('Hx'); ylabel('Hy')% Plot (Hx, Hy) to see the polarization type 