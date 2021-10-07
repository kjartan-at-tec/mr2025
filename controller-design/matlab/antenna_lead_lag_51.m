% Bode diagram for 5.1
clear all
close all

s = tf('s');
Gh = 10/(s*(s+10));
Gac = 10/(s*(s+1));
Gt = 1.2*s/(s+8);

G = Gh * feedback(Gac, Gt);

Gacf = feedback(Gac, Gt);

evalfr(G, i)

figure(1)
clf
bode(G, {0.1, 10})
set(gcf, 'Position', [100,100, 600, 400])
grid on
fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14)
set( findall(fh, '-property', 'linewidth'), 'linewidth', 2)


print -dpdf 5_1-bode.pdf

figure(2)
clf
nyqlog(G)
print -dpdf 5_1-nyqlog.pdf

figure(3)
clf
nyquist(G)
ylim([-4,4])
xlim([-7,1])

print -dpdf 5_1-nyquist.pdf


%% Controller design

% Specifications
w_c = 1;
ess = 0.1;


% Lead design
alpha_d = 35.7;
Td = 1/(w_c*sqrt(alpha_d))
K = 1/abs(evalfr(G, i*w_c))/sqrt(alpha_d)
T_i = 1/(w_c*0.1) % rule-of-thumb

F_lead =(alpha_d*Td*s + 1)/(Td*s+1);
F_lag = (T_i*s+1)/(T_i*s);
F = K * F_lead * F_lag

% Alternative Flag for requirement e_ss < 0.1.
% Need F(0) = 10.
alpha_i = K/10;
T_i2 = 10/(w_c*alpha_i) % rule-of-t
F_lag2 = 1/alpha_i * (alpha_i*T_i2*s + 1) / (T_i2*s+1);
F2 = K*F_lead*F_lag2;

% Bode diagram of lead- and lag filter
figure(3)
clf
bode(F_lead, F_lag, F_lag2)


% Stability margins 
figure(4)
clf
margin(G*F)

% Stability margins 
figure(5)
clf
margin(G*F2)

% Pole-zero map and  step of closed-loop system
Gc = feedback(G*F, 1);
Gc2 = feedback(G*F2, 1);
figure(6)
clf
set(gcf, 'Position', [100, 100, 800 400])
subplot(1,2,1)
pzmap(Gc, Gc2)
subplot(1,2,2)
step(Gc, Gc2)

% Step from disturbance d
Gcd = feedback(Gacf*Gh, F);
Gcd2 = feedback(Gacf*Gh, F2);

figure(7)
step(Gcd, Gcd2)
legend('With integrating lag filter', 'With regular lag filter')
