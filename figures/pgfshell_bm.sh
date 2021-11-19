octave -q --eval "format long; pkg load control; G=tf([3],[(1/2)^2, 1/2, 3]); t=linspace(0, 2*8, 600); phi=0/180*pi; u=sin(12*t-phi); [y, tt] = lsim(G, u, t); disp(cat(2,tt(300:end)-8,1*y(300:end)))"
