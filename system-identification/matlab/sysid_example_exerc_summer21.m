%% System identification example and exercise MR2007 Summer 2021
% Kjartan Halvorsen

s = tf('s');
omega = 1;
zeta = 0.4;
G = omega^2/(s^2 + 2*zeta*omega*s + omega^2);
G1 = (s+1)/(2*s+1);
h = 0.3;

Gd = c2d(G, h);
[num, den] = tfdata(Gd)
disp('True model')
Gd

He = tf([1, 0, 0], den{1}, h)


% Generate identification data
sigma = 0.02;
N = 400;
uu = 2*( -0.5 + randi([0,1], 1, N) );
u = cat(1, uu, uu);
u = u(:);
e = sigma*randn(size(u));

y = lsim(Gd, u) + lsim(He, e);
yoe = lsim(Gd, u) + e;

dta = iddata(y, u, h);
dta_oe = iddata(yoe, u, h);

figure(1)
clf
subplot(211)
stairs(u)
hold on
stairs(e)
subplot(212)
stairs(y)
hold on
stairs(yoe)

% Generate validation sequence
uu = 2*( -0.5 + randi([0,1], 1, N) );
uv = cat(1, uu, uu);
uv = uv(:);
ev = sigma*randn(size(uv));

yv = lsim(Gd, uv) + lsim(He, ev);
yvoe = lsim(Gd, uv) + ev;

figure(2)
clf
subplot(211)
stairs(uv)
hold on
stairs(ev)
subplot(212)
stairs(yv)
hold on
stairs(yvoe)

dtav = iddata(yv, uv, h);
dta_oe_v = iddata(yvoe, uv, h);


%% Estimate first-order model (q + a_1) y(k) = (b_0q + b_1) q^{-1} u(k) + qe(k)
% \hat{y}(k+1) = -a_1y(k) +  b_0u(k) + b_1u(k-1) 
%              = [-y(k) u(k) u(k-1) ] * [a_1; b_0; b_1]
n = 1;
m = 1;
d = 1;

sys = arx(dta, [n, m, d])
sysoe = oe(dta_oe, [n, m, d])

compare(dtav, sys, sysoe)

%[sys1, resid1, resval1, rms1, fit1] = estimate_arx(u, y, n, m, d, uv, yv, figure(1));

sys1

%% Estimate second-order model (q^2 + a_1q + a_2) y(k) = (b_0q^2 + b_1a + b_2) q^{-d} u(k) + q^2e(k)
% \hat{y}(k+1) = -a_1y(k) - a_2y(k-1) +  b_0u(k+1-d) + b_1u(k-d) + b_2u(k-1-d) 
%              = [-y(k) -y(k-1) u(k+1-d) u(k-d) u(k-1-d) ] * [a_1; a_2; b_0; b_1; b_2]
n = 2;
m = 1;
d = 0;

[sys2, resid2, resval2, rms2, fit2] = estimate_arx(u, y, n, m, d, uv, yv, figure(2));
sys2

%% Estimate second-order model (q^2 + a_1q + a_2) y(k) = (b_0q^1 + b_1) q^{-0} u(k) + q^2e(k)
% \hat{y}(k+1) = -a_1y(k) - a_2y(k-1) +  b_0u(k) + b_1u(k-1) 
%              = [-y(k) -y(k-1) u(k) u(k-1) ] * [a_1; a_2; b_0; b_1]
n = 2;
m = 1;
d = 0;

[sys2, resid2, resval2, rms2, fit2] = estimate_arx(u, y, n, m, d, uv, yv, figure(2));
sys2

%% Estimate second-order model (q^2 + a_1q + a_2) y(k) = (b_0q^2 + b_1q+ b_2) q^{-0} u(k) + q^2e(k)
% \hat{y}(k+1) = -a_1y(k) - a_2y(k-1) +  b_0u(k+1) + b_1u(k) + b_2u(k-1) 
%              = [-y(k) -y(k-1) u(k+1) u(k) u(k-1) ] * [a_1; a_2; b_0; b_1;b_2]
n = 2;
m = 2;
d = 0;

[sys2b, resid2b, resval2b, rms2b, fit2b] = estimate_arx(u, y, n, m, d, uv, yv, figure(3));
sys2b

%% Estimate third-order model (q^3 + a_1q^2 + a_2q + a_3) y(k) = (b_0q^3 + b_1q^2+ b_2q + b_3) q^{-0} u(k) + q^3e(k)
% \hat{y}(k+1) = -a_1y(k) - a_2y(k-1) +  b_0u(k+1) + b_1u(k) + b_2u(k-1) 
%              = [-y(k) -y(k-1) u(k+1) u(k) u(k-1) ] * [a_1; a_2; b_0; b_1;b_2]
n = 3;
m = 3;
d = 0;

[sys3, resid3, resval3, rms3, fit3] = estimate_arx(u, y, n, m, d, uv, yv, figure(4));
sys3


% Exercise quiz 1
z = tf('z', 1);
G1 = 0.5/(z-0.7);

Ge = 1/(z-0.7);


% Generate identification data
sigma = 0.08;
N = 400;
uu = idinput(N, 'prbs');
e = sigma*randn(size(uu));
yy = lsim(G1, uu) +  lsim(Ge, e);

save('exc2_data.mat', 'uu', 'yy');

dtaa = iddata(yy,uu, 1);
arx1=arx(dtaa, [1, 1, 1])

% Exercise quiz 2
z = tf('z', 1);
G2 = (z+0.9)/(z-0.8+1j*0.2)/(z-0.8-1j*0.2)
G2e = 1/(z-0.8+1j*0.2)/(z-0.8-1j*0.2);


% Generate identification data
sigma = 0.1;
N = 4000;
uu2 = idinput(N, 'prbs');
e2 = sigma*randn(size(uu2));
yy2 = lsim(G2, uu2) +  lsim(G2e, e2);

save('exc3_data.mat', 'uu2', 'yy2');

dtaa21 = iddata(yy2,uu2, 1);
arx21=arx(dtaa2, [2, 2, 1])



