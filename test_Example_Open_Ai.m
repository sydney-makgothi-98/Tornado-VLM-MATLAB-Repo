clc; clear; close all;
syms alpha_e C_tau CD CLT CLW CL

% Given constants
m = 1000; % Mass (example, change as needed)
g = 9.81; % Gravity
rho = 1.225; % Air density (kg/m³)
S = 20; % Wing area (m²)
gamma_e = deg2rad(5); % Example trim angle
kappa = deg2rad(2); % Example thrust angle
Cm0 = -0.02; % Moment coefficient
h = 0.4; % CG position
h0 = 0.25; % Reference CG
VT = 0.1; % Tail volume ratio
a = 5.5; % Lift curve slope
alpha_wr = deg2rad(3); % Wing-root angle
alpha_w0 = deg2rad(2); % Zero-lift AoA
ST = 5; % Tail area
cw = 2; % Mean aerodynamic chord
z_tau = 0.3; % Thrust moment arm
CD0 = 0.02; % Parasitic drag coefficient
K = 0.05; % Drag coefficient factor

% Loop over different velocities
V_values = linspace(50, 200, 10); % V range from 50 to 200 m/s
results = []; % Store results

for i = 1:length(V_values)
    V = V_values(i);

    % Define equations
    eq1 = rho * V^2 * S * sin(alpha_e + gamma_e) == C_tau * cos(kappa) - CD * cos(alpha_e) + CL * sin(alpha_e);
    eq2 = rho * V^2 * S * cos(alpha_e + gamma_e) == CL * cos(alpha_e) + CD * sin(alpha_e) + C_tau * sin(kappa);
    eq3 = 0 == (Cm0 + (h - h0) * CLW) - VT * CLT + C_tau * z_tau / cw;
    eq4 = CL == CLW + (CLT * ST / S);
    eq5 = CD == CD0 + K * CL^2;
    eq6 = CLW == a * (alpha_e + alpha_wr - alpha_w0);

    % Solve for unknowns
    sol = vpasolve([eq1, eq2, eq3, eq4, eq5, eq6], [alpha_e, C_tau, CD, CLT, CLW, CL]);

    % Store results
    results_array = [double(sol.alpha_e), double(sol.C_tau), double(sol.CD), double(sol.CLT), double(sol.CLW), double(sol.CL)];
    results = [results, results_array]
end

% Display results
disp(array2table(results, 'VariableNames', {'alpha_e', 'C_tau', 'CD', 'CLT', 'CLW', 'CL'}, 'RowNames', string(V_values)));
