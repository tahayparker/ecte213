A = [
    4, -1, 0, -1, 0, 0, 0, 0, 0;
    -1, 4, -1, 0, -1, 0, 0, 0, 0;
    0, -1, 4, 0, 0, -1, 0, 0, 0;
    -1, 0, 0, 4, -1, 0, -1, 0, 0;
    0, -1, 0, -1, 4, -1, 0, -1, 0;
    0, 0, -1, 0, -1, 4, 0, 0, -1;
    0, 0, 0, -1, 0, 0, 4, -1, 0;
    0, 0, 0, 0, -1, 0, -1, 4, -1;
    0, 0, 0, 0, 0, -1, 0, -1, 4
];

B = [150; 100; 130; 50; 0; 30; 60; 10; 40];

x = inv(A) * B;

for i = 1:9
    fprintf('V%d = %f V\n', i, x(i));
end