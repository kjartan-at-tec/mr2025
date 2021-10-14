%% State-space control of Apollo Lunar module,
% horizontal movement
%
% Kjartan Halvorsen
% October 2021

% Model parameters
J = 2.56e4; %kg*m^2, moment of inertia
gM = 1.62; % m/s^2 gravitational acc on the moon surface


% Closed-loop tuning parameter
tauc = 1;

% Reference gain
l0 = J/gM/tauc^3;

% State feedback gains
l1 = (1+sqrt(2))*J/tauc;
l2 = (1+sqrt(2))*J/tauc^2;
l3 = l0;
L = [l1, l2, l3];

%% Observer
% Separation between poles 
n = 2; % Between 2-10

% Observer gains
k1 = n^3/tauc^3/gM;
k2 = (1+sqrt(2))*n^2/tauc^2/gM;
k3 = (1+sqrt(2))*n/tauc;

K = [k1;k2;k3];

A = [0 0 0
    1 0 0
    0 gM 0];
B = [1/J;0;0];
C = [0, 0, 1];

