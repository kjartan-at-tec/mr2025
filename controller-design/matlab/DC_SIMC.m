%% Parameters for a joint of a robotic arm
% Based on data for ABB IRB 7600

J = 50*1.5^2; % Moment of inertia
gr = 200; % Gear ratio
Vmax = 400; % Volt
speed_max = 120; % Degrees per second, typical, so inferring:
k = Vmax / gr / (speed_max*pi/180) % The motor constant
R = 5; % Armature resistance. 
L = 4e-3; % Armature inductance. 
b = 20; % Friction Nm/(rad/s) for ang velocity of arm.

k1 = 1/( gr*k + b*R/(gr*k))
taudc = J/((gr*k)^2/R + b)


%% SIMC rules, second-order system with one pole in the origin and deadtime
tauc = taudc;
theta = 0; % No deadtime

% Implement the code to calculate the SIMC controller gains below:
