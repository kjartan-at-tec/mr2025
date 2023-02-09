%% Parameters for AC generator simulation
% Reasonable values for a 1MW generator

P = 1e6; % 1MW power output
w_g = 60*2*pi; % Grid angular velocity in rad/s
J_gen = 150; % [kg m^2] Moment of inertia
K_gen = P/w_g/sind(30) % Nominal torque generated at 30 degree relative phase
eff = 40/100; % Efficiency
f_gen = (1-eff)*P/w_g/w_g %[Nm/rad/s] Friction coefficient
