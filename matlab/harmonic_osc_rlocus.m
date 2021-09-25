%% Harmonic oscillator lead compensator root locus

s = tf('s');
G = 1/(s^2 + 1)

F = (2*s+1)/(s+2)

figure(3)
clf
rlocus(G*F)

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14)
print('oscillator-rlocus.pdf', '-dpdf')
