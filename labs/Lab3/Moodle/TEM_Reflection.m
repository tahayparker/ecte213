function TEM_Reflection( )
%% Function: Simulate the waves with a TEM wave incident on a boundary between two materials 
%            Assuming a TEM wave polarized in the x direction 
%  Parameters: f: frequency in Hz
%              Ex10_incid: amplitude of the incident wave
%              mu_r_1, epsilon_r_1, mu_r_2, epsilon_r_2: relative permittivity and permeability of the materials; assumed real-valued or infinity  
 
%% Set parameters 
f = 1*10^6; 
Ex10_incid = 1; 
 
% Region 1 
mu_r_1 = 1;
epsilon_r_1 = 4;
 
% Region 2 (set eta_2=0 for perfect conductors)
mu_r_2 = 1;
epsilon_r_2 = 16;
 
%% Find wave parameters 
c = 3*10^8;
lambda_0 = c/f; 
[omega,beta_1,lambda_1,T0,eta_1] = losslesspropagation(f,mu_r_1,epsilon_r_1);
[omega,beta_2,lambda_2,T0,eta_2] = losslesspropagation(f,mu_r_2,epsilon_r_2);
 
%% Find reflection and transmission coefficients  
Gamma = (eta_2-eta_1)/(eta_2+eta_1); 
tau = Gamma + 1; 
 
%% Calculate and visualize the Ex components of the waves in the two regions   
dz = lambda_0/100;            
z_1 = [-4*lambda_0:dz:0]';     
z_2 = [0:dz:4*lambda_0]';
T_sim = [0:T0/100:2*T0]; 
 
for n_sim = 1:1:length(T_sim)
    t = T_sim(n_sim); 
    % Total wave in Region 1 
    E_x1 = Ex10_incid*cos(omega*t-beta_1*z_1)+abs(Gamma)*Ex10_incid*cos(omega*t+beta_1*z_1+angle(Gamma));
    % Total wave in Region 2 
    E_x2 = abs(tau)*Ex10_incid*cos(omega*t-beta_2*z_2+angle(tau)); 
    
    % Plot Ex field components 
    subplot(2,1,1)
    plot(z_1,Ex10_incid*cos(omega*t-beta_1*z_1), 'g-.', 'linewidth', 2 );  % Incident wave, Region 1
    hold on
    plot(z_1,abs(Gamma)*Ex10_incid*cos(omega*t+beta_1*z_1+angle(Gamma)), 'k-.', 'linewidth', 2 );   % Reflected wave, Region 1 
    plot(z_1,E_x1,'b', 'linewidth', 2 );    % Total wave, Region 1
    plot(z_2,E_x2, 'r', 'linewidth', 2 ); grid on; axis([min(z_1), max(z_2) -2 2]);  % Total wave, Region 2
    legend('Incident', 'reflected', 'total 1', 'total 2')
   
    title('Ex components')    
    plot([0 0], [-2 2], 'linewidth', 4)
    text(-500,1.5,'Material 1');
    text(500,1.5,'Material 2');
    text(0,1.5,'Incident plane');
    hold off     
    
    % Calculate and plot z-direction component of the Poynting vectors
    % First find all the E and H field components 
    H_y1 = Ex10_incid/eta_1*cos(omega*t-beta_1*z_1)-abs(Gamma)*Ex10_incid/eta_1*cos(omega*t+beta_1*z_1+angle(Gamma));
    E_y1 = zeros(size(z_1));     E_z1 = zeros(size(z_1)); 
    H_x1 = zeros(size(z_1));     H_z1 = zeros(size(z_1));     
 
    H_y2 = Ex10_incid*abs(tau)/eta_2*cos(omega*t-beta_2*z_2+angle(tau));     
    E_y2 = zeros(size(z_2));     E_z2 = zeros(size(z_2)); 
    H_x2 = zeros(size(z_2));     H_z2 = zeros(size(z_2)); 
    
    % Compute the Poynting vector according to definition 
    S_z1=zeros(size(z_1)); S_z2=zeros(size(z_2));    
    subplot(2,1,2)      
    for m=1:1:length(z_1)
        s = cross([E_x1(m) E_y1(m) E_z1(m)], [H_x1(m) H_y1(m) H_z1(m)]); 
        S_z1(m) = s(3); 
    end    
    for m=1:1:length(z_2)
        s = cross([E_x2(m) E_y2(m) E_z2(m)], [H_x2(m) H_y2(m) H_z2(m)]); 
        S_z2(m) = s(3); 
    end
    plot(z_1,S_z1, 'b', 'linewidth', 2 ); grid on;
    hold on 
    plot(z_2,S_z2, 'r', 'linewidth', 2 );  
    title('Sz components')    
    legend('total 1', 'total 2')
    axis([min(z_1), max(z_2) -1.2*max(max(S_z1,S_z2))  1.2*max(max(S_z1,S_z2))]) ;  
    hold off     
    
    pause(0.1)    
end
 
 

