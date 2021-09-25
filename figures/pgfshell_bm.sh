octave -q --eval "format long; pkg load control; G=feedback(zpk([],[-0.1, -1, -2], 4),1); t=linspace(0, 2*25.133, 600); phi=0/180*pi; u=sin(1*t-phi); [y, tt] = lsim(G, u, t); disp(cat(2,tt(300:end)-25.133,1*y(300:end)))"
