octave --eval "pkg load control; G=tf([1], [0.5, 1, 0]);; [mag,phi,w]=bode(G,{0.1, 10}); disp(cat(2,w',mag2db(mag)))"
