octave -q --eval "format long; pkg load control; G=zpk([],[-0.1, -1, -2], 4); Gc=feedback(G, 1); [mag,phi,w]=bode(Gc); disp(cat(2,w',mag2db(mag)))"
