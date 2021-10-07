octave --eval "pkg load control; G0=tf([1], [1, 1, 0]);; [mag,phi,w]=bode(G0, {0.1, 10}); disp(cat(2,w',phi))"
