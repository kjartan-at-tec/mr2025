octave --eval "pkg load control; G=tf([1], [1, 1, 0]);; Flag=1/0.1*tf([0.1*16, 1],[16, 1]); F=2.24*tf([4*0.25, 1],[0.25, 1]); [mag,phi,w]=bode(G*F*Flag, {0.1, 10}); disp(cat(2,w',phi))"
