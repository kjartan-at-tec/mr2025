%% Root locus example motor driving shaft

s = tf('s');
G = (s+1)/(s*(s^2+s+1))
F = (2*s+1)

figure(1)
clf
rlocus(G*F)

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14)
print('shaft-rlocus.pdf', '-dpdf')

F = (s+1)

figure(2)
clf
rlocus(G*F)
