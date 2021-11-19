%% State-space control of Apollo Lunar module,
% horizontal movement
%
% Kjartan Halvorsen
% October 2021

% Model parameters
J = 2.56e4; %kg*m^2, moment of inertia
gM = 1.62; % m/s^2 gravitational acc on the moon surface


% Closed-loop tuning parameter
tauc = 1.2;

% Gains
l0 = J/gM/tauc^3;
l1 = (1+sqrt(2))*J/tauc;
l2 = (1+sqrt(2))*J/tauc^2;
l3 = l0;
L = [l1, l2, l3]

%% Calculated using matlab's place function
A = [0, 0, 0
    1, 0, 0
    0, gM, 0];
B = [1/J
    0
    0]
rank([B, A*B, A*A*B]) == 3

pd = 1/tauc * [-1, 1/sqrt(2) * (-1 + 1j), 1/sqrt(2) * (-1 - 1j)];
Lp = place(A, B, pd)

%% Discrete controller
h = 0.5;
