octave -q --eval "format long; pkg load control; G=feedback(zpk([],[-0.1, -1, -2], 4),1); [mag,phi,w]=bode(G); disp(cat(2,w',phi))"
