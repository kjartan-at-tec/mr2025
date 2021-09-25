octave --eval "pkg load control; G0=1/0.1* tf([0.1* 0.2, 1], [0.2, 1]);; [mag,phi,w]=bode(G0,{0.01, 1000}); disp(cat(2,w',mag2db(mag)))"
