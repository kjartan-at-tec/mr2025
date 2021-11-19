%% Hard disk drive arm

J = 6e-6;
h = sqrt(J)
z = tf('z', h);
H = (z+1)/(2*(z-1)^2) % Double integrator in discrete time
Fb = (z-0.8)/z


figure(1)
clf
rlocus(Fb*H)

K=0.6;
Ff = 0.2*K;
Hc = Ff*feedback(H, K*Fb)
figure(2)
hold on
step(Hc)
