%% Testing the rescaling of the normalized DC motor
% Kjartan Halvorsen
% 2022-09-29

tau = 0.1;
k = 200;
s = tf('s');

% In normalized time and angle-unit

Gn = 1/(s + 1) * 1/s;
Fn = 2.24 * (s+1)/(0.25*s + 1);
Gcn = feedback(Fn*Gn, 1);
[yn, tn] = step(Gcn);

% In regular (SI) unit time and angle in rad
G = k/(tau*s+1) * 1/s;
F = (2.24/(k*tau)) * (s*tau+1)/(0.25*s*tau + 1);
Gc = feedback(F*G, 1);
[y, t] = step(Gc);

figure(1)
clf
plot(t, y, 'r:', tn*tau+0.01, yn, 'b')


% Prop control

Kpn = 1;
Kp = Kpn/(k*tau);

[yn, tn] = step(feedback(Kpn*Gn, 1));
[y, t] = step(feedback(Kp*G, 1));
figure(2)
clf
plot(t, y, 'r:', tn*tau+0.01, yn, 'b')
