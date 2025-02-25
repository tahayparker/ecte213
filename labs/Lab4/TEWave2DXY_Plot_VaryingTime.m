function TEWave2DXY_Plot_VaryingTime(epsilon_r,mu_r,H0,m,p,a,b,z,f,t)
% Function: Animate the field components for a plane with z fixed and time varying  
% Input:    Parameters are same as for TEWave2DXY 
epsilon_r=1; mu_r =1; H0=1; m=2; p=1; a=0.1; b=0.05; f=2.0*10^10; z=0.1;
T = [0:0.003/f: 0.3*1/f]; 
pausetime = 1;  

Na = 40;  Nb = 40;
[x,y] = meshgrid([0:a/(Na-1):a], [0:b/(Nb-1):b]); 
[E_x1,E_y1]=meshgrid([0:2*a/(Na-1):2*a], [0:3*b/(Nb-1):3*b]);
for k=1:1:length(T) 
    t= T(k); 
    [E_x, E_y, E_z, H_x, H_y, H_z]=TEWave2DXY(epsilon_r,mu_r,H0,m,p,a,b,z,f,t,Na,Nb); 
    subplot(3,2,1); quiver(x,y,E_x/100000, E_y/100000,0 );                  % The scaling factor 100000 is used for better visualization  
    axis([0 a 0 b]); xlabel('x'); ylabel('y'); title('(E_x, E_y)')
    subplot(3,2,3); surf(x,y, E_z); 
    title('E_z');xlabel('x'); ylabel('y');  
    subplot(3,2,5); surf(x,y, sqrt(abs(E_x.^2)+abs(E_y.^2)+abs(E_z.^2)))
    title('|E|');  rotate3d on;xlabel('x'); ylabel('y');  
    subplot(3,2,2); quiver(x,y,H_x/1000, H_y/1000, 0 )                      % The scaling factor 1000 is used for better visualization
    axis([0 a 0 b]); xlabel('x'); ylabel('y'); title('(H_x, H_y)')
    subplot(3,2,4); surf(x,y, H_z)
    title('H_z');xlabel('x'); ylabel('y');   
    subplot(3,2,6); surf(x,y, sqrt(abs(H_x.^2)+abs(H_y.^2)+abs(H_z.^2)))
    title('|H|'); rotate3d on;xlabel('x'); ylabel('y'); 
    pause(pausetime)
end

 



