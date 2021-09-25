octave --eval "pkg load control; G=6.1*tf([1], [1, 1, 0]);; Gc=feedback(G,1); [mag,phi,w]=bode(Gc); disp(cat(2,w',mag2db(mag)))"
