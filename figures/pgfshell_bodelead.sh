octave --eval "pkg load control; G0=tf([10*1, 1],[1, 1]); [mag,phi,w]=bode(G0, {0.005, 50}); disp(cat(2,w',phi))"
