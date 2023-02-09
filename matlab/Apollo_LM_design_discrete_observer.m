%% Discrete State-space control of Apollo Lunar module,
% horizontal movement
%
% Kjartan Halvorsen
% November 2022

% Model parameters
J = 2.56e4; %kg*m^2, moment of inertia
gM = 1.62; % m/s^2 gravitational acc on the moon surface

s = tf('s');
G = (gM/J) / s^3;

h = 0.2; % Sampling period, in seconds
H = c2d(G, h)

pole(H)
dcgain(H)



% Discrete-time model

A = [3, 1, 0
    -3, 0, 1
    1, 0, 0];
B = (gM*h^3)/(6*J) * [1;4;1];

C = [1, 0, 0];

sys = ss(A, B, C, 0, h);
pole(sys)
dcgain(sys)



% Performance requirements
t_s = 8; % Settling time
PO = 15; % Percent overshoot

% Using these to place two dominant poles in cont time

% Settling time t_s  => use t_s = 4/(zeta*w_n)
zeta_w_n = 4/t_s;

% PO  => zeta 
zeta = sqrt((log(PO/100))^2 / (pi^2 + (log(PO/100))^2));
w_n = zeta_w_n / zeta;

p1 = -zeta_w_n + 1j*w_n*sqrt(1-zeta^2);
p2 = conj(p1)
p3 = -zeta_w_n * 5; % Making this pole non-dominant

% Desired poles
pc = [p1, p2, p3];

pd = exp(pc*h);

L = place(A, B, pd); 

% Find gain l0
sys_c = ss(A-B*L, B, C, 0, h);
l0 = 1/dcgain(sys_c);

sys_c = ss(A-B*L, l0*B, C, 0, h);

figure(1)
clf
step(sys_c)

%% Observer design
po2 = pd.^2
po10 = [0,0,0]

K2 = place(A',  C', po2)';
K10 = place(A', C', po10)';

gainvectors = [K2, K10]


