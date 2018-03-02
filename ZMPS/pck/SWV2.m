close all; clear all; clc;

N = 512;
sig = fmlin(N, 0.015, 0.025) + fmlin(N, 0.025, 0.035) + ...
    fmlin(N, 0.015, 0.005) + fmconst(N, 0.005);

[S, T, F] = tfrspwv(sig, 1:length(sig), 2*N, hamming(odd(350)), hamming(odd(400)));
figure(1); imagesc(T, F, S); colorbar
ylim([0 0.05]);
set(gca, 'Ydir', 'normal'); %kierunek osi F