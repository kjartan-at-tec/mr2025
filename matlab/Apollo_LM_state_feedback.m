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

% Gains
l0 = J/gM/tauc^3;
l1 = (1+sqrt(2))*J/tauc;
l2 = (1+sqrt(2))*J/tauc^2;
l3 = l0;
L = [l1, l2, l3];

