r = 2; theta = 3; phi = 4;
x = [2; 3; 4];
y = [r * sin(theta) * cos(phi); r * sin(theta) * sin(phi); r * cos(theta)];

fprintf("Dot product of x, y and z: ")
dot(x, y)
fprintf("Cross product of x, y and z: ")
cross(x, y)
viewcross(x, y)