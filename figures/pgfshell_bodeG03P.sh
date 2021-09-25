octave --eval "pkg load control; G0=tf([4* 2, 1], [2, 1]);; [mag,phi,w]=bode(G0,{0.001, 1000}); disp(cat(2,w',phi))"
