octave --eval "pkg load control; G0=10*tf([1], [1, 2, 1]);; [mag,phi,w]=bode(G0); disp(cat(2,w',mag2db(mag)))"
