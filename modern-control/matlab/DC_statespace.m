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


%% For comparison: SIMC rules, second-order system with one pole in the origin and deadtime
tauc = taudc;
theta = 0; % No deadtime

tau2 = taudc;
tauD = tau2;
tauI = 4*(tauc + theta);
Kc = 1/(k1*(tauc+theta));

%% State feedback design
% dw/dt = 1/J ( k*gr/R) (u - k*gr*w) - bw -Tl )
% dtheta/dt = w
% x = [w;theta]
A = [ -(k*gr)^2/(J*R)-b/J, 0
    1, 0]
B = [k*gr/(J*R)
    0]
C = [0, 1];
D = [0];

plant_ss = ss(A, B, C, D);

% Desired poles
pd = [pole_one, pole_two] % Your choice of closed-loop poles goes here

Lv = place(A, B, pd)
cl_ss = ss(A-B*Lv, B, C, D);

l_0 = 1.0/dcgain(cl_ss) % This will make sure the static gain is 1.



