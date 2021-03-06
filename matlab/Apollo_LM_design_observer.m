%% State-space control of Apollo Lunar module,
% horizontal movement
%
% Kjartan Halvorsen
% July 2020

% Model parameters
J = 2.56e4; %kg*m^2, moment of inertia
gM = 1.62; % m/s^2 gravitational acc on the moon surface


% Closed-loop tuning parameter
tauc = 0.2;

% Gains
l0 = J/gM/tauc^3;
l1 = (1+sqrt(2))*J/tauc;
l2 = (1+sqrt(2))*J/tauc^2;
l3 = l0;
L = [l1, l2, l3];






% Discrete-time model
h = 0.25; % Sampling period, in seconds

Phi = [1, 0 , 0
    h, 1, 0
    h^2*k2/2, h*k2, 1]; % x=[\dot{th}, th, \dot{z}]
Gamma = h*k1*[1;h/2; k2*h^2/6]
C = [0,0,1]; % Velocity control
D = [0]; 

% Check discretization
A = [0, 0, 0
    1, 0, 0
    0, k2, 0];
B = [k1;0;0];
sys_ct = ss(A, B, C, D)
sys_dt = c2d(sys_ct, h)
[Phi_c2d, Gamma_c2d, C_c2d, D_c2d] = ssdata(sys_dt)

% Should be the same:
[Phi, Phi_c2d]

% Desired poles
pd = sqrt(sqrt([0.7, 0.7+0.1j, 0.7-0.1j]));

L_a = acker(Phi, Gamma, pd)
L_p = place(Phi, Gamma, pd) % More accurate, but no repeated poles
L = L_a;

% Find gain l0
Phic = Phi - Gamma*L;
l0 = 1/(C*inv((eye(3)-Phic))*Gamma)

%% Observer design
po = exp(2*log(pd)) % Observer poles twice as fast
po = zeros(1,3) % Dead-beat observer

K_a = (acker(Phi', C', po))'
%K_p = (place(Phi', C', po))'
K = K_a;




