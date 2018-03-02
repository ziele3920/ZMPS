close all; clear all; clc;

atomsCoords = [64 0.15 32 1; 64 0.35 32 1;
                192 0.15 32 1; 192 0.35 32 1];
N = 256;
x = atoms(N, atomsCoords, false);
[S0, T, F]= tfrspwv(x);
figure(1); imagesc(T, F, S0); colorbar
set(gca, 'Ydir', 'normal'); %kierunek osi F

[S, T, F] = tfrspwv(x, 0:length(x), N, hamming(odd(N/21)), hamming(odd(N/3))); %zapis reprezenacji do zmiennej
figure(2); imagesc(T, F, S); colorbar
set(gca, 'Ydir', 'normal'); %kierunek osi F

