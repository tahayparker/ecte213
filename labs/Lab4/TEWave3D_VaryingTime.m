TEWave3D_VaryingTime.mfunction TEWave3D_VaryingTime( )
% Function: Animate the TE wave propagation direction at different time
% Input: The width a, the height b, the length c
%        Frequency of the wave: f (Hz)
%        The mode numbers: m, p
%        Dielectrics parameters: epsilon_r, mu_r
%        Amplitude of the H field: H0
%        Time of simulation: e.g., T = [0:0.1/f: 2*1/f]
%        Numbers of grid points in the x, y, z directions: Na, Nb, Nc
%        Pausetime: time interval of displaying results for next time instant

a=0.2; b=0.05; c=0.1;
f=2*10^10;
m=1; p=1;
epsilon_r=1; mu_r=1;
H0=1;
T = [0:0.03/f: 20*1/f];
Na = 20;  Nb = 20;  Nc = 5;
pausetime = 0.5;


%% Compute and simulate the waves
[x,y,z] = ndgrid([0:a/(Na-1):a], [0:b/(Nb-1):b], [0:c/(Nc-1):c]);
Sx = zeros(Na, Nb, Nc);   Sy = zeros(Na, Nb, Nc);  Sz = zeros(Na, Nb, Nc);

for k=1:1:length(T)
    t= T(k);
    [E_x, E_y, E_z, H_x, H_y, H_z] = TEWave3D(epsilon_r,mu_r,H0,m,p,a,b,c, f, t, Na, Nb, Nc);
    for na=1:1:Na
        for nb=1:1:Nb
            for nc=1:1:Nc
                E = [E_x(na,nb,nc) E_y(na,nb,nc) E_z(na,nb,nc)];
                H = [H_x(na,nb,nc) H_y(na,nb,nc) H_z(na,nb,nc)];
                S = cross(E,H);
                S_x(na,nb,nc) = S(1);
                S_y(na,nb,nc) = S(2);
                S_z(na,nb,nc) = S(3);
            end
        end
    end

    subplot(1,2,1);
    quiver3(x,y,z, S_x, S_y ,S_z, 4);
    axis([0 a 0 b 0 c]); xlabel('x'); ylabel('y'); zlabel('z'); title('(S_x, S_y, S_z)');rotate3d on;

    subplot(1,2,2);
    posz = ceil(Nc/2);
    quiver3(x(:,:,posz),y(:,:,posz),z(:,:,posz), S_x(:,:,posz), S_y(:,:,posz) ,S_z(:,:,posz), 4);
    axis([0 a 0 b 0 c]); xlabel('x'); ylabel('y'); zlabel('z'); title(strcat('(S_x, S_y, S_z) at z=',num2str(posz*c/Nc))); rotate3d on;
end
