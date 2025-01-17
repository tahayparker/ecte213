function viewcross(A,B)
% Function: visualize the cross products of two vectors A and B in the 3D
%                  space
% Input:  A and B, 3 x 1 vectors in rectangular coordinates 

A_B=cross(A,B);         % Compute the cross product of A and B 
B_A=cross(B,A);         % Compute the cross product of B and A 
quiver3(0,0,0,A(1),A(2),A(3),'linewidth',2,'MaxHeadSize',0.5)   % Use quiver3 to plot A  
hold on
quiver3(0,0,0,B(1),B(2),B(3),'linewidth',2,'MaxHeadSize',0.5)    % Use quiver3 to plot B  
quiver3(0,0,0,A_B(1),A_B(2),A_B(3),'linewidth',2,'MaxHeadSize',0.5) % Use quiver3 to plot AxB  
quiver3(0,0,0,B_A(1),B_A(2),B_A(3),'linewidth',2,'MaxHeadSize',0.5) % Use quiver3 to plot BxA 
view([-10,16])
legend('A','B','AxB','BxA')
xlabel('X'); ylabel('Y'); zlabel('Z')
hold off
