%% Parameters for the twin DC motors driving the same load
% Based on data for Maxon DCX L 26mm 40W 36V

Pnom = 40;
Vnom = 36;
Inom = 1.79;
Imax = 2*Inom;
Vmax = 1.5*Vnom;

R = 1.75; % Armature resistance 
L = 0.268e-3 % Armature inductance

RPM_no_load = 11100; 
w_no_load = RPM_no_load*2*pi/60; % rad/s
k = Vnom / w_no_load % The motor constant
k_from_datasheet = 31e-3 %
gr = 1024; % Gear ratio

rotor_inertia = 19.4; % gcm^2
J_rotor = rotor_inertia / 1000 / 100^2;
m_rover = 1000/3; % Two motors only driving one third of the mass.
r_wheel = 0.25;
J = J_rotor * (gr)^2 + m_rover*r_wheel^2; % Moment of inertia

tau_i_cc = 0.1;
k_cc = 25;