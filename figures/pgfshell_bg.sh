octave -q --eval "format long; pkg load control; G=tf([3],[(1/2)^2, 1/2, 3]); [mag,phi,w]=bode(G); disp(cat(2,w',phi))"
