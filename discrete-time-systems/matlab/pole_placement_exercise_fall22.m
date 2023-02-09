%% MR2025 fall 2022
% Generate step plots

zero = -0.95;
poles = [1, 0.9,
    0.5, 1.2,
    0.6, 0.6,
    0.9 + 0.3*1j , 0.9-0.3*1j,
    0.8*1j, -0.8*1j];


tvec = (0:1:40)';
ys = zeros(length(tvec), 5);
for i=1:size(poles,1)
    p = poles(i,:);
    G = zpk(zero, p, 1, 1);
    dcg = dcgain(G);
    if ~isinf(dcg)
        G = G/abs(dcg);
    end
    G
    figure(i)
    clf
    subplot(121)
    pzmap(G)
    subplot(122)
    step(G)
    [ys(:,i), t] = step(G, tvec);
end

fname = 'pole-placement-exercise-step-plot-fall22.dta';
dlmwrite(fname, cat(2, t, ys));
