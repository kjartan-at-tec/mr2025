%% Inverted pendulum, PD control

s = tf('s');

G = 1/(s+1)/(s-1)

F = 2*s+1;

figure(1)
clf
rlocus(G*F);

figure(2)
clf
step(feedback(100*G*F, 1))
