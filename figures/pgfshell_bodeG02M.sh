octave --eval "pkg load control; G0=6.1*tf([1], [1, 1, 0]);; [mag,phi,w]=bode(G0); disp(cat(2,w',mag2db(mag)))"
