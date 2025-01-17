r = 2; theta = 3; phi = 4;
x = [2; 3; 4];
y = [r * sin(theta) * cos(phi); r * sin(theta) * sin(phi); r * cos(theta)];

dot(x, y)
cross(x, y)

viewcross(x, y)