function TEM_Lossy()
% Function: Demonstrate the TEM wave is a lossy medium
% Parameters:
%          f: frequency in Hz
%          epsilon_r: relative permittivity
%          mu_r: relative permeability
%          t: time of interest            
%          E0: peak amplitude of the electric field intensity  

%% Set the frequency and medium parameters 
f = 100^6;
omega = 2*pi*f;
T = 2*pi/omega;
t = T/15; 
epsilon_r =50-10j; 
mu_r = 1; 
E0 = 0.0001; 

%% Compute wave parameters 
c = 3*10^8;
k = omega*sqrt(mu_r*epsilon_r);
alpha = -imag(k); 
beta = real(k); 
V_p = c/sqrt(mu_r*epsilon_r);
lambda = 2*pi/beta;
eta = 377*sqrt(mu_r/epsilon_r);
scaleH = abs(eta); 

%% Compute field distributions 
z = [0:lambda/20:10*lambda]';
Ex=zeros(size(z)); Ey=zeros(size(z)); Ez=zeros(size(z));
Hx=zeros(size(z)); Hy=zeros(size(z)); Hz=zeros(size(z));
Sx=zeros(size(z)); Sy=zeros(size(z)); Sz=zeros(size(z));
Ex = E0*exp(-alpha*z).*cos(omega*t-beta*z);
Hy= E0./abs(eta)*exp(-alpha*z).*cos(omega*t-beta*z-angle(eta)); 
Sz = 1/eta*Ex.^2; 

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,[1,2,5,6,9,10]);
plot3(z, Ex, Ey,'r', 'linewidth',2) 
hold on 
plot3(z, scaleH*Hx, scaleH*Hy,'b', 'linewidth',2) 
hold on 
% arrow3([z zeros(size(z)) zeros(size(z)) ], [z Ex Ey ])
% arrow3([z zeros(size(z)) zeros(size(z)) ], [z scaleH*Hx scaleH*Hy ])
legend('E field', 'H field'); grid on; xlabel('z'); ylabel('x'); zlabel('y')
subplot(3,4,3);plot(z, Ex, 'linewidth',2); ylabel('Ex')
subplot(3,4,7);plot(z, Ey, 'linewidth',2); ylabel('Ey')
subplot(3,4,11);plot(z, Ez, 'linewidth',2); xlabel('z'); ylabel('Ez')
subplot(3,4,4);plot(z, scaleH*Hx, 'linewidth',2); ylabel('Hx'); 
subplot(3,4,8);plot(z, scaleH*Hy, 'linewidth',2); ylabel('Hy'); 
subplot(3,4,12);plot(z, scaleH*Hz, 'linewidth',2); xlabel('z'); ylabel('Hz')