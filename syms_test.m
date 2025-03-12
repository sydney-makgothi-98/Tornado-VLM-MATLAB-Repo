syms x y z d 


x_array = [];
y_array = [];
z_array = [];

% Solving simultaneous equtaions for various values of d
for d = 1:10
eqn_1 = x + y +z +d ;
[x_val,y_val,z_val] = solve(eqn_1 == 1,2*x + 3*y + 5*z +d == -5, 4*x + 2*y + 6*z +d == 2);
x_array = [x_val, x_array];
y_array = [y_val, y_array];
z_array = [z_val, z_array];
end

disp(x_array)

