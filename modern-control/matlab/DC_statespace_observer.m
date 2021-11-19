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
tauc=0.06;

pd = 1/tauc * [-1 + 1j; -1 - 1j]

Lv = acker(A, B, pd)
cl_ss = ss(A-B*Lv, B, C, D);

l_0 = 1.0/dcgain(cl_ss)


%% Observer design
d=2;
d=7
%d=400


lb = Lv*B
pd_obs = lb*(1+sqrt(2))*ones(2,1);
pd_obs = lb*4*ones(2,1);

%pd_obs = d*pd;

%k1 = 
%k2 = 
K = acker(A', C', pd_obs)'

% Check calculations
cat(2, pd_obs, eigs(A-K*C));

Lv*inv(A-K*C)*B

a = -A(1,1)
b = B(1,1)
l1 = Lv(1);
l2 = Lv(2);
k1 = b*l2/(2-b*l1/a)
k2=k1/a
K=[k1;k2]
Lv*inv(A-K*C)*B
