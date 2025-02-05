[omega,beta,lambda,T,eta]=losslesspropagation(1E8,1,4)
scaleH = eta; 


t = T/10; 
z=[0:lambda/20:4*lambda]';
Ex=zeros(size(z)); Ey=zeros(size(z)); Ez=zeros(size(z));
Hx=zeros(size(z)); Hy=zeros(size(z)); Hz=zeros(size(z));
Sx=zeros(size(z)); Sy=zeros(size(z)); Sz=zeros(size(z));
E0=0.0001; 
Ex = E0*cos(omega*t-beta*z);
Hy= E0/eta*cos(omega*t-beta*z);
 
Sz = 1/eta*Ex.^2; 
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,[1,2,5,6,9,10]);
plot3(z, Ex, Ey,'r', 'linewidth',2) 
hold on 
plot3(z, scaleH*Hx, scaleH*Hy,'b', 'linewidth',2) 
hold on 
arrow3([z zeros(size(z)) zeros(size(z)) ], [z Ex Ey ])
arrow3([z zeros(size(z)) zeros(size(z)) ], [z scaleH*Hx scaleH*Hy ])
legend('E field', 'H field'); grid on; xlabel('z'); ylabel('x'); zlabel('y')
 % alternative 
 
subplot(3,4,3);plot(z, Ex, 'linewidth',2); ylabel('Ex')
subplot(3,4,7);plot(z, Ey, 'linewidth',2); ylabel('Ey')
subplot(3,4,11);plot(z, Ez, 'linewidth',2); xlabel('z'); ylabel('Ez')
subplot(3,4,4);plot(z, scaleH*Hx, 'linewidth',2); ylabel('Hx'); 
subplot(3,4,8);plot(z, scaleH*Hy, 'linewidth',2); ylabel('Hy'); 
subplot(3,4,12);plot(z, scaleH*Hz, 'linewidth',2); xlabel('z'); ylabel('Hz')

