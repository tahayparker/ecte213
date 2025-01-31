% Use FDM to solve the 2D Laplace's equation with Dirichlet-type boundary
% conditions 
% Requirements: 1. The geometry of the region (simplest case: square) 
%               2. The boundry condition
% Steps: 1. meshing the region
%        2. derive the coefficient matrix: A
%        3. derive the input vector: b=[Vl+Vu;Vu+Vr;Vb+Vl;Vb+Vr]
%        4. solving the linear equations: V=A^(-1)b
%--------------------------------------------------------------------
% Plot the region: 3x3 square region
clear
clc
% Boundary conditions
%___________
Vu=100;
Vl=50;
Vb=10;
Vr=30;
%%
%The following code is to animate the process of setting the grid points 
x=[0,1,2,3];
x_u=[0.1,1,2,2.9];
y=[0,1,2,3];
figure(1)
plot(x,zeros(1,4),'r') % plot y=0;
strb={'Vb=',Vb};
text([1,1.35],[-0.2,-0.2],strb)
hold on
plot(zeros(1,4),y,'r') % plot x=0;
strl={'Vl=',Vl};
text([-0.7,-0.35],[1.5,1.5],strl)
hold on
plot(x_u,3*ones(1,4),'r') % plot y=3;
stru={'Vu=',Vu};
text([1,1.35],[3.2,3.2],stru)
hold on
plot(3*ones(1,4),y,'r')% plot x=3;
strr={'Vr=',Vr};
text([3.1,3.45],[1.5,1.5],strr)
hold on
axis([-2 5 -2 5])
pause(2)
%%
% plot the meshing grid (3x3 meshing grids)
plot(x(2)*ones(1,4),y,'b') % plot x=1;
hold on
pause(2)
plot(x(3)*ones(1,4),y,'b') % plot x=2;
hold on
pause(2)
plot(x,y(2)*ones(1,4),'b') % plot y=1;
points34={'V3','V4'};
text([1.1,2.1],[0.8,0.8],points34)
hold on
pause(2)
plot(x,y(3)*ones(1,4),'b') % plot y=2;
points12={'V1','V2'};
text([1.1,2.1],[1.8,1.8],points12)

%%
% One must find the A matrix and b vector by analyzing the problem and generate the coefficient matrix
A=[4,-1,-1,0;-1,4,0,-1;-1,0,4,-1;0,-1,-1,4];
b=[Vl+Vu;Vu+Vr;Vb+Vl;Vb+Vr];

%%
% Solve the linear equation to find the unknown potentials
V=A\b;

%%
% To display the calculated potentials 
xtext=[-0.5,-0.15,0.65,1,1.8,2.15,2.95,3.3];
ytext=[-1,-1,-1,-1,-1,-1,-1,-1];
str={'V1=',V(1),'V2=',V(1),'V3=',V(3),'V4=',V(4)};
text(xtext,ytext,str)




 